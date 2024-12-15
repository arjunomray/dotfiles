local wezterm = require("wezterm")

local config = {}

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("Iosevka Comfy")
config.font_size = 18
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.window_background_opacity = 0.85
config.window_decorations = "RESIZE"

return config
