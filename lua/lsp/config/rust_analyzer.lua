return require("rust-tools").setup {
  tools = {
    executor = require("rust-tools.executors.toggleterm"),
    inlay_hints = {
      --other_hints_prefix = ": ",
      --parameter_hints_prefix = "",
      highlight = "InlayHints",
    },
    hover_actions = { border = BORDER },
  },
  server = require("lsp.config") {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = { command = "clippy" },
      },
    },
    standalone = false,
  },
}
