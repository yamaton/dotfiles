-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- config.color_scheme = 'Monokai Remastered'
-- config.color_scheme = 'zenwritten_dark'
config.color_scheme = 'Selenized Dark (Gogh)'
config.font = wezterm.font_with_fallback {
    'Cascadia Code',
    'Kosugi Maru'
}
config.font_size = 13.0
config.initial_cols = 100
config.initial_rows = 37
config.line_height = 1.09
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 6000

-- and finally, return the configuration to wezterm
return config
