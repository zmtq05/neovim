vim.g.neo_tree_remove_legacy_commands = 1

local neotree = require("neo-tree")
neotree.setup {
  window = {
    mappings = { o = "open" },
    width = 30,
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function() neotree.close_all() end,
    },
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        --vim.api.nvim_buf_set_option(0, "signcolumn", "no")
        vim.api.nvim_win_set_option(0, "signcolumn", "no")
        --vim.cmd"setlocal signcolumn=no"
      end
    }
  }
}

vim.keymap.set("n", "<leader>e", "<cmd>Neotree<CR>")
