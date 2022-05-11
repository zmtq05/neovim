require("nvim-tree").setup {
  filters = {
    custom = { ".git" },
  },
  update_cwd = true,
}
vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeFindFile<CR>", { desc = "File explorer" })
