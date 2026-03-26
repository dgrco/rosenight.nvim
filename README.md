# rosenight.nvim

A delightful set of warm Neovim colorschemes.

![neovim](https://img.shields.io/badge/neovim-0.8+-green?style=flat-square)
![license](https://img.shields.io/badge/license-MIT-blue?style=flat-square)

## Palletes
<!-- PALETTES_START -->
<details>
<summary><strong>main</strong></summary>

| Role       | Color                                                                  | Hex       |
|------------|------------------------------------------------------------------------|--------|
| bg0        | ![#1a1b26](https://placehold.co/12x12/1a1b26/1a1b26.png) Background   | `#1a1b26` |
| bg1        | ![#1f2335](https://placehold.co/12x12/1f2335/1f2335.png) Cursorline   | `#1f2335` |
| bg2        | ![#24283b](https://placehold.co/12x12/24283b/24283b.png) Floating windows | `#24283b` |
| bg3        | ![#292e42](https://placehold.co/12x12/292e42/292e42.png) Selection / visual | `#292e42` |
| bg4        | ![#3b4261](https://placehold.co/12x12/3b4261/3b4261.png) UI chrome / borders | `#3b4261` |
| fg0        | ![#e0def4](https://placehold.co/12x12/e0def4/e0def4.png) Bright text  | `#e0def4` |
| fg1        | ![#e0def4](https://placehold.co/12x12/e0def4/e0def4.png) Normal text  | `#e0def4` |
| fg2        | ![#908caa](https://placehold.co/12x12/908caa/908caa.png) Subtle text  | `#908caa` |
| fg3        | ![#6e6a86](https://placehold.co/12x12/6e6a86/6e6a86.png) Comments / dim | `#6e6a86` |
| red        | ![#eb6f92](https://placehold.co/12x12/eb6f92/eb6f92.png) Keywords     | `#eb6f92` |
| orange     | ![#ea9a97](https://placehold.co/12x12/ea9a97/ea9a97.png) Types / builtins / constants | `#ea9a97` |
| yellow     | ![#f6c177](https://placehold.co/12x12/f6c177/f6c177.png) Strings / return types | `#f6c177` |
| green      | ![#9ccfd8](https://placehold.co/12x12/9ccfd8/9ccfd8.png) Functions    | `#9ccfd8` |
| cyan       | ![#9ccfd8](https://placehold.co/12x12/9ccfd8/9ccfd8.png) Imports / interfaces | `#9ccfd8` |
| blue       | ![#3e8fb0](https://placehold.co/12x12/3e8fb0/3e8fb0.png) Tags / directories | `#3e8fb0` |
| purple     | ![#c4a7e7](https://placehold.co/12x12/c4a7e7/c4a7e7.png) Numbers / booleans | `#c4a7e7` |
| pink       | ![#eb6f92](https://placehold.co/12x12/eb6f92/eb6f92.png) Operators / punctuation | `#eb6f92` |
| err        | ![#eb6f92](https://placehold.co/12x12/eb6f92/eb6f92.png) Error        | `#eb6f92` |
| warn       | ![#f6c177](https://placehold.co/12x12/f6c177/f6c177.png) Warning      | `#f6c177` |
| info       | ![#9ccfd8](https://placehold.co/12x12/9ccfd8/9ccfd8.png) Info         | `#9ccfd8` |
| hint       | ![#3e8fb0](https://placehold.co/12x12/3e8fb0/3e8fb0.png) Hint         | `#3e8fb0` |
| added      | ![#9ccfd8](https://placehold.co/12x12/9ccfd8/9ccfd8.png) Added        | `#9ccfd8` |
| changed    | ![#f6c177](https://placehold.co/12x12/f6c177/f6c177.png) Changed      | `#f6c177` |
| removed    | ![#eb6f92](https://placehold.co/12x12/eb6f92/eb6f92.png) Removed      | `#eb6f92` |

</details>
<!-- PALETTES_END -->

## Requirements

- Neovim 0.8+
- `termguicolors` enabled (the plugin sets this for you)

## Installation

**lazy.nvim:**
```lua
{
  "dgrco/rosenight.nvim",
  priority = 1000,
  config = function()
    require("rosenight").setup({...}) -- See Default Configuration
    vim.cmd("colorscheme rosenight")
  end,
}
```

## Default Configuration

```lua
require("rosenight").setup({
  variant = "main", -- "main"
  italics = false, -- enable italics on keywords, types, comments
  bold = true,
})
```

Options must be set before calling `vim.cmd("colorscheme rosenight")`, or passed through `setup()` which applies the colorscheme immediately.

## Plugin support

Rosenight ships highlight groups for:

- **Treesitter** — full `@` capture group coverage
- **LSP** — diagnostics, inlay hints, code lens, semantic tokens
- **Telescope** / **fzf-lua**
- **mini.nvim** — statusline, tabline, files, pick, icons, clue, diff, notify, indentscope, jump, surround, cursorword, trailspace, operators, completion
- **nvim-cmp** / **blink.cmp**
- **Lualine** / **Heirline**
- **nvim-tree** / **neo-tree**
- **Gitsigns**
- **indent-blankline** / **ibl**
- **Noice**
- **Which-key**
- **nvim-dap** / **nvim-dap-ui**
- **Trouble**
- **Lazy.nvim**
- **Mason**
- **render-markdown**
- **Aerial**
- **vim-illuminate**
- **Flash** / **Hop** / **Leap**
- **nvim-notify**
- **Snacks.nvim**
- **Alpha** / **Dashboard**

## Terminal themes

Ready-to-use themes for terminal emulators are in the `extras/` directory:

| File | Terminal |
|------|----------|
| `extras/{variant}-kitty.conf` | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| `extras/{variant}-alacritty.toml` | [Alacritty](https://alacritty.org/) |
| `extras/{variant}-foot.ini` | [Foot](https://codeberg.org/dnkl/foot) |

### Kitty
Copy or symlink `extras/{variant}-kitty.conf` to `~/.config/kitty/themes/{variant}.conf` and add to `kitty.conf`:
```
include themes/{variant}.conf
```

### Alacritty
Copy `extras/{variant}-alactitty.toml` to `~/.config/alacritty/themes/{variant}.toml` and add to `alacritty.toml`:
```toml
import = ["~/.config/alacritty/themes/{variant}.toml"]
```

### Foot
Copy `extras/{variant}-foot.ini` to `~/.config/foot/themes/{variant}` and add to `foot.ini`:
```ini
[colors]
include=~/.config/foot/themes/{variant}
```

## Development

The palettes are defined in `lua/rosenight/palettes/{variant}.ini`. The files `lua/rosenight/palettes/{variant}.lua` and everything in `extras/` are autogenerated — do not edit them directly.

To create a new variant, simply create a new `{variant}.ini` in the `palettes/` folder. Copy an existing palette so the file is structured correctly.
Make sure the keys are the same as in existing palettes.

After creating or changing a palette, generate associated files with:
```sh
python3 scripts/generate.py
```

Requires Python 3 and no external dependencies.
