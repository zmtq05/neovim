local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1], { border = "solid" })
end
function _G.peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(
    0,
    "textDocument/definition",
    params,
    preview_location_callback
  )
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local default = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_highlight then
      NVIM.augroup("LspDocumentHighlight") {
        {
          "CursorHold",
          callback = vim.lsp.buf.document_highlight,
          buffer = bufnr,
        },
        {
          { "CursorMoved", "InsertEnter" },
          callback = vim.lsp.buf.clear_references,
          buffer = bufnr,
        },
      }
      local function set(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      local function lua(cmd)
        return "<Cmd>lua " .. cmd .. "<CR>"
      end
      set("n", "K", lua("vim.lsp.buf.hover()"))
      set("n", "<leader>r", lua("vim.lsp.buf.rename()"))
      set("n", "<leader>a", lua("vim.lsp.buf.code_action()"))
      set("n", "<leader>f", lua("vim.lsp.buf.formatting_sync()"))
      set("n", "<leader>D", lua("vim.lsp.buf.type_definition()"))
      set("n", "gr", lua("vim.lsp.buf.references()"))
      set("n", "gD", lua("_G.peek_definition()"))
      set("n", "gd", lua("vim.lsp.buf.definition()"))
      set("n", "gi", lua("vim.lsp.buf.implementation()"))

      set("n", "]d", lua("vim.diagnostic.goto_next()"))
      set("n", "[d", lua("vim.diagnostic.goto_prev()"))
      local err = "{ severity = vim.diagnostic.severity.ERROR }"
      set("n", "]e", lua("vim.diagnostic.goto_next" .. err))
      set("n", "[e", lua("vim.diagnostic.goto_prev" .. err))
    end
  end,
}

local function __call(self, ...)
  local configs = { ... }

  -- stylua: ignore
  local function new_on_attach(...)
    if self.on_attach then self.on_attach(...) end
    for _, config in ipairs(configs) do
      if config.on_attach then config.on_attach(...) end
    end
  end

  local new_config = vim.tbl_deep_extend("force", self, unpack(configs))
  new_config.on_attach = new_on_attach
  return new_config
end

return setmetatable({}, {
  __index = function(_, server_name)
    if server_name == "default" then
      return default
    end

    local ok, config = pcall(require, "lsp.config." .. server_name)
    if not ok then
      return nil
    else
      return setmetatable(config, { __call = __call })
    end
  end,
  __call = function(_, ...)
    if vim.tbl_isempty(...) then
      return default
    end
    return __call(default, ...)
  end,
})
