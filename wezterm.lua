
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Cursor style and window decorations
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.window_decorations= "TITLE | RESIZE"

-- Always show tab bar (like tmux)
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Start with PowerShell (you can change this later if needed)
config.default_prog = { "powershell.exe", "-NoLogo" }

-- Keybindings for tabs and panes
config.keys = {
  -- Split panes
  {
    key = "h",
    mods = "CTRL|SHIFT|ALT",
    action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }),
  },
  {
    key = "v",
    mods = "CTRL|SHIFT|ALT",
    action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }),
  },
  {
    key = "Q",
    mods = "CTRL|SHIFT",
    action = wezterm.action.QuitApplication,
  },

  -- Resize panes
  { key = "U", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "I", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
  { key = "O", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "P", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

  -- Tab switching
  { key = "1", mods = "ALT", action = act.ActivateTab(0) },
  { key = "2", mods = "ALT", action = act.ActivateTab(1) },
  { key = "3", mods = "ALT", action = act.ActivateTab(2) },
  { key = "4", mods = "ALT", action = act.ActivateTab(3) },
  { key = "5", mods = "ALT", action = act.ActivateTab(4) },
  { key = "6", mods = "ALT", action = act.ActivateTab(5) },
  { key = "7", mods = "ALT", action = act.ActivateTab(6) },
  { key = "8", mods = "ALT", action = act.ActivateTab(7) },
  { key = "9", mods = "ALT", action = act.ActivateTab(8) },
}

return config
