function _G.packer_exec(cmd)
  -- invalidate cache
  package.loaded["plugin.packer"] = nil
  require("plugin.packer")[cmd]()
end

local function capitalize(str)
  return str:sub(1, 1):upper() .. str:sub(2):lower()
end

for _, v in ipairs { "sync", "compile", "clean", "install", "update", "status" } do
  local cmd = "Packer" .. capitalize(v)
  local repl = "lua packer_exec('" .. v .. "')"
  vim.cmd(table.concat({ "command!", cmd, repl }, " "))
end

local function packer_set(lhs, rhs, opt)
  vim.keymap.set("n", "<leader>p" .. lhs, "<CMD>Packer" .. rhs .. "<CR>", opt)
end

packer_set("s", "Sync")
packer_set("c", "Compile")
packer_set("C", "Clean")
packer_set("u", "Update")
packer_set("S", "Status")
packer_set("i", "Install")

require("plugin.packer_compiled")
