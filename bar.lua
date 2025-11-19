local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --bar domain
sbar.bar({
  height = settings.bar_height,
  color = colors.with_alpha(colors.bar.bg, 0.001),
  padding_right = 2,
  padding_left = 2,
  y_offset = 2,
})
