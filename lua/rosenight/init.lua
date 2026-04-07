local M = {}

M.config = { italics = true, bold = true, variant = "main" }

M.setup = function(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})
  M.load()
end

M.load = function()
  local italics = M.config.italics or false
  local bolds   = M.config.bold   or false

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "rosenight"

  -- ── Palette ───────────────────────────────────────────────────────────────
  local p = require("rosenight.palettes." .. M.config.variant)

  -- ── Helpers ───────────────────────────────────────────────────────────────
  -- hi(group, fg, bg, attr?, sp?)
  -- attr is a comma-separated string, e.g. "bold,italic"
  local hi = function(group, fg, bg, attr, sp)
    local opts_hi = {}
    if fg   and fg   ~= p.none then opts_hi.fg = fg   end
    if bg   and bg   ~= p.none then opts_hi.bg = bg   end
    if sp   and sp   ~= p.none then opts_hi.sp = sp   end
    if attr and attr ~= ""     then
      for _, a in ipairs(vim.split(attr, ",")) do
        opts_hi[vim.trim(a)] = true
      end
    end
    vim.api.nvim_set_hl(0, group, opts_hi)
  end

  -- Style atoms — compose with commas, e.g. italic .. "," .. bold
  local italic = italics and "italic" or ""
  local bold   = bolds   and "bold"   or ""

  -- Convenience combiners
  local bi = (bolds and italics) and "bold,italic" or (bolds and "bold" or (italics and "italic" or ""))

  -- ── Editor ────────────────────────────────────────────────────────────────
  hi("Normal",        p.fg1, p.bg0)
  hi("NormalFloat",   p.fg1, p.bg2)
  hi("NormalNC",      p.fg2, p.bg0)
  hi("FloatBorder",   p.bg4, p.bg2)
  hi("FloatTitle",    p.cyan,   p.bg2, bold)

  hi("Cursor",        p.bg0, p.fg0)
  hi("CursorIM",      p.bg0, p.fg0)
  hi("CursorLine",    p.none, p.bg1)
  hi("CursorColumn",  p.none, p.bg1)
  hi("CursorLineNr",  p.fg1,    p.none, bold)

  hi("LineNr",        p.fg3)
  hi("SignColumn",    p.fg1)
  hi("ColorColumn",   p.none, p.bg1)
  hi("FoldColumn",    p.bg4, p.bg0)
  hi("Folded",        p.fg1, p.bg2)

  hi("Visual",        p.none, p.bg3)
  hi("VisualNOS",     p.none, p.bg3)
  hi("Search",        p.fg1, p.yellow)
  hi("IncSearch",     p.bg0, p.yellow)
  hi("CurSearch",     p.bg0, p.yellow)
  hi("Substitute",    p.bg0, p.yellow)

  hi("StatusLine",    p.fg2, p.bg2)
  hi("StatusLineNC",  p.fg3, p.bg2)
  hi("WinSeparator",  p.bg4, p.none)
  hi("VertSplit",     p.bg4, p.none)

  hi("TabLine",       p.fg2, p.bg2)
  hi("TabLineFill",   p.none, p.bg1)
  hi("TabLineSel",    p.fg1, p.bg2, bold)

  hi("Pmenu",         p.fg2, p.bg2)
  hi("PmenuSel",      p.fg1, p.bg3)
  hi("PmenuSbar",     p.none, p.bg2)
  hi("PmenuThumb",    p.none, p.bg4)
  hi("PmenuExtra",    p.fg3, p.bg2)
  hi("PmenuExtraSel", p.fg2, p.bg3)

  hi("WildMenu",      p.bg0, p.yellow)
  hi("Directory",     p.cyan,   p.none, bold)

  hi("Title",         p.cyan,   p.none, bold)
  hi("MoreMsg",       p.purple)
  hi("Question",      p.yellow)
  hi("ModeMsg",       p.fg2)
  hi("MsgArea",       p.fg2)
  hi("MsgSeparator",  p.fg3, p.bg2)
  hi("ErrorMsg",      p.err, p.none)
  hi("WarningMsg",    p.warn, p.none)

  hi("MatchParen",    p.blue, p.bg4)
  hi("NonText",       p.fg3)
  hi("Whitespace",    p.bg3)
  hi("SpecialKey",    p.cyan)
  hi("EndOfBuffer",   p.fg3)
  hi("Conceal",       p.fg3)
  hi("SpellBad",      p.none, p.none, "undercurl", p.fg2)
  hi("SpellCap",      p.none, p.none, "undercurl", p.fg2)
  hi("SpellRare",     p.none, p.none, "undercurl", p.fg2)
  hi("SpellLocal",    p.none, p.none, "undercurl", p.fg2)

  hi("DiffAdd",       p.added,   p.none)
  hi("DiffChange",    p.changed, p.none)
  hi("DiffDelete",    p.removed, p.none)
  hi("DiffText",      p.fg0, p.bg3, bold)

  hi("QuickFixLine",  p.none, p.bg2)
  hi("qfLineNr",      p.cyan)
  hi("qfFileName",    p.blue)

  -- ── Syntax (legacy vim groups) ────────────────────────────────────────────

  -- Comments
  hi("Comment",         p.fg2, p.none, italic)
  hi("SpecialComment",  p.purple)

  -- Literals
  hi("Constant",   p.yellow)
  hi("String",     p.yellow)
  hi("Character",  p.yellow)
  hi("Number",     p.yellow)
  hi("Boolean",    p.orange)
  hi("Float",      p.yellow)

  -- Identifiers
  hi("Identifier", p.fg1)
  hi("Function",   p.orange)

  -- Statements & keywords
  hi("Statement",   p.blue, p.none, bold)
  hi("Conditional", p.blue)
  hi("Repeat",      p.blue)
  hi("Label",       p.cyan)
  hi("Operator",    p.fg2)
  hi("Keyword",     p.blue)
  hi("Exception",   p.blue)

  -- Preprocessor
  hi("PreProc",   p.purple)
  hi("Include",   p.blue)
  hi("Define",    p.purple)
  hi("Macro",     p.purple)
  hi("PreCondit", p.purple)

  -- Types
  hi("Type",         p.cyan)
  hi("StorageClass", p.cyan)
  hi("Structure",    p.cyan)
  hi("Typedef",      p.cyan)

  -- Specials
  hi("Special",      p.cyan)
  hi("SpecialChar",  p.cyan)
  hi("Tag",          p.cyan)
  hi("Delimiter",    p.fg2)
  hi("Debug",        p.orange)

  hi("Underlined", p.purple, p.none, "underline")
  hi("Ignore",     p.fg3)
  hi("Error",      p.err, p.none, bold)
  hi("Todo",       p.bg0, p.orange)

  -- ── Treesitter ────────────────────────────────────────────────────────────
  -- Variables
  hi("@variable",           p.fg1, p.none, italic)
  hi("@variable.builtin",   p.red, p.none, bi)
  hi("@variable.parameter", p.purple, p.none, italic)
  hi("@variable.member",    p.cyan)

  -- Constants
  hi("@constant",         p.yellow)
  hi("@constant.builtin", p.yellow, p.none, bold)
  hi("@constant.macro",   p.yellow)

  hi("@module",         p.fg1)
  hi("@module.builtin", p.fg1, p.none, bold)
  hi("@label",          p.cyan)

  -- Strings
  hi("@string",                p.yellow)
  hi("@string.regexp",         p.purple)
  hi("@string.escape",         p.blue)
  hi("@string.special",        p.yellow)
  hi("@string.special.symbol", p.fg1)

  hi("@character",         p.yellow)
  hi("@character.special", p.yellow)
  hi("@boolean",           p.orange)
  hi("@number",            p.yellow)
  hi("@number.float",      p.yellow)

  hi("@type",            p.cyan)
  hi("@type.builtin",    p.cyan, p.none, bold)
  hi("@type.definition", p.cyan)

  hi("@attribute",         p.cyan)
  hi("@attribute.builtin", p.purple, p.none, bold)
  hi("@property",          p.cyan, p.none, italic)

  hi("@function",             p.orange)
  hi("@function.builtin",     p.orange, p.none, bold)
  hi("@function.call",        p.orange)
  hi("@function.macro",       p.orange)
  hi("@function.method",      p.orange)
  hi("@function.method.call", p.purple)

  hi("@constructor", p.cyan)
  hi("@operator",    p.fg2)

  -- Keywords
  hi("@keyword",                  p.blue)
  hi("@keyword.coroutine",        p.blue)
  hi("@keyword.function",         p.blue)
  hi("@keyword.operator",         p.fg2)
  hi("@keyword.import",           p.blue)
  hi("@keyword.storage",          p.cyan)
  hi("@keyword.modifier",         p.blue)
  hi("@keyword.repeat",           p.blue)
  hi("@keyword.return",           p.blue)
  hi("@keyword.debug",            p.orange)
  hi("@keyword.exception",        p.blue)
  hi("@keyword.conditional",      p.blue)
  hi("@keyword.directive",        p.purple)
  hi("@keyword.directive.define", p.purple)

  hi("@punctuation.delimiter", p.fg2)
  hi("@punctuation.bracket",   p.fg2)
  hi("@punctuation.special",   p.fg2)

  -- Comments
  hi("@comment",               p.fg2, p.none, italic)
  hi("@comment.documentation", p.fg2, p.none, italic)
  hi("@comment.error",         p.err)
  hi("@comment.warning",       p.warn)
  hi("@comment.todo",          p.bg0, p.orange)
  hi("@comment.note",          p.bg0, p.blue)

  -- Markup (markdown / vimdoc / etc.)
  hi("@markup.strong",         p.none, p.none, bold)
  hi("@markup.italic",         p.none, p.none, "italic")
  hi("@markup.strikethrough",  p.none, p.none, "strikethrough")
  hi("@markup.underline",      p.none, p.none, "underline")
  hi("@markup.heading",        p.cyan, p.none, bold)
  hi("@markup.heading.1",      p.purple, p.none, bold)
  hi("@markup.heading.2",      p.cyan, p.none, bold)
  hi("@markup.heading.3",      p.orange, p.none, bold)
  hi("@markup.heading.4",      p.yellow, p.none, bold)
  hi("@markup.heading.5",      p.blue,   p.none, bold)
  hi("@markup.heading.6",      p.cyan,   p.none, bold)
  hi("@markup.quote",          p.fg1)
  hi("@markup.math",           p.purple)
  hi("@markup.link",           p.purple, p.none, "underline")
  hi("@markup.link.label",     p.cyan)
  hi("@markup.link.url",       p.purple, p.none, "underline")
  hi("@markup.raw",            p.fg1)
  hi("@markup.raw.block",      p.fg1)
  hi("@markup.list",           p.blue)
  hi("@markup.list.checked",   p.cyan)
  hi("@markup.list.unchecked", p.fg1)

  hi("@diff.plus",  p.added)
  hi("@diff.minus", p.removed)
  hi("@diff.delta", p.changed)

  hi("@tag",           p.cyan)
  hi("@tag.attribute", p.purple)
  hi("@tag.delimiter", p.fg2)

  -- ── LSP ───────────────────────────────────────────────────────────────────
  hi("LspReferenceText",            p.none, p.bg3)
  hi("LspReferenceRead",            p.none, p.bg3)
  hi("LspReferenceWrite",           p.none, p.bg3, bold)
  hi("LspSignatureActiveParameter", p.none, p.bg3, bold)
  hi("LspCodeLens",                 p.fg2, p.none, italic)
  hi("LspCodeLensSeparator",        p.fg3)
  hi("LspInlayHint",                p.fg3, p.bg1, italic)

  -- Diagnostics
  hi("DiagnosticError",            p.err)
  hi("DiagnosticWarn",             p.warn)
  hi("DiagnosticInfo",             p.info)
  hi("DiagnosticHint",             p.hint)
  hi("DiagnosticOk",               p.green)
  hi("DiagnosticVirtualTextError", p.err,  p.bg1)
  hi("DiagnosticVirtualTextWarn",  p.warn, p.bg1)
  hi("DiagnosticVirtualTextInfo",  p.info, p.bg1)
  hi("DiagnosticVirtualTextHint",  p.hint, p.bg1)
  hi("DiagnosticUnderlineError",   p.none, p.none, "undercurl", p.err)
  hi("DiagnosticUnderlineWarn",    p.none, p.none, "undercurl", p.warn)
  hi("DiagnosticUnderlineInfo",    p.none, p.none, "undercurl", p.info)
  hi("DiagnosticUnderlineHint",    p.none, p.none, "undercurl", p.hint)
  hi("DiagnosticFloatingError",    p.err)
  hi("DiagnosticFloatingWarn",     p.warn)
  hi("DiagnosticFloatingInfo",     p.info)
  hi("DiagnosticFloatingHint",     p.hint)
  hi("DiagnosticSignError",        p.err)
  hi("DiagnosticSignWarn",         p.warn)
  hi("DiagnosticSignInfo",         p.info)
  hi("DiagnosticSignHint",         p.hint)
  hi("DiagnosticDeprecated",       p.none, p.none, "strikethrough")

  -- Semantic tokens
  hi("@lsp.type.class",         p.cyan)
  hi("@lsp.type.decorator",     p.cyan)
  hi("@lsp.type.enum",          p.cyan)
  hi("@lsp.type.enumMember",    p.yellow)
  hi("@lsp.type.function",      p.orange)
  hi("@lsp.type.interface",     p.cyan)
  hi("@lsp.type.macro",         p.purple)
  hi("@lsp.type.method",        p.cyan)
  hi("@lsp.type.namespace",     p.blue)
  hi("@lsp.type.parameter",     p.purple, p.none, italic)
  hi("@lsp.type.property",      p.cyan, p.none, italic)
  hi("@lsp.type.struct",        p.cyan)
  hi("@lsp.type.type",          p.cyan)
  hi("@lsp.type.typeParameter", p.cyan)
  hi("@lsp.type.variable",      p.fg1)
  hi("@lsp.typemod.keyword.documentation", p.blue)

  -- ── Telescope ─────────────────────────────────────────────────────────────
  hi("TelescopeBorder",        p.bg4,    p.bg2)
  hi("TelescopeTitle",         p.cyan,   p.bg2, bold)
  hi("TelescopePromptBorder",  p.bg4,    p.bg1)
  hi("TelescopePromptTitle",   p.cyan,   p.bg1, bold)
  hi("TelescopePromptNormal",  p.fg0,    p.bg1)
  hi("TelescopePromptPrefix",  p.fg2,    p.bg1)
  hi("TelescopePreviewBorder", p.bg4,    p.bg0)
  hi("TelescopePreviewTitle",  p.cyan,   p.bg0, bold)
  hi("TelescopeNormal",        p.fg1,    p.bg2)
  hi("TelescopeResultsBorder", p.bg4,    p.bg2)
  hi("TelescopeResultsTitle",  p.cyan,   p.bg2, bold)
  hi("TelescopeSelection",     p.fg1,    p.bg3)
  hi("TelescopeSelectionCaret",p.orange, p.bg3)
  hi("TelescopeMultiSelection",p.purple, p.bg3)
  hi("TelescopeMultiIcon",     p.pink,   p.bg3)
  hi("TelescopeMatching",      p.orange)

  -- ── fzf-lua ───────────────────────────────────────────────────────────────
  hi("FzfLuaNormal",        p.fg1,    p.bg0)
  hi("FzfLuaBorder",        p.bg4,    p.bg0)
  hi("FzfLuaTitle",         p.cyan,   p.bg0, bold)
  hi("FzfLuaPreviewNormal", p.fg1,    p.bg0)
  hi("FzfLuaPreviewBorder", p.bg4,    p.bg0)
  hi("FzfLuaPreviewTitle",  p.cyan,   p.bg0, bold)
  hi("FzfLuaCursorLine",    p.none,   p.bg2)
  hi("FzfLuaCursorLineNr",  p.orange, p.bg2)
  hi("FzfLuaSearch",        p.bg0,    p.yellow, bold)
  hi("FzfLuaSel",           p.fg0,    p.bg2,    bold)
  hi("FzfLuaSelBorder",     p.bg4,    p.bg2)
  hi("FzfLuaMatch",         p.yellow, p.none,   bold)
  hi("FzfLuaHeaderBind",    p.orange)
  hi("FzfLuaHeaderText",    p.red)

  -- ── mini.nvim ─────────────────────────────────────────────────────────────
  hi("MiniStatuslineModeNormal",  p.bg0, p.orange, bold)
  hi("MiniStatuslineModeInsert",  p.bg0, p.cyan,   bold)
  hi("MiniStatuslineModeVisual",  p.bg0, p.purple, bold)
  hi("MiniStatuslineModeReplace", p.bg0, p.blue,   bold)
  hi("MiniStatuslineModeCommand", p.bg0, p.yellow, bold)
  hi("MiniStatuslineModeOther",   p.bg0, p.cyan,   bold)
  hi("MiniStatuslineDevinfo",     p.fg2, p.bg3)
  hi("MiniStatuslineFilename",    p.fg1, p.bg2)
  hi("MiniStatuslineFileinfo",    p.fg2, p.bg3)
  hi("MiniStatuslineInactive",    p.fg3, p.bg1)

  hi("MiniTablineCurrent",         p.fg1,    p.bg3, bold)
  hi("MiniTablineVisible",         p.fg1,    p.bg2)
  hi("MiniTablineHidden",          p.fg2,    p.bg2)
  hi("MiniTablineModifiedCurrent", p.yellow, p.bg0, bold)
  hi("MiniTablineModifiedVisible", p.yellow, p.bg2)
  hi("MiniTablineModifiedHidden",  p.yellow, p.bg1)
  hi("MiniTablineFill",            p.none,   p.bg1)
  hi("MiniTablineTabpagesection",  p.fg1,    p.yellow)

  hi("MiniFilesBorder",        p.bg4,    p.bg2)
  hi("MiniFilesBorderModified",p.warn,   p.bg2)
  hi("MiniFilesCursorLine",    p.none,   p.bg3)
  hi("MiniFilesDirectory",     p.cyan,   p.none, bold)
  hi("MiniFilesFile",          p.fg1)
  hi("MiniFilesNormal",        p.fg1,    p.bg2)
  hi("MiniFilesTitle",         p.cyan,   p.bg2, bold)
  hi("MiniFilesTitleFocused",  p.orange, p.bg2, bold)

  hi("MiniPickBorder",         p.bg4,    p.bg2)
  hi("MiniPickBorderBusy",     p.yellow, p.bg2)
  hi("MiniPickBorderText",     p.yellow, p.bg2, bold)
  hi("MiniPickNormal",         p.fg1,    p.bg2)
  hi("MiniPickPrompt",         p.fg1,    p.bg2, bold)
  hi("MiniPickMatchCurrent",   p.fg0,    p.bg3, bold)
  hi("MiniPickMatchMarked",    p.purple, p.bg3)
  hi("MiniPickMatchRanges",    p.cyan)
  hi("MiniPickHeader",         p.purple, p.bg1)
  hi("MiniPickIconDirectory",  p.blue)
  hi("MiniPickIconFile",       p.fg1)

  hi("MiniDiffSignAdd",    p.added)
  hi("MiniDiffSignChange", p.changed)
  hi("MiniDiffSignDelete", p.removed)
  hi("MiniDiffOverAdd",    p.added,   p.bg1)
  hi("MiniDiffOverChange", p.changed, p.bg1)
  hi("MiniDiffOverDelete", p.removed, p.bg1)

  hi("MiniNotifyBorder",  p.bg4, p.bg2)
  hi("MiniNotifyNormal",  p.fg1, p.bg2)
  hi("MiniNotifyTitle",   p.cyan,   p.bg2, bold)

  hi("MiniSurround",              p.bg0, p.yellow)
  hi("MiniOperatorsExchangeFrom", p.none, p.bg3,   bold)
  hi("MiniTrailspace",            p.none, p.red)

  -- ── Lualine ───────────────────────────────────────────────────────────────
  hi("lualine_a_normal",  p.bg0, p.orange, bold)
  hi("lualine_a_insert",  p.bg0, p.cyan,   bold)
  hi("lualine_a_visual",  p.bg0, p.purple, bold)
  hi("lualine_a_replace", p.bg0, p.blue,   bold)
  hi("lualine_a_command", p.bg0, p.yellow, bold)
  hi("lualine_b_normal",  p.fg1, p.bg3)
  hi("lualine_c_normal",  p.fg2, p.bg2)

  -- ── Heirline ──────────────────────────────────────────────────────────────
  hi("HeirlineNormal",  p.bg0, p.orange, bold)
  hi("HeirlineInsert",  p.bg0, p.cyan,   bold)
  hi("HeirlineVisual",  p.bg0, p.purple, bold)
  hi("HeirlineReplace", p.bg0, p.blue,   bold)
  hi("HeirlineCommand", p.bg0, p.yellow, bold)

  -- ── nvim-cmp ──────────────────────────────────────────────────────────────
  hi("CmpItemAbbr",             p.fg2)
  hi("CmpItemAbbrMatch",        p.fg1, p.none, bold)
  hi("CmpItemAbbrMatchFuzzy",   p.fg1, p.none, bold)
  hi("CmpItemAbbrDeprecated",   p.fg3, p.none, "strikethrough")
  hi("CmpItemMenu",             p.fg3, p.none, italic)
  hi("CmpItemKindDefault",      p.fg2)
  hi("CmpItemKindKeyword",      p.blue)
  hi("CmpItemKindVariable",     p.fg1)
  hi("CmpItemKindConstant",     p.yellow)
  hi("CmpItemKindReference",    p.fg1)
  hi("CmpItemKindValue",        p.purple)
  hi("CmpItemKindFunction",     p.orange)
  hi("CmpItemKindConstructor",  p.cyan)
  hi("CmpItemKindMethod",       p.purple)
  hi("CmpItemKindClass",        p.cyan)
  hi("CmpItemKindInterface",    p.cyan)
  hi("CmpItemKindStruct",       p.cyan)
  hi("CmpItemKindEvent",        p.red)
  hi("CmpItemKindEnum",         p.cyan)
  hi("CmpItemKindUnit",         p.cyan)
  hi("CmpItemKindModule",       p.fg1)
  hi("CmpItemKindProperty",     p.fg1)
  hi("CmpItemKindField",        p.fg1)
  hi("CmpItemKindTypeParameter",p.cyan)
  hi("CmpItemKindEnumMember",   p.yellow)
  hi("CmpItemKindOperator",     p.fg2)
  hi("CmpItemKindSnippet",      p.yellow)
  hi("CmpItemKindText",         p.fg2)
  hi("CmpItemKindFile",         p.blue)
  hi("CmpItemKindFolder",       p.blue)
  hi("CmpItemKindColor",        p.pink)

  -- blink.cmp
  hi("BlinkCmpLabel",           p.fg3)
  hi("BlinkCmpLabelMatch",      p.fg1,    p.none, bold)
  hi("BlinkCmpLabelDeprecated", p.fg3, p.none, "strikethrough")
  hi("BlinkCmpLabelDetail",     p.fg3, p.none, italic)
  hi("BlinkCmpLabelDescription",p.fg3)
  hi("BlinkCmpKindDefault",     p.fg2)
  hi("BlinkCmpKindKeyword",     p.blue)
  hi("BlinkCmpKindVariable",    p.fg1)
  hi("BlinkCmpKindConstant",    p.yellow)
  hi("BlinkCmpKindFunction",    p.cyan)
  hi("BlinkCmpKindMethod",      p.cyan)
  hi("BlinkCmpKindClass",       p.cyan)
  hi("BlinkCmpKindInterface",   p.cyan)
  hi("BlinkCmpKindStruct",      p.cyan)
  hi("BlinkCmpKindEnum",        p.cyan)
  hi("BlinkCmpKindEnumMember",  p.cyan)
  hi("BlinkCmpKindSnippet",     p.yellow)
  hi("BlinkCmpKindText",        p.fg2)
  hi("BlinkCmpMenu",            p.fg1, p.bg2)
  hi("BlinkCmpMenuBorder",      p.bg4, p.bg2)
  hi("BlinkCmpMenuSelection",   p.fg0, p.bg3, bold)
  hi("BlinkCmpDoc",             p.fg1, p.bg2)
  hi("BlinkCmpDocBorder",       p.bg4, p.bg2)
  hi("BlinkCmpDocSeparator",    p.bg4, p.bg2)
  hi("BlinkCmpScrollBarThumb",  p.none, p.bg4)

  -- ── nvim-tree / neo-tree ──────────────────────────────────────────────────
  hi("NvimTreeNormal",          p.fg1, p.bg0)
  hi("NvimTreeNormalNC",        p.fg2, p.bg0)
  hi("NvimTreeRootFolder",      p.cyan,    p.none, bold)
  hi("NvimTreeFolderName",      p.cyan)
  hi("NvimTreeFolderIcon",      p.fg2)
  hi("NvimTreeOpenedFolderName",p.cyan)
  hi("NvimTreeEmptyFolderName", p.fg3)
  hi("NvimTreeIndentMarker",    p.bg4)
  hi("NvimTreeGitDirty",        p.changed)
  hi("NvimTreeGitStaged",       p.added)
  hi("NvimTreeGitMerge",        p.pink)
  hi("NvimTreeGitNew",          p.added)
  hi("NvimTreeGitDeleted",      p.removed)
  hi("NvimTreeSpecialFile",     p.fg1)
  hi("NvimTreeImageFile",       p.fg1)
  hi("NvimTreeSymlink",         p.cyan)
  hi("NvimTreeCursorLine",      p.none,    p.bg1)
  hi("NvimTreeWinSeparator",    p.bg4,     p.bg0)

  hi("NeoTreeNormal",        p.fg1, p.bg0)
  hi("NeoTreeNormalNC",      p.fg2, p.bg0)
  hi("NeoTreeRootName",      p.cyan,    p.none, bold)
  hi("NeoTreeDirectoryName", p.cyan)
  hi("NeoTreeDirectoryIcon", p.cyan)
  hi("NeoTreeFileName",      p.fg1)
  hi("NeoTreeDimText",       p.fg3)
  hi("NeoTreeIndentMarker",  p.bg4)
  hi("NeoTreeGitAdded",      p.added)
  hi("NeoTreeGitModified",   p.changed)
  hi("NeoTreeGitDeleted",    p.removed)
  hi("NeoTreeGitConflict",   p.purple,  p.none, bold)
  hi("NeoTreeGitUntracked",  p.fg2)
  hi("NeoTreeFloatBorder",   p.bg4,     p.bg2)
  hi("NeoTreeFloatTitle",    p.cyan,    p.bg2, bold)

  -- ── Gitsigns ──────────────────────────────────────────────────────────────
  hi("GitSignsAdd",              p.added)
  hi("GitSignsChange",           p.changed)
  hi("GitSignsDelete",           p.removed)
  hi("GitSignsAddNr",            p.added)
  hi("GitSignsChangeNr",         p.changed)
  hi("GitSignsDeleteNr",         p.removed)
  hi("GitSignsAddLn",            p.none, p.bg1)
  hi("GitSignsChangeLn",         p.none, p.bg1)
  hi("GitSignsDeleteLn",         p.none, p.bg1)
  hi("GitSignsCurrentLineBlame", p.fg3, p.none, italic)

  -- ── Indent guides ─────────────────────────────────────────────────────────
  hi("IndentBlanklineChar",        p.fg3)
  hi("IndentBlanklineSpaceChar",   p.fg3)
  hi("IndentBlanklineContextChar", p.fg2)
  hi("IblIndent",                  p.bg3)
  hi("IblScope",                   p.cyan)
  hi("IblWhitespace",              p.bg3)

  -- ── Noice ─────────────────────────────────────────────────────────────────
  hi("NoiceCmdlinePopup",       p.fg1,    p.bg2)
  hi("NoiceCmdlinePopupBorder", p.bg4,    p.bg2)
  hi("NoiceCmdlinePopupTitle",  p.cyan,   p.bg2, bold)
  hi("NoiceCmdlineIcon",        p.orange)
  hi("NoiceCmdlineIconSearch",  p.yellow)
  hi("NoiceConfirmBorder",      p.bg4,    p.bg2)
  hi("NoiceMini",               p.fg2,    p.bg1)
  hi("NoiceLspProgressSpinner", p.orange)
  hi("NoiceLspProgressTitle",   p.fg1)
  hi("NoiceLspProgressClient",  p.fg2)

  -- ── Which-key ─────────────────────────────────────────────────────────────
  hi("WhichKey",          p.purple)
  hi("WhichKeyGroup",     p.cyan)
  hi("WhichKeyDesc",      p.yellow)
  hi("WhichKeySeparator", p.fg2)
  hi("WhichKeyValue",     p.orange)
  hi("WhichKeyBorder",    p.bg4, p.bg2)
  hi("WhichKeyNormal",    p.fg1, p.bg2)
  hi("WhichKeyTitle",     p.cyan,   p.bg2, bold)

  -- ── nvim-dap / dap-ui ─────────────────────────────────────────────────────
  hi("DapBreakpoint",         p.red)
  hi("DapBreakpointCondition",p.orange)
  hi("DapBreakpointRejected", p.fg3)
  hi("DapLogPoint",           p.cyan)
  hi("DapStopped",            p.none, p.bg2)
  hi("DapStoppedLine",        p.none, p.bg2)

  hi("DapUIScope",                  p.cyan,   p.none, bold)
  hi("DapUIType",                   p.purple)
  hi("DapUIValue",                  p.fg1)
  hi("DapUIModifiedValue",          p.yellow, p.none, bold)
  hi("DapUIDecoration",             p.fg3)
  hi("DapUIThread",                 p.yellow)
  hi("DapUIStoppedThread",          p.cyan,  p.none, bold)
  hi("DapUISource",                 p.blue)
  hi("DapUILineNumber",             p.orange)
  hi("DapUIFloatBorder",            p.bg4, p.bg2)
  hi("DapUIWatchesEmpty",           p.fg3, p.none, italic)
  hi("DapUIWatchesValue",           p.yellow)
  hi("DapUIWatchesError",           p.err)
  hi("DapUIBreakpointsPath",        p.cyan)
  hi("DapUIBreakpointsInfo",        p.info)
  hi("DapUIBreakpointsCurrentLine", p.yellow, p.none, bold)
  hi("DapUIBreakpointsLine",        p.cyan)
  hi("DapUIBreakpointsFunctionName",p.fg1)
  hi("DapUICurrentFrameName",       p.yellow, p.none, bold)
  hi("DapUIStepOver",               p.cyan)
  hi("DapUIStepInto",               p.cyan)
  hi("DapUIStepBack",               p.cyan)
  hi("DapUIStepOut",                p.cyan)
  hi("DapUIStop",                   p.red)
  hi("DapUIPlayPause",              p.cyan)
  hi("DapUIRestart",                p.cyan)
  hi("DapUIUnavailable",            p.fg3)

  -- ── Trouble ───────────────────────────────────────────────────────────────
  hi("TroubleNormal",         p.fg1, p.bg0)
  hi("TroubleNormalNC",       p.fg2, p.bg0)
  hi("TroubleCount",          p.purple, p.bg2)
  hi("TroubleCode",           p.fg3, p.none, italic)
  hi("TroubleSource",         p.fg3)
  hi("TroublePos",            p.fg3)
  hi("TroubleTextError",      p.err)
  hi("TroubleTextWarning",    p.warn)
  hi("TroubleTextInformation",p.info)
  hi("TroubleTextHint",       p.hint)

  -- ── Lazy.nvim ─────────────────────────────────────────────────────────────
  hi("LazyNormal",        p.fg1, p.bg2)
  hi("LazyBorder",        p.bg4, p.bg2)
  hi("LazyButtonActive",  p.bg0, p.orange, bold)
  hi("LazyButton",        p.fg1, p.bg3)
  hi("LazyH1",            p.bg0, p.orange, bold)
  hi("LazyH2",            p.orange, p.none, bold)
  hi("LazyReasonPlugin",  p.purple)
  hi("LazyReasonEvent",   p.pink)
  hi("LazyReasonKeys",    p.yellow)
  hi("LazyReasonStart",   p.green)
  hi("LazyReasonSource",  p.cyan)
  hi("LazyReasonFt",      p.blue)
  hi("LazyReasonCmd",     p.orange)
  hi("LazyReasonImport",  p.fg2)
  hi("LazySpecial",       p.orange)
  hi("LazyHandlerEvent",  p.pink)
  hi("LazyHandlerKeys",   p.yellow)
  hi("LazyHandlerFt",     p.blue)
  hi("LazyHandlerPlugin", p.purple)
  hi("LazyProgressDone",  p.green, p.none, bold)
  hi("LazyProgressTodo",  p.fg3)
  hi("LazyCommit",        p.yellow)
  hi("LazyCommitType",    p.orange)
  hi("LazyCommitScope",   p.fg2, p.none, italic)
  hi("LazyCommitIssue",   p.pink)
  hi("LazyLocal",         p.orange)
  hi("LazyUrl",           p.blue, p.none, "underline")
  hi("LazyProp",          p.fg2)
  hi("LazyValue",         p.yellow)
  hi("LazyNoCond",        p.red)
  hi("LazyDimmed",        p.fg3)

  -- ── Mason ─────────────────────────────────────────────────────────────────
  hi("MasonNormal",             p.fg1,   p.bg2)
  hi("MasonHighlight",          p.orange)
  hi("MasonHighlightBlock",     p.bg0,   p.orange)
  hi("MasonHighlightBlockBold", p.bg0,   p.orange, bold)
  hi("MasonHeader",             p.bg0,   p.orange, bold)
  hi("MasonHeaderSecondary",    p.bg0,   p.cyan,   bold)
  hi("MasonMuted",              p.fg3)
  hi("MasonMutedBlock",         p.fg3,   p.bg3)
  hi("MasonMutedBlockBold",     p.fg2,   p.bg3, bold)
  hi("MasonError",              p.err)
  hi("MasonWarning",            p.warn)
  hi("MasonHeading",            p.orange, p.none, bold)

  -- ── Render-markdown ───────────────────────────────────────────────────────
  hi("RenderMarkdownH1Bg",       p.none, p.bg2)
  hi("RenderMarkdownH2Bg",       p.none, p.bg1)
  hi("RenderMarkdownH3Bg",       p.none, p.bg1)
  hi("RenderMarkdownBullet",     p.orange)
  hi("RenderMarkdownCode",       p.none,   p.bg2)
  hi("RenderMarkdownCodeInline", p.fg1,    p.bg2)
  hi("RenderMarkdownDash",       p.fg3)
  hi("RenderMarkdownLink",       p.blue,   p.none, "underline")
  hi("RenderMarkdownSign",       p.fg3,    p.bg0)
  hi("RenderMarkdownMath",       p.purple)
  hi("RenderMarkdownChecked",    p.cyan)
  hi("RenderMarkdownUnchecked",  p.fg2)
  hi("RenderMarkdownTodo",       p.bg0, p.yellow, bold)
  hi("RenderMarkdownNote",       p.bg0, p.info,   bold)
  hi("RenderMarkdownWarn",       p.bg0, p.warn,   bold)
  hi("RenderMarkdownDanger",     p.bg0, p.err,    bold)
  hi("RenderMarkdownInfo",       p.bg0, p.cyan,   bold)
  hi("RenderMarkdownHint",       p.bg0, p.hint,   bold)
  hi("RenderMarkdownSuccess",    p.bg0, p.green,  bold)
  hi("RenderMarkdownTableHead",  p.fg2, p.bg2)
  hi("RenderMarkdownTableRow",   p.fg2, p.bg0)
  hi("RenderMarkdownTableFill",  p.none, p.bg0)

  -- ── Aerial / Outline ──────────────────────────────────────────────────────
  hi("AerialLine",        p.none, p.bg2)
  hi("AerialLineNC",      p.none, p.bg1)
  hi("AerialNormal",      p.fg1,  p.bg0)
  hi("AerialClass",       p.cyan)
  hi("AerialFunction",    p.orange)
  hi("AerialMethod",      p.orange)
  hi("AerialConstructor", p.cyan)
  hi("AerialConstant",    p.yellow)
  hi("AerialField",       p.fg1)
  hi("AerialEnum",        p.cyan)
  hi("AerialInterface",   p.cyan)
  hi("AerialModule",      p.fg1)
  hi("AerialVariable",    p.fg1)
  hi("AerialProperty",    p.fg1)
  hi("AerialString",      p.yellow)
  hi("AerialNumber",      p.yellow)
  hi("AerialBoolean",     p.orange)
  hi("AerialStruct",      p.cyan)

  -- ── Illuminate ────────────────────────────────────────────────────────────
  hi("IlluminatedWordText",  p.none, p.bg3)
  hi("IlluminatedWordRead",  p.none, p.bg3)
  hi("IlluminatedWordWrite", p.none, p.bg3, bold)

  -- ── Flash / Hop / Leap ────────────────────────────────────────────────────
  hi("FlashLabel",          p.bg0, p.orange, bold)
  hi("FlashCurrent",        p.bg0, p.yellow, bold)
  hi("FlashMatch",          p.bg0, p.yellow, bold)
  hi("FlashBackdrop",       p.fg3)
  hi("HopNextKey",          p.bg0, p.orange, bold)
  hi("HopNextKey1",         p.bg0, p.yellow, bold)
  hi("HopNextKey2",         p.bg0, p.cyan,   bold)
  hi("HopUnmatched",        p.fg3)
  hi("LeapMatch",           p.bg0, p.yellow, bold)
  hi("LeapLabelPrimary",    p.bg0, p.orange, bold)
  hi("LeapLabelSecondary",  p.bg0, p.cyan,   bold)
  hi("LeapBackdrop",        p.fg3)

  -- ── Notify ────────────────────────────────────────────────────────────────
  hi("NotifyERRORBorder", p.err)
  hi("NotifyWARNBorder",  p.warn)
  hi("NotifyINFOBorder",  p.info)
  hi("NotifyDEBUGBorder", p.fg3)
  hi("NotifyTRACEBorder", p.purple)
  hi("NotifyERRORIcon",   p.err)
  hi("NotifyWARNIcon",    p.warn)
  hi("NotifyINFOIcon",    p.info)
  hi("NotifyDEBUGIcon",   p.fg3)
  hi("NotifyTRACEIcon",   p.purple)
  hi("NotifyERRORTitle",  p.err,    p.none, bold)
  hi("NotifyWARNTitle",   p.warn,   p.none, bold)
  hi("NotifyINFOTitle",   p.info,   p.none, bold)
  hi("NotifyDEBUGTitle",  p.fg3,    p.none, bold)
  hi("NotifyTRACETitle",  p.purple, p.none, bold)
  hi("NotifyERRORBody",   p.fg1)
  hi("NotifyWARNBody",    p.fg1)
  hi("NotifyINFOBody",    p.fg1)
  hi("NotifyDEBUGBody",   p.fg2)
  hi("NotifyTRACEBody",   p.fg2)

  -- ── Snacks ────────────────────────────────────────────────────────────────
  hi("SnacksNormal",           p.fg1,    p.bg2)
  hi("SnacksBorder",           p.bg4,    p.bg2)
  hi("SnacksTitle",            p.cyan,   p.bg2, bold)
  hi("SnacksBackdrop",         p.none,   p.bg0)
  hi("SnacksDashboardNormal",  p.fg1,    p.bg0)
  hi("SnacksDashboardDesc",    p.fg2)
  hi("SnacksDashboardFile",    p.blue)
  hi("SnacksDashboardDir",     p.fg3)
  hi("SnacksDashboardFooter",  p.fg3,    p.none, italic)
  hi("SnacksDashboardHeader",  p.yellow, p.none, bold)
  hi("SnacksDashboardIcon",    p.orange)
  hi("SnacksDashboardKey",     p.yellow)
  hi("SnacksDashboardSection", p.cyan,   p.none, bold)
  hi("SnacksDashboardSpecial", p.pink)
  hi("SnacksIndent",           p.bg3)
  hi("SnacksIndentScope",      p.bg4)
  hi("SnacksPickerNormal",     p.fg1,    p.bg2)
  hi("SnacksPickerBorder",     p.bg4,    p.bg2)
  hi("SnacksPickerTitle",      p.cyan,   p.bg2, bold)
  hi("SnacksPickerMatch",      p.yellow, p.none, bold)
  hi("SnacksPickerSelected",   p.fg0,    p.bg3, bold)
  hi("SnacksPickerDir",        p.fg3)

  -- ── Alpha / Dashboard ─────────────────────────────────────────────────────
  hi("AlphaHeader",   p.blue,   p.none, bold)
  hi("AlphaButtons",  p.cyan)
  hi("AlphaShortcut", p.orange)
  hi("AlphaFooter",   p.purple, p.none, italic)

  hi("DashboardHeader",   p.blue,   p.none, bold)
  hi("DashboardDesc",     p.fg2)
  hi("DashboardKey",      p.orange)
  hi("DashboardIcon",     p.yellow)
  hi("DashboardShortCut", p.red)
  hi("DashboardFooter",   p.fg3, p.none, italic)

  -- ── Terminal colours ──────────────────────────────────────────────────────
  vim.g.terminal_color_0  = p.bg3
  vim.g.terminal_color_1  = p.red
  vim.g.terminal_color_2  = p.blue
  vim.g.terminal_color_3  = p.yellow
  vim.g.terminal_color_4  = p.cyan
  vim.g.terminal_color_5  = p.purple
  vim.g.terminal_color_6  = p.orange
  vim.g.terminal_color_7  = p.fg1
  vim.g.terminal_color_8  = p.fg2
  vim.g.terminal_color_9  = p.red
  vim.g.terminal_color_10 = p.blue
  vim.g.terminal_color_11 = p.yellow
  vim.g.terminal_color_12 = p.cyan
  vim.g.terminal_color_13 = p.purple
  vim.g.terminal_color_14 = p.orange
  vim.g.terminal_color_15 = p.fg1
end

return M
