require("toggleterm").setup {
  open_mapping = "<C-s>",
  on_open = function(term)
    vim.wo.cursorline = false
  end,
}
