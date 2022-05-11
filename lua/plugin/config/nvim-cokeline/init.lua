local set = vim.keymap.set
set("n", "<Tab>", "<Plug>(cokeline-focus-next)")
set("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)")
--set("n", "<Leader>p", "<Plug>(cokeline-switch-prev)")
--set("n", "<Leader>n", "<Plug>(cokeline-switch-next)")

local components = require("plugin.config.nvim-cokeline.components")

require("cokeline").setup {
  sidebar = {
    filetype = "NvimTree",
    components = {
      {
        text = "  ",
      },
      {
        text = "NvimTree",
        fg = vim.g.terminal_color_3,
        style = "bold",
      },
    },
  },
  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and "#DCDCDC" or "#7F8184"
    end,
    bg = function(buffer)
      return buffer.is_focused and "#282C34" or "#21252B"
    end,
  },
  components = {
    {
      text = " ",
    },
    components.icon,
    components.unique_prefix,
    components.filename,
    components.close_or_modified,
    {
      text = "▕",
      fg = "#181A1F",
    },
  },
}
