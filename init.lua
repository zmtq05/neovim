-- init
require("impatient")
vim.notify = require("notify")
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1
require("global")

-- setup
require("option")
require("keymap")
require("OneDark-Pro").load()
require("plugin")

NVIM.augroup("user") {
  { "TextYankPost", callback = vim.highlight.on_yank },
  {
    "FileType",
    pattern = { "qf", "lspinfo", "help" },
    callback = function()
      vim.keymap.set("n", "q", "<C-w>q", { buffer = true })
    end,
  },
}

vim.keymap.set("n", "<leader>c", "<Cmd>TSHighlightCapturesUnderCursor<CR>")
