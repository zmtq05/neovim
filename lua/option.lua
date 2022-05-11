-- stylua: ignore
local option = {
  relativenumber = true,
  number         = true,
  cursorline     = true,

  clipboard      = "unnamedplus",
  mouse          = "a",

  softtabstop    = 2,
  shiftwidth     = 2,
  tabstop        = 2,
  expandtab      = true,

  splitbelow     = true,
  splitright     = true,

  ignorecase     = true,
  smartcase      = true,

  wrap           = false,
  scrolloff      = 3,
  sidescrolloff  = 5,

  showmode       = false,

  updatetime     = 150,
  timeoutlen     = 500,

  signcolumn     = "yes:2",

  pumheight      = 7,

  termguicolors  = true,

  laststatus     = 3,

  hlsearch       = false,
}

for k, v in pairs(option) do
  vim.o[k] = v
end
