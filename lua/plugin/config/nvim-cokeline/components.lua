local colors = require("onedarkpro").get_colors()

---@type table<string, Component>
local M = {}

M.icon = {
  text = function(buffer)
    return " " .. buffer.devicon.icon
  end,
  fg = function(buffer)
    return buffer.devicon.color
  end,
}

M.unique_prefix = {
  text = function(buffer)
    return buffer.unique_prefix
  end,
  fg = colors.comment,
  style = "italic",
}

M.filename = {
  text = function(buffer)
    return buffer.filename .. " "
  end,
  style = function(buffer)
    return buffer.is_focused and "bold"
  end,
  --fg = function(buffer)
  --  return buffer.is_focused and colors.purple or colors.fg
  --end,
}

M.close_or_modified = {
  text = function(buffer)
    local ret = ""
    if buffer.is_focused then
      ret = " "
    end
    if buffer.is_modified then
      ret = "● "
    end
    return ret
  end,
  fg = function(buffer)
    return buffer.is_modified and colors.green
  end,
  delete_buffer_on_left_click = true,
  truncation = { priority = 1 },
}

M.space = { text = " " }

return M
