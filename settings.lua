local bar_height = 28

return {
  bar_height = bar_height,
  paddings = 2,
  group_paddings = 3,
  item_gap = 8,
  side_paddings = 12,

  -- Calculated values based on bar height
  border_width = 1,  -- Standard border width for all items
  item_height = bar_height - 8,  -- Item background height (bar height - 8px to provide padding inside groups)
  -- Icon and font sizes account for 2px border space (1px top + 1px bottom)
  -- Reduced sizes for minimal, clean look
  icon_size_large = (bar_height - 2) * 0.65,  -- Large icons (e.g., battery)
  icon_size_medium = (bar_height - 2) * 0.56,  -- Medium icons (e.g., apple, volume)
  icon_size_small = (bar_height - 2) * 0.40,  -- Small icons
  font_size_large = (bar_height - 2) * 0.50,  -- Large text (e.g., front app, calendar) - was tiny, now largest
  font_size_medium = (bar_height - 2) * 0.47,  -- Medium text (e.g., spaces label) - scaled down
  font_size_small = (bar_height - 2) * 0.40,  -- Small text - scaled down
  font_size_extra_small = (bar_height - 2) * 0.37,  -- Extra small text (e.g., battery %, volume %) - scaled down
  font_size_tiny = (bar_height - 2) * 0.33,  -- Tiny text (e.g., date, time) - scaled down, now smallest
  padding_small = math.max(1, math.floor(bar_height * 0.05)),  -- Small padding (1px)
  padding_medium = math.floor(bar_height * 0.20),  -- Medium padding (reduced for minimal look)
  padding_large = math.floor(bar_height * 0.40),  -- Large padding (reduced for minimal look)

  icons = "sf-symbols", -- alternatively available: NerdFont

  -- This is a font configuration for SF Pro and SF Mono (installed manually)
  font = require("helpers.default_font"),

  -- Alternatively, this is a font config for JetBrainsMono Nerd Font
  -- font = {
  --   text = "JetBrainsMono Nerd Font", -- Used for text
  --   numbers = "JetBrainsMono Nerd Font", -- Used for numbers
  --   style_map = {
  --     ["Regular"] = "Regular",
  --     ["Semibold"] = "Medium",
  --     ["Bold"] = "SemiBold",
  --     ["Heavy"] = "Bold",
  --     ["Black"] = "ExtraBold",
  --   },
  -- },
}
