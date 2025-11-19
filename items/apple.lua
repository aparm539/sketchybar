local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local apple = sbar.add("item", "apple", {
  icon = {
    font = { size = settings.icon_size_medium },
    string = icons.apple,
    padding_right = settings.padding_medium,
    padding_left = settings.padding_medium,
  },
  label = { drawing = false },
  padding_left = settings.side_paddings,
  padding_right = settings.item_gap,
  background = {
    color = colors.bg2,
    height = settings.item_height
  },
  click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0"
})
