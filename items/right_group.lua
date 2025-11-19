local colors = require("colors")
local settings = require("settings")

-- Create a shared background bracket for all right-side items
-- This wraps calendar, battery, volume, wifi, and media items
sbar.add("bracket", "right_group", {
  "calendar",
  "widgets.battery",
  "widgets.volume",
  "widgets.wifi",
  "media.cover",
  "media.artist",
  "media.title",
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

