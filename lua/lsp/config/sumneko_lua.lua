return require("lua-dev").setup {
  library = {
    vimruntime = false,
    types = false,
    plugins = true,
  },
  lspconfig = require("lsp.config") {
    root_dir = function(fname)
      return require("lspconfig.util").find_git_ancestor(fname)
        or vim.fn.getcwd()
    end,
    settings = {
      Lua = {
        telemetry = { enable = true },
        diagnostics = {
          neededFileStatus = {
            --["redefined-local"] = "None",
          },
        },
      },
    },
  },
}
