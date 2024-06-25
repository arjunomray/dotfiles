local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Atom (Gogh)'
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 16
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.window_background_opacity = 0.85


return config
