local signs = {
  error = " ",
  warn = " ",
  hint = " ",
  info = " ",
}

--for key, icon in pairs(signs) do
--  local hl = "DiagnosticSign" .. key:capitalize()
--  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
--end

local border = BORDER
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = border }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = border }
)

local severity = vim.diagnostic.severity
vim.diagnostic.config {
  virtual_text = {
    severity = { min = severity.INFO },
  },
  float = { border = border },
  signs = false,
  severity_sort = true,
  update_in_insert = true,
}

local nls = require("null-ls")
nls.setup {
  sources = {
    nls.builtins.formatting.stylua,
  },
}

require("fidget").setup {
  text = { spinner = "dots_negative" },
  sources = {
    ["null-ls"] = { ignore = true },
  },
}

local servers = { "sumneko_lua", "rust_analyzer" }
local config = require("lsp.config")

require("nvim-lsp-installer").setup {
  ensure_installed = servers,
  automatic_installation = true
}

local lsp = require("lspconfig")
lsp.sumneko_lua.setup(config.sumneko_lua)
