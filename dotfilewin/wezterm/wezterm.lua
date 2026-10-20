-- wezterm.lua

local wezterm = require 'wezterm'
local config = wezterm.config_builder()
-- Function to check if the current platform is Windows
local is_windows = wezterm.target_triple:find("windows") ~= nil

-- Main configuration table
local config = {}

-- Appearance Settings
config.color_scheme = "Catppuccin Mocha" -- Choose your favorite color scheme



-- Primary font with fallback fonts
config.font = wezterm.font_with_fallback({
    "Agave Nerd Font", -- Primary font
    "Noto Color Emoji", -- Fallback for emojis
    "Noto Sans CJK JP", -- Fallback for Japanese characters
    "Symbols Nerd Font", -- Fallback for symbols and icons
}, { weight = "Regular" })

config.font_size = 13
config.line_height=1.5
config.window_background_opacity = 0.99 -- Slight transparency
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Window and Pane Behavior
config.initial_cols = 110
config.initial_rows = 30
config.scrollback_lines = 5000 -- Increase scrollback buffer size

config.enable_tab_bar = false

config.window_padding = {
    left = 40,
    right = 40,
    top = 20,
    bottom = 20,
}

-- Keybindings
config.keys = {
    -- Split panes
    { key = "-", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "\\", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },

    -- Navigate between panes
    { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Down" },
    { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Right" },

    -- Close pane
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane { confirm = true } },

    -- Resize panes
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize { "Left", 1 } },
    { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize { "Right", 1 } },
    { key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize { "Up", 1 } },
    { key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize { "Down", 1 } },

	-- Tabs
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab "CurrentPaneDomain" }, -- Open new tab
    { key = "n", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) }, -- Next tab
    { key = "p", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) }, -- Previous tab
    { key = "q", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab { confirm = true } }, -- Close current tab

    -- Copy and Paste
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo "ClipboardAndPrimarySelection" }, -- Copy
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom "Clipboard" }, -- Paste

    -- Miscellaneous
    { key = "r", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration }, -- Reload WezTerm config
    { key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search { CaseInSensitiveString = "" } }, -- Open search bar
}

-- Platform-Specific Settings
if is_windows then
    -- Default shell on Windows
    config.default_prog = { "pwsh.exe" } -- Change to "cmd.exe" or "bash.exe" if needed
end

-- Return the final configuration
return config
