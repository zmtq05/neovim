local packer = nil
local function init()
  if not packer then
    packer = require("packer")
    packer.init {
      disable_commands = true,
      compile_path = vim.fn.stdpath("config") .. "/lua/plugin/packer_compiled.lua",
      display = {
        open_fn = function()
          return require("packer.util").float { border = "rounded", style = "minimal" }
        end,
        keybindings = { toggle_info = "o" },
      },
    }
  end

  packer.reset()

  package.loaded["plugin.list"] = nil
  require("plugin.list")
end

return setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})
