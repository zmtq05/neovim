vim.o.completeopt = "menu,menuone,noselect,noinsert"

local cmp = require("cmp")
local luasnip = require("luasnip")
local border = BORDER

luasnip.config.set_config {
  -- history = false,
  region_check_events = "CursorMoved",
  delete_check_events = "TextChanged",
}
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
  window = {
    completion = { border = border },
    documentation = { border = border },
  },
  mapping = {
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      --if luasnip.expand_or_locally_jumpable() then
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-Space>"] = cmp.mapping.complete(),

    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<C-l>"] = cmp.mapping.confirm { select = true },

    ["<C-d>"] = cmp.mapping.scroll_docs(2),
    ["<C-u>"] = cmp.mapping.scroll_docs(-2),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lua" },
  }, {
    { name = "buffer" },
  }),

  formatting = {
    fields = {
      cmp.ItemField.Kind,
      cmp.ItemField.Abbr,
      cmp.ItemField.Menu,
    },
    format = require("lspkind").cmp_format {
      mode = "symbol",
      maxwidth = 50,
      menu = {
        buffer = "|BUF|",
        nvim_lsp = "|LSP|",
        nvim_lua = "|API|",
        luasnip = "|SNP|",
      },
    },
  },
  experimental = { ghost_text = false },
}

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
