-- Pull in the WezTerm API
local wezterm = require 'wezterm'

-- Build the configuration
local config = wezterm.config_builder()

-- Window decorations
config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'
config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
config.integrated_title_button_alignment = 'Right'

-- Default shell
config.default_prog = { '/usr/bin/zsh' }

-- Font configuration
config.font = wezterm.font_with_fallback({
  'MesloLGS NF',
  'JetBrains Mono',
  'Noto Color Emoji',
})
config.font_size = 11.0

-- Initial window geometry
config.initial_cols = 155
config.initial_rows = 30

-- Color scheme
config.color_scheme = 'Breath Darker (Gogh)'
config.window_background_opacity = 0.90

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.60,
}

-- Cursor
config.default_cursor_style = 'BlinkingUnderline'

-- Return the configuration to WezTerm
return config
