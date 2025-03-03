local wezterm = require 'wezterm'

-- In newer versions of wezterm, this return value is processed by
-- wezterm.config_builder()
local config = wezterm.config_builder()


-- Default theme
local dark_theme = 'Catppuccin Mocha'
local light_theme = 'Catppuccin Latte'
local current_theme = dark_theme

config.color_scheme = current_theme
config.font = wezterm.font('JetBrains Mono')
config.font_size = 12.0
config.initial_rows = 35
config.initial_cols = 140
config.enable_tab_bar = false
-- config.window_decorations = "NONE"

-- Set PowerShell with its full path and proper arguments
config.default_prog = {'wsl.exe', '-d', 'Ubuntu-24.04'}

-- Change exit behavior to hold the pane open even when the process exits
config.exit_behavior = 'Hold'

-- Function to toggle the tab bar
local function toggle_tab_bar(window)
    local overrides = window:get_config_overrides() or {}
    if overrides.enable_tab_bar == false then
        overrides.enable_tab_bar = true -- Show the tab bar
    else
        overrides.enable_tab_bar = false -- Hide the tab bar
    end
    window:set_config_overrides(overrides)
end


-- Function to toggle the theme
local function toggle_theme(window, pane)
  if config.color_scheme == dark_theme then
    config.color_scheme = light_theme
  else
    config.color_scheme = dark_theme
  end
  window:set_config_overrides({ color_scheme = config.color_scheme })
end


-- Key bindings
config.keys = { -- Alt + L to open a vertical pane
{
    key = 'l',
    mods = 'ALT',
    action = wezterm.action.SplitHorizontal {
        domain = 'CurrentPaneDomain'
    }
}, -- Alt + K to open a horizontal pane
{
    key = 'k',
    mods = 'ALT',
    action = wezterm.action.SplitVertical {
        domain = 'CurrentPaneDomain'
    }
}, -- Alt + P to open a new tab
{
    key = 'p',
    mods = 'ALT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain'
}, -- Alt + Q to close a tab
{
    key = 'q',
    mods = 'ALT',
    action = wezterm.action.CloseCurrentTab {
        confirm = false
    }
}, -- Alt + W to close the last opened pane
{
    key = 'w',
    mods = 'ALT',
    action = wezterm.action.CloseCurrentPane {
        confirm = false
    }
}, -- Bind Alt+D to list open tabs
-- Alt + Shift + L: Switch to the tab on the right
{
    key = "l",
    mods = "ALT|SHIFT",
    action = wezterm.action {
        ActivateTabRelative = 1
    } -- Move to the next tab
}, -- Alt + Shift + H: Switch to the tab on the left
{
    key = "h",
    mods = "ALT|SHIFT",
    action = wezterm.action {
        ActivateTabRelative = -1
    } -- Move to the previous tab
}, -- Alt + Shift + T: Toggle the tab bar
{
    key = "t",
    mods = "ALT|SHIFT",
    action = wezterm.action_callback(function(window, pane)
        toggle_tab_bar(window)
    end)
}, -- Override Alt+Enter to toggle full screen AND clear the screen
{
    key = "Enter",
    mods = "ALT",
    action = wezterm.action.Multiple({wezterm.action.ToggleFullScreen, -- Toggle full screen
    wezterm.action.SendString("\x0c") -- Send Ctrl+L (terminal clear-screen command)
    })
}, -- Shift focus to the pane on the right
{
    key = "L",
    mods = "ALT|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Right"
}, -- Shift focus to the pane on the left
{
    key = "H",
    mods = "ALT|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Left"
}, -- Shift focus to the pane above
{
    key = "K",
    mods = "ALT|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Up"
}, -- Shift focus to the pane below
{
    key = "J",
    mods = "ALT|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Down"
}, -- Open the tab navigator with Alt + D
{
    key = "D",
    mods = "ALT|SHIFT",
    action = wezterm.action.ShowTabNavigator
},
{
    key = 'C',
    mods = 'ALT|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      toggle_theme(window, pane)
    end),
},}

return config
