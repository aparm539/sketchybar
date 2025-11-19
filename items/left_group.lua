local colors = require("colors")
local settings = require("settings")

-- Create a shared background bracket for all left-side items
-- This wraps apple, menu items, spaces, and front_app
sbar.add("bracket", "left_group", {
  "apple",
  "/menu\\..*/",
  "/space\\..*/",
  "front_app",
}, {
  background = {
    color = colors.bg1,
    border_color = colors.grey,
    border_width = 0,
    corner_radius = 6,
    height = settings.bar_height,
    drawing = true
  }
})

