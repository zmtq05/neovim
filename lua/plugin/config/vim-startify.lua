local startify = setmetatable({}, {
  __newindex = function(_, k, v)
    vim.g["startify_" .. k] = v
  end
})

startify.bookmarks = {
  { n = "~/.config/nvim/init.lua" }
}
