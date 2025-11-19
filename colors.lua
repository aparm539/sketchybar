return {
  -- Gruvbox color palette
  black = 0xff282828,      -- bg0 (darkest background)
  white = 0xffebdbb2,      -- fg0 (lightest foreground)
  red = 0xfffb4934,        -- bright red
  green = 0xffb8bb26,      -- bright green
  blue = 0xff83a598,       -- bright blue
  yellow = 0xfffabd2f,     -- bright yellow
  orange = 0xfffe8019,     -- bright orange
  magenta = 0xffd3869b,    -- bright purple/magenta
  grey = 0xff928374,       -- grey (fg4)
  transparent = 0x00000000,

  bar = {
    bg = 0xf0282828,       -- bg0 with alpha
    border = 0xff282828,   -- bg0
  },
  popup = {
    bg = 0xc03c3836,       -- bg1 with alpha
    border = 0xff928374    -- grey
  },
  bg1 = 0xff3c3836,        -- bg1
  bg2 = 0xff504945,        -- bg2

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
