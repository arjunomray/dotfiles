--------------------------------------------------------------------------------
-- MONITORS
--------------------------------------------------------------------------------
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "1.5",
})

--------------------------------------------------------------------------------
-- ENVIRONMENT VARIABLES
--------------------------------------------------------------------------------
hl.env("QT_QPA_PLATFORMTHEME", "kde")

-- Autostart Noctalia & Background Services
hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-- Window/server look-and-feel
hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 6,
		layout = "dwindle",
	},
	dwindle = {
		preserve_split = true,
	},
	decoration = {
		rounding = 6,
		rounding_power = 2,
		shadow = { enabled = true, range = 4, render_power = 3, color = 0xee1a1a1a },
		blur = { enabled = true, size = 3, passes = 2, vibrancy = 0.1696 },
	},
	input = {
		kb_options = "ctrl:nocaps",
	},
	xwayland = {
		force_zero_scaling = true,
		use_nearest_neighbor = false,
	},
})

--------------------------------------------------------------------------------
-- ANIMATIONS
--------------------------------------------------------------------------------
hl.curve("fast", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.animation({ leaf = "global", enabled = true, speed = 2.5, bezier = "fast" })
hl.animation({ leaf = "windows", enabled = true, speed = 2.5, bezier = "fast" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.5, bezier = "fast" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "fast" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.5, bezier = "fast" })

--------------------------------------------------------------------------------
-- DEFAULT PROGRAMS & COMMANDS
--------------------------------------------------------------------------------
local mainMod = "SUPER"
local ipc = "noctalia msg "
local terminal = "alacritty" -- installed: ghostty, kitty, alacritty
local browser = "zen-browser" -- default web browser
local fileManager = "dolphin" -- file manager
local screenLock = "command -v hyprlock >/dev/null 2>&1 && hyprlock || " .. ipc .. "session lock"
local reloadCmd = "hyprctl reload && notify-send -u low -t 2000 'Hyprland' 'Configuration reloaded'"
local colorPicker = "hyprpicker -a && notify-send -u low -t 2000 'Hyprpicker' 'Color copied to clipboard'"

--------------------------------------------------------------------------------
-- TERMINAL & APPLICATION LAUNCHERS
--------------------------------------------------------------------------------
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Noctalia UI panels
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher hold"))

--------------------------------------------------------------------------------
-- WINDOW MANAGEMENT (ESSENTIALS)
--------------------------------------------------------------------------------
-- Close / Force Kill window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.kill())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))

-- Window states
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + Y", hl.dsp.window.pin())
hl.bind(mainMod .. " + backslash", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.window.center())

-- Grouping (tabbed windows)
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + ALT + left", hl.dsp.group.prev())
hl.bind(mainMod .. " + ALT + right", hl.dsp.group.next())

--------------------------------------------------------------------------------
-- NAVIGATION & FOCUS (Arrow keys + Vim keys)
--------------------------------------------------------------------------------
-- Move focus with Arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move focus with Vim keys (H, J, K, L)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move / swap active window with Arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Move / swap active window with Vim keys
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Window resizing with keyboard (repeating)
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20 }), { repeating = true })

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -20, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 20, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -20 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 20 }), { repeating = true })

-- Dedicated modal resize submap (SUPER + R)
hl.define_submap("resize", function()
	hl.bind("left", hl.dsp.window.resize({ x = -20, y = 0 }), { repeating = true })
	hl.bind("right", hl.dsp.window.resize({ x = 20, y = 0 }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -20 }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 20 }), { repeating = true })
	hl.bind("h", hl.dsp.window.resize({ x = -20, y = 0 }), { repeating = true })
	hl.bind("l", hl.dsp.window.resize({ x = 20, y = 0 }), { repeating = true })
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = -20 }), { repeating = true })
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = 20 }), { repeating = true })
	hl.bind("Escape", hl.dsp.submap("reset"))
	hl.bind("Return", hl.dsp.submap("reset"))
end)
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

--------------------------------------------------------------------------------
-- WORKSPACES & SCRATCHPAD
--------------------------------------------------------------------------------
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	-- Switch to workspace [0-9]
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	-- Move active window to workspace [0-9]
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	-- Move active window silently to workspace [0-9]
	hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Cycle adjacent workspaces
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- Special workspace (Scratchpad)
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special:magic" }))

--------------------------------------------------------------------------------
-- MOUSE BINDINGS
--------------------------------------------------------------------------------
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------------------------------------------------------------
-- SCREEN LOCK, RELOAD & SYSTEM CONTROLS
--------------------------------------------------------------------------------
-- Screen lock (Super+Escape and Super+Alt+L to avoid colliding with Vim 'L')
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(screenLock))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(screenLock))

-- Config reload
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(reloadCmd))

-- Exit Hyprland session
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

--------------------------------------------------------------------------------
-- SUBMAPS (MODES)
--------------------------------------------------------------------------------
-- Game Mode / Passthrough Submap (disables all Hyprland keybinds for games / VMs)
hl.define_submap("passthrough", function()
	hl.bind(mainMod .. " + Pause", hl.dsp.submap("reset"))
	hl.bind(mainMod .. " + ALT + G", hl.dsp.submap("reset"))
end)
hl.bind(mainMod .. " + Pause", hl.dsp.submap("passthrough"))
hl.bind(mainMod .. " + ALT + G", hl.dsp.submap("passthrough"))

--------------------------------------------------------------------------------
-- SCREENSHOTS, UTILITIES & MULTIMEDIA
--------------------------------------------------------------------------------
-- Screenshots via Noctalia
hl.bind("Print", hl.dsp.exec_cmd(ipc .. "screenshot-region"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(ipc .. "screenshot-region"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(ipc .. "screenshot-annotate"))

-- Color picker
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(colorPicker))

-- Clipboard history picker (cliphist + Noctalia dmenu)
local clipboardCmd = "cliphist list | noctalia dmenu -p 'Clipboard' | cliphist decode | wl-copy"
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd(clipboardCmd))

-- Audio & Brightness keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

-- Media player controls (playerctl)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
-- Floating Noctalia settings window
hl.window_rule({ match = { class = "dev.noctalia.Noctalia" }, float = true, size = { 1080, 920 } })

-- Blur Noctalia's bar/panels/notifications
hl.layer_rule({
	name = "noctalia",
	match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
