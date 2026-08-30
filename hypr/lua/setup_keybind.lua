---@diagnostic disable: undefined-global

local terminal    = "wezterm"
local fileManager = "nautilus"
local menu        = "hyprlauncher"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

-- closeWindowBind:set_enabled(false)
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

local mainModShift = mainMod .. " + SHIFT"

hl.bind(mainModShift .. " + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainModShift .. " + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainModShift .. " + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainModShift .. " + down",  hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", function ()
    -- hl.notification.create({ text = "Hello", timeout = 3000})
   hl.dsp.window.swap({ direction = "l" })
end)

-- Laptop multimedia keys for volume and LCD brightness
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
-- hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

-- hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("command -v hyprlauncher >/dev/null 2>&1 && hyprlauncher"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("command -v wofi >/dev/null 2>&1 && wofi --show=drun"))

hl.bind(mainMod .. " + Delete", hl.dsp.submap("system"))

hl.define_submap("system", function()
    hl.bind("E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
    hl.bind("U", hl.dsp.exec_cmd("systemctl poweroff"))

    hl.bind("escape", hl.dsp.submap("reset"))
end)


hl.bind(mainMod .. " + SHIFT + B", hl.dsp.submap("brightness"))

hl.define_submap("brightness", function()
    hl.bind("K", hl.dsp.exec_cmd("brightnessctl set +5%"))
    hl.bind("up", hl.dsp.exec_cmd("brightnessctl set +5%"))


    local decrease_brightness = "bash -c '[[ $(brightnessctl g) -gt $(( $(brightnessctl m) * 10 / 100 )) ]] && brightnessctl -n set 5%-'"

    hl.bind("J", hl.dsp.exec_cmd(decrease_brightness))
    hl.bind("down", hl.dsp.exec_cmd(decrease_brightness))

    hl.bind("escape", hl.dsp.submap("reset"))
end)



hl.bind(mainMod .. " + SHIFT + V", hl.dsp.submap("volume"))

hl.define_submap("volume", function()
    hl.bind("M", hl.dsp.exec_cmd("pactl set-sink-mute 0 toggle"))

    hl.bind("escape", hl.dsp.submap("reset"))
end)
