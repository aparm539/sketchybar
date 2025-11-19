local colors = require("colors")
local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
  display = "active",
  icon = { drawing = false },
  label = {
    color = colors.white,
    font = {
      style = settings.font.style_map["Black"],
      size = settings.font_size_small,
    },
  },

  updates = true,
  padding_right = settings.side_paddings,
  background = {
    color = colors.bg2,
    height = settings.item_height
  },
})


front_app:subscribe("front_app_switched", function(env)
  front_app:set({ label = { string = env.INFO } })
end)

front_app:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)
