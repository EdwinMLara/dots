# dots

Configuración personal de **Neovim** + **tmux** para desarrollo. Este proyecto utiliza [lazy.nvim](https://github.com/folke/lazy.nvim) como gestor de plugins, [Mason](https://github.com/williamboman/mason.nvim) para instalar LSP servers, y está preparado para TypeScript, Go, Rust, Python, Lua, C/C++, HTML, CSS, JSON y YAML.

---

## Requisitos

- **macOS** con [Homebrew](https://brew.sh)
- **Neovim** ≥ 0.11
- **Git**
- [Ripgrep](https://github.com/BurntSushi/ripgrep) (para Telescope `live_grep`)
- **Nerd Font** (opcional, para icons en la UI)

---

## Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/tuusuario/dots.git ~/.config/nvim
```

### 2. Ejecutar el instalador

```bash
cd ~/.config/nvim && chmod +x install.sh && ./install.sh
```

Esto crea el enlace simbólico de tmux e instala las dependencias del `Brewfile`:

| Dependencia   | Propósito                          |
|---------------|------------------------------------|
| neovim        | Editor de texto                    |
| tmux          | Multiplexor de terminal            |
| lazygit       | UI visual para Git                 |
| ripgrep       | Búsqueda rápida (Telescope)        |
| node          | Runtime para LSP (TypeScript, etc) |
| ffind         | Búsqueda de archivos rápida        |
| zoxide        | Navegación de directorios          |
| gopls         | Go LSP server                      |
| vim           | Compatibilidad con scripts vim     |

### 3. Abrir Neovim

```bash
nvim
```

Los plugins se instalarán automáticamente al abrir Neovim.

### 4. Instalar LSP servers

Dentro de Neovim:

```vim
:Mason
```

Marca los servidores que quieras instalar, o ejecuta `:Lazy sync` para que `mason-lspconfig` instale automáticamente los definidos en `ensure_installed`:

- `lua_ls`, `ts_ls`, `pyright`, `gopls`, `rust_analyzer`, `clangd`, `html`, `cssls`, `jsonls`, `yamlls`

---

## Atajos de teclado

> `<leader>` es la **barra espaciadora**.

### Generales

| Atajo            | Acción                           |
|------------------|----------------------------------|
| `<leader>w`      | Guardar archivo                  |
| `<leader>wq`     | Guardar y cerrar                 |
| `<leader>qa`     | Cerrar todo                      |
| `<leader>e`      | Explorador de archivos (Netrw)   |
| `<leader>t`      | Terminal flotante (ToggleTerm)   |
| `<leader>h`      | Split horizontal                 |
| `<leader>v`      | Split vertical                   |
| `<leader>c`      | Cerrar split                     |

### Harpoon (marcadores de archivos)

| Atajo            | Acción                           |
|------------------|----------------------------------|
| `<leader>a`      | Marcar archivo actual            |
| `<leader>hh`     | Abrir menú de Harpoon            |
| `<leader>1-4`    | Ir al marcador 1-4               |
| `<leader>n`      | Siguiente marcador               |
| `<leader>p`      | Marcador anterior                |

### LSP (inteligencia de código)

| Atajo            | Acción                           |
|------------------|----------------------------------|
| `gd`             | Ir a definición                  |
| `gD`             | Ir a declaración                 |
| `gr`             | Ver referencias                  |
| `K`              | Documentación al pasar           |
| `<leader>rn`     | Renombrar símbolo                |
| `<leader>ca`     | Acciones de código               |
| `[d` / `]d`      | Error anterior / siguiente       |

### Telescope (búsqueda)

| Atajo            | Acción                           |
|------------------|----------------------------------|
| `<leader>ff`     | Buscar archivos                  |
| `<leader>fg`     | Buscar texto (live grep)         |
| `<leader>fb`     | Buscar buffers abiertos          |

### Git

| Atajo            | Acción                           |
|------------------|----------------------------------|
| `<leader>gg`     | Abrir LazyGit                    |
| `]g` / `[g`      | Siguiente / anterior hunk        |

### tmux + Neovim

| Atajo            | Acción                           |
|------------------|----------------------------------|
| `<c-h/j/k/l>`    | Navegar entre panes de tmux/vim  |

---

## Plugins y para qué sirve cada uno

### Gestor de plugins

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Gestor de plugins moderno con carga diferida (lazy loading) |

### Tema

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Tema de colores oscuro (Tokyo Night) |

### Syntax Highlighting

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Resaltado de sintaxis preciso e indentación automática |

### LSP (Language Server Protocol)

> Estos tres plugins trabajan juntos:

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Instalador de LSP servers, linters y formatters        |
| [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim) | Puente entre Mason y lspconfig                         |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configuraciones predefinidas para cada LSP server       |

### Autocompletado

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Motor de autocompletado con múltiples fuentes           |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | Fuente de completado desde LSP                          |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Completado desde palabras del buffer actual             |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | Completado de rutas de archivos                         |
| [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | Completado en la línea de comandos (`:`)                |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | Puente entre cmp y LuaSnip                              |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Motor de snippets (fragmentos de código)                |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Colección de snippets predefinidos                      |

### Navegación y búsqueda

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [harpoon](https://github.com/ThePrimeagen/harpoon) | Marcadores rápidos de archivos (bookmarks por proyecto) |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Buscador difuso de archivos, texto, buffers y más       |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Librería de utilidades (dependencia de harpoon/telescope) |

### Terminal

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal integrada en ventana flotante                  |

### Git

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | Interfaz visual de Git dentro de Neovim                 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Indicadores de cambios Git en el gutter (margen izquierdo) |

### UI / Interfaz

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Barra de estado (statusline) minimalista                |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Popup que muestra atajos disponibles al presionar `<leader>` |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Líneas guía de indentación                              |

### Edición

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [mini.pairs](https://github.com/echasnovski/mini.pairs) | Cierre automático de paréntesis, corchetes y comillas   |

### tmux

| Plugin                               | Propósito                                              |
|--------------------------------------|--------------------------------------------------------|
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Navegación seamless entre splits de vim y panes de tmux |

### Soporte de lenguajes (via LSP)

| Lenguaje         | LSP Server                     |
|------------------|--------------------------------|
| Lua              | `lua_ls`                       |
| TypeScript / JS  | `ts_ls`                        |
| Python           | `pyright`                      |
| Go               | `gopls`                        |
| Rust             | `rust_analyzer`                |
| C / C++          | `clangd`                       |
| HTML             | `html`                         |
| CSS / SCSS / LESS| `cssls`                        |
| JSON             | `jsonls`                       |
| YAML             | `yamlls`                       |

---

## Estructura del proyecto

```
~/.config/nvim/
├── init.lua              # Punto de entrada
├── install.sh            # Script de instalación
├── Brewfile              # Dependencias Homebrew
├── lazy-lock.json        # Lock de versiones de plugins
├── lua/
│   ├── config/
│   │   ├── options.lua   # Opciones del editor (números, tabs, etc.)
│   │   ├── lazy.lua      # Configuración de lazy.nvim + plugins inline
│   │   ├── keymaps.lua   # Atajos de teclado
│   │   ├── lsp.lua       # Configuración de LSP servers
│   │   ├── cmp.lua       # Configuración de autocompletado
│   │   └── harpoon.lua   # Configuración de marcadores
│   └── plugins/
│       ├── lsp.lua       # Definición de plugins LSP
│       ├── cmp.lua       # Definición de plugins de completado
│       └── tools.lua     # Definición de herramientas y utilidades
├── tmux/
│   └── tmux.conf         # Configuración de tmux
├── opencode/             # Configuración de OpenCode
└── README.md
```

---

## Personalización

Cada archivo en `lua/config/` está comentado extensamente. Para cambiar opciones:

- **Editor**: edita `lua/config/options.lua`
- **Atajos**: edita `lua/config/keymaps.lua`
- **LSP**: edita `lua/config/lsp.lua` y `lua/plugins/lsp.lua`
- **Completado**: edita `lua/config/cmp.lua` y `lua/plugins/cmp.lua`
- **Plugins**: agrega archivos en `lua/plugins/` y se cargarán automáticamente

---

## LazyGit

[LazyGit](https://github.com/jesseduffield/lazygit) se instala via Homebrew (incluido en el `Brewfile`). Ábrelo desde Neovim con `<leader>gg` o directamente desde la terminal con `lazygit`.

---

## Tmux

La configuración de tmux se enlaza automáticamente a `~/.tmux.conf` al ejecutar `install.sh`. Usa `Ctrl-h/j/k/l` para moverte entre panes de tmux y splits de Neovim sin interrupciones.
