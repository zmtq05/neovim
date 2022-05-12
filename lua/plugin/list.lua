local wrapper = require("packer-tools.wrapper")
local use_clean = require("packer").use
local use = wrapper.new {
  inject_config = { enable = true, prefix = "plugin.config." },
}

-- packer
use_clean {
  { "wbthomason/packer.nvim", opt = true },
  { "~/repo/packer-tools.nvim", module = "packer" },
}

-- theme
use_clean {
  "olimorris/onedarkpro.nvim",
  "folke/tokyonight.nvim",
  "~/repo/OneDark-Pro.nvim",
}

use {
  "mhinz/vim-startify",
  --{ "~/repo/fork/which-key.nvim", config = "require'which-key'.setup{}" },
  { "folke/which-key.nvim", config = "require'which-key'.setup{}" },
  "stevearc/dressing.nvim",
  { "numToStr/Comment.nvim", config = "require'Comment'.setup{padding=false}" },
  { "norcalli/nvim-colorizer.lua", config = "require'colorizer'.setup(nil, { RGB = false })" },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "ToggleTermToggleAll" },
    module = "toggleterm",
    keys = "<C-s>",
  },
  { "~/repo/fork/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim", "tpope/vim-repeat" } },
  --{ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim", "tpope/vim-repeat" } },
}

use_clean {
  { "tweekmonster/startuptime.vim", cmd = "StartupTime" },
  "lewis6991/impatient.nvim",
  "rcarriga/nvim-notify",
  "famiu/bufdelete.nvim",
  "tpope/vim-surround",
  "matze/vim-move",
  { "rafcamlet/nvim-luapad", cmd = { "Luapad", "LuaRun", "Lua" } },
  { "ggandor/lightspeed.nvim", requires = "tpope/vim-repeat" },
}

-- treesitter
local treesitter = "nvim-treesitter/nvim-treesitter"
use {
  treesitter,
  run = ":TSUpdate",
  requires = {
    "RRethy/nvim-treesitter-endwise",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}
use({
  { "windwp/nvim-autopairs" },
  {
    "danymat/neogen",
    config = "require'neogen'.setup{ snippet_engine = 'luasnip' }",
    disable = true,
  },
}, { requires = treesitter })

-- telescope
local telescope = "nvim-telescope/telescope.nvim"
use {
  telescope,
  requires = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    { "pwntester/octo.nvim", requires = "kyazdani42/nvim-web-devicons" }
  },
}
use { "ahmedkhalf/project.nvim", requires = telescope }

-- LSP
use {
  "neovim/nvim-lspconfig",
  config = "require('lsp')",
  requires = {
    "williamboman/nvim-lsp-installer",
    "hrsh7th/cmp-nvim-lsp",
    "j-hui/fidget.nvim", -- show LSP progress
    { "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" },
    { "folke/lua-dev.nvim", ft = "lua" },
    { "simrat39/rust-tools.nvim", ft = "rust" },
    "ericpubu/lsp_codelens_extensions.nvim",
  },
}

-- DAP
use_clean {
  "mfussenegger/nvim-dap",
}

-- auto completion
use {
  "hrsh7th/nvim-cmp",
  requires = {
    -- sources
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",

    -- snippets
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",

    -- pictograms
    "onsails/lspkind-nvim",
  },
}

use({
  { "noib3/nvim-cokeline" },
  --"feline-nvim/feline.nvim",
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim"
    }
  },
}, { requires = "kyazdani42/nvim-web-devicons" })

use {
  "github/copilot.vim",
  disable = false,
  config = function()
    vim.keymap.set("i", "<M-l>", "copilot#Accept()", { silent = true, expr = true, script = true })
    --vim.g.copilot_assume_mapped = true
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
      TelescopePrompt = false,
      DressingInput = false,
    }
  end,
}
