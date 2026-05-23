local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- Font settings
config.font = wezterm.font_with_fallback {
  { family = 'Cascadia Mono', weight = 'DemiBold' },
  { family = 'Kosugi Maru', weight = 'DemiBold' },
}
config.font_size = 13.0

-- Color scheme (Built-in)
config.color_scheme = 'Seti'
-- config.color_scheme = 'Monokai Remastered'
config.colors = {
  cursor_bg = '#282828',    -- Cursor background color
}

-- Apply WSL2 default program only if the OS is Windows
if wezterm.target_triple:find('windows') then
  config.default_prog = { 'wsl.exe', '-d', 'Ubuntu', '--cd', '~' }
end

config.initial_cols = 140
config.initial_rows = 55
-- config.line_height = 1.09
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 15000

config.freetype_render_target = 'HorizontalLcd'

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.PasteFrom 'Clipboard',
  },
}

return config
