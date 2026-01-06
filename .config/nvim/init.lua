--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Configure rustlang/rust.vim to run cargo fmt on saving a buffer
vim.g.rustfmt_autosave = 1

-- Configure NerdTree to open (toggle) with <CTRL> n
-- vim.g.nnoremap <C-n> :NERDTree<CR>
vim.api.nvim_set_keymap(
  "n",
  "<C-n>",
  ":NERDTreeToggle<cr>",
  { noremap = true }
 )
-- vim.g.nnoremap <C-t> :NERDTreeToggle<CR>
vim.api.nvim_set_keymap(
  "n",
  "<C-t>",
  ":NERDTreeToggle<cr>",
  { noremap = true }
 )
-- vim.g.nnoremap <C-m> :NERDTreeFind<CR>
vim.api.nvim_set_keymap(
  "n",
  "<C-m>",
  ":NERDTreeMirror<cr>",
  { noremap = true }
 )

-- Allow nerdtree to show files like .bashrc in nerdtree
vim.g.NERDTreeShowHidden=1
-- Set the default window width to be 50 wide for nerdtree
vim.g.NERDTreeWinSize=50


-- On any write to a buffer strip trailing whitespace and
-- keep the cursor in it's original position.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function()
      local save_cursor = vim.fn.getpos(".")
      pcall(function() vim.cmd [[%s/\s\+$//e]] end)
      vim.fn.setpos(".", save_cursor)
    end,
})

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  spec = {
      { import = "plugins" },

      -- Rustaceanvim - easy setup of rust-analyzer in neovim!
      'mrcjkb/rustaceanvim',

      -- Git related plugins
      'tpope/vim-fugitive',
      'tpope/vim-rhubarb',

      -- rust-lang/rust.vim plugin
      'rust-lang/rust.vim',

      -- Git related plugins
      'tpope/vim-fugitive',
      'tpope/vim-rhubarb',

      -- Detect tabstop and shiftwidth automatically
      'tpope/vim-sleuth',

      -- Install NerdTree
      'preservim/nerdtree',

      -- Install vim-bitbake plugin
      'kergoth/vim-bitbake',

      -- Install mason
      'mason-org/mason.nvim',

      {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
      },

      -- NOTE: This is where your plugins related to LSP can be installed.
      --  The configuration is done below. Search for lspconfig to find it below.
      {
          -- LSP Configuration & Plugins
          'neovim/nvim-lspconfig',

          dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'mason-org/mason.nvim', config = true },
            'mason-org/mason-lspconfig.nvim',

          opts = {
            inlay_hints = { enabled = true },
          },
            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {}, },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
          },
      },

      {
          -- vim-dichromatic
          'romainl/vim-dichromatic',
      },

      {
          -- Theme inspired by Atom
          'navarasu/onedark.nvim',
          priority = 1000,
          config = function()
            vim.cmd.colorscheme 'dichromatic'
          end,
      },

      {
          -- Set lualine as statusline
          'nvim-lualine/lualine.nvim',
          -- See `:help lualine.txt`
          opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
          },
      },

      {
          -- Add indentation guides even on blank lines
          'lukas-reineke/indent-blankline.nvim',
          -- Enable `lukas-reineke/indent-blankline.nvim`
          -- See `:help indent_blankline.txt`
          main = "ibl",
          opts = {},
      },

      -- "gc" to comment visual regions/lines
      { 'numToStr/Comment.nvim', opts = {} },

      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
          'nvim-telescope/telescope-fzf-native.nvim',
          -- NOTE: If you are having trouble with this installation,
          --       refer to the README for telescope-fzf-native for more instructions.
          build = 'make',
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
      },
  },
}, {})

-- [[ Setting options
-- See `:help vim.o`

-- Set highlight on search
-- vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

local set = vim.opt -- set options
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

-- [[ Basic Keymaps

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Enable syntax highlighting for .overlay files to
-- be highlighted like a .dts file.
-- More info here: https://neovim.io/doc/user/lua-guide.html#lua-guide-autocommands
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  pattern = {"*.overlay"},
  command = "set filetype=dts"
})

-- Setup indent-blankline (ibl)
--require('ibl').setup()
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
end

vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, {
  desc = "LSP Hover Doc",
  noremap = true,
  silent = true,
},
  function()
  print("LSP clients: ", vim.inspect(vim.lsp.buf_get_clients()))
  vim.lsp.buf.hover()
end
)

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  rust_analyzer = {},
  -- tsserver = {},

    lua_ls = {
    -- cmd = { ... },
    -- filetypes = { ... },
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
  pylsp = {
    -- Specific settings for pylsp
    settings = {
      plugins = {
        -- Example: Enable pylint and black
        pylint = { enabled = true, args = { "--rcfile", "~/.config/pylintrc" } },
        black = { enabled = true, line_length = 88 },
        flake8 = { enabled = true, },
        pycodestyl = {
          enabled = false,
          maxLineLength = 100,
        },
        pyflakes = { enabled = false, },
        mypy = { enabled = true, },
        -- Add other pylsp plugins and their configurations as needed
        -- e.g., mypy, flake8, autopep8, etc.
      },
      -- Other pylsp specific settings
      configurationSources = { "pycodestyle" },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Set the default vim colorscheme to dichromatic
vim.cmd("colorscheme dichromatic")

-- updates to LSP highlighting
vim.cmd("hi link @lsp.type.macro DefinedName")
vim.cmd("hi link @lsp.type.label Label")
vim.cmd("hi link @lsp.type.enum.cpp EnumerationName")
vim.cmd("hi link @lsp.type.enumMember EnumerationValue")
vim.cmd("hi link @lsp.mod.readonly Constant")
vim.cmd("hi link @lsp.typemod.variable.functionScope LocalVariable")
vim.cmd("hi link @lsp.typemod.variable.globalScope GlobalVariable")
vim.cmd("hi link @lsp.typemod.enumMember.globalScope EnumerationValue")

-- Setup ruff a very fast Python linter written in Rust
vim.lsp.config("ruff", {
  init_options = {
    settings = {
      -- Ruff language server settings go here
      enable = true,
      lineLength = 100,
    }
  },
  configuration = {
    format = {
      ["quote-style"] = "single"
    }
  },
  diagnostics = {
    update_in_insert = true,
  }
})
vim.lsp.enable("ruff")

-- Required: Enable the language server
vim.lsp.enable('ty')

-- -- Create a BufWritePre command to run ruff check on *.py file write
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.py",
--   callback = function()
--     vim.cmd("!ruff check %")
--   end,
-- })
--

-- Associate the .geo extension with "json" filetype as it is JSON.
vim.filetype.add({
  extension = {
    geo = "json",
  }
})
