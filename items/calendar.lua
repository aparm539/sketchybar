local settings = require("settings")
local colors = require("colors")

local cal = sbar.add("item", "calendar", {
  icon = {
    color = colors.white,
    padding_left = settings.padding_medium,
    padding_right = settings.padding_medium,
    font = {
      style = settings.font.style_map["Black"],
      size = settings.font_size_medium,
    },
  },
  label = {
    color = colors.white,
    padding_right = settings.padding_medium,
    padding_left = settings.padding_medium,
    width = 65,
    align = "right",
    font = { 
      style = settings.font.style_map["Black"],
      size = settings.font_size_medium
    },
  },
  position = "right",
  update_freq = 30,
  padding_left = 0,
  padding_right = settings.side_paddings,
  background = {
    color = colors.bg2,
    height = settings.item_height
  },
  click_script = "open -a 'Calendar'"
})

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
  cal:set({ icon = os.date("%a. %d %b."), label = os.date("%I:%M %p") })
end)

sbar.add("item", { position = "right", width = settings.item_gap })
