local settings = require("settings")
local colors = require("colors")

local cal = sbar.add("item", "calendar", {
  icon = {
    color = colors.white,
    padding_left = settings.padding_small,
    padding_right = settings.padding_small,
    font = {
      style = settings.font.style_map["Black"],
      size = settings.font_size_small,
    },
  },
  label = {
    color = colors.white,
    padding_right = settings.padding_small,
    width = 55,
    align = "right",
    font = { 
      style = settings.font.style_map["Black"],
      size = settings.font_size_small
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
