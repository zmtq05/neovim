require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "comment",
    "json",
    "json5",
    "jsonc",
    "lua",
    "markdown",
    "regex",
    "rust",
    "toml",
    "vim",
    "yaml",
  },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  endwise = { enable = false },
  playground = { enable = true },
  textobjects = {
    swap = {
      enable = false,
      swap_next = { ["<leader>s"] = "@parameter.inner" },
      swap_previous = { ["<leader>S"] = "@parameter.inner" },
    },
  },
}
