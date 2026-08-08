hl.env("HYPRCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("MOZ_ENABLE_WAYLAND", "1")

hl.on("hyprland.start", function ()
    hl.exec_cmd(
        "dbus-update-activation-environment --systemd " ..
        "WAYLAND_DISPLAY XDG_CURRENT_DESKTOP " ..
        "HYPRCURSOR_THEME HYPRCURSOR_SIZE " ..
        "XCURSOR_THEME XCURSOR_SIZE"
    )

    hl.exec_cmd(
        "systemctl --user import-environment " ..
        "WAYLAND_DISPLAY XDG_CURRENT_DESKTOP " ..
        "HYPRCURSOR_THEME HYPRCURSOR_SIZE " ..
        "XCURSOR_THEME XCURSOR_SIZE"
    )

    hl.exec_cmd("swaybg -i /home/jan/Wallpapers/wall -m fill")
    hl.exec_cmd("keyd-application-mapper -d")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpm reload -n")
    hl.exec_cmd("discord")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("hyprctl setcursor Adwaita 24")
    hl.exec_cmd("openrgb --startminimized")
end)

hl.monitor({
      output = "DP-1",
      mode = "2560x1440@180",
      position = "0x0",
      scale = 1.25,
      vrr = 1,
})

hl.monitor({
      output = "DP-2",
      mode = "1920x1080@165",
      position = "auto-center-right",
      scale = 1,
      vrr = 1,
})

local terminal = "foot"
local minecraft = "prismlauncher"
local browser = "firefox"
local menu = "bemenu-run --fn \"Iosevka Nerd Font 16\""

hl.config({
      general = {
         gaps_in = 0,
         gaps_out = 0,

         border_size = 2,

         col = {
            active_border   = "rgba(285577ff)",
            inactive_border = "rgba(222222ff)",
         },

         resize_on_border = false,

         allow_tearing = false,

         layout = "hy3",
      },

      plugin = {
         hy3 = {
            tabs = {
               height = 24,
               padding = 0,
               radius = 0,
               border_width = 1,
               text_font = "Iosevka Nerd Font Mono",
               text_height = 12,
               text_padding = 6,
               colors = {
                  active = "rgba(285577ff)",
                  active_border = "rgba(4c7899ff)",
                  active_text = "rgba(ffffffff)",
                  inactive = "rgba(222222ff)",
                  inactive_border = "rgba(444444ff)",
                  inactive_text = "rgba(777777ff)"
               }
            }
         }
      },

      decoration = {
         rounding = 0,
         rounding_power = 2,

         active_opacity   = 1.0,
         inactive_opacity = 1.0,

         shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
         },

         blur = {
            enabled   = false,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
         },
      },

      animations = {
         enabled = true,
      },

    xwayland = {
        force_zero_scaling = true
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.curve("easy",           { type = "spring", mass = 0.55, stiffness = 229.2633, dampening = 21.5 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

hl.config({
      dwindle = {
         preserve_split = true,
      },
})

hl.config({
      master = {
         new_status = "master",
      },
})

hl.config({
      scrolling = {
         fullscreen_on_one_column = true,
      },
})

hl.config({
      misc = {
         force_default_wallpaper = -1,
         disable_hyprland_logo   = false,
      },
})

hl.config({
      input = {
         kb_layout  = "us,it,si",
         kb_variant = "",
         kb_model   = "",
         kb_options = "",
         kb_rules   = "",

         follow_mouse = 1,

         accel_profile = "flat",

         sensitivity = 0,
      },
})

hl.device({
    name  = "epic-mouse-v1",
    accel_profile = "flat",
    sensitivity = 0,
})

local mainMod = "SUPER"

local hy3 = hl.plugin.hy3

hl.bind("SUPER + SHIFT + F1",
    hl.dsp.exec_cmd("hyprctl switchxkblayout current 0"))
hl.bind("SUPER + SHIFT + F2",
    hl.dsp.exec_cmd("hyprctl switchxkblayout current 1"))
hl.bind("SUPER + SHIFT + F3",
    hl.dsp.exec_cmd("hyprctl switchxkblayout current 2"))

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("emacsclient -c"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("emacs"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(minecraft))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obs"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("killall -9 waybar; waybar; hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(browser .. " --private-window"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("woomer --monitor \"DP-1\""))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("cliphist list | wofi -S dmenu | cliphist decode | wl-copy"))

-- Fullscreen
hl.bind("Print", hl.dsp.exec_cmd(
    'grim -o "$(hyprctl monitors -j | jq -r \'.[] | select(.focused) | .name\')" - | wl-copy --type image/png'
))
-- Area
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(
    'grim -g "$(slurp -d)" - | wl-copy --type image/png'
))
-- Focused window
hl.bind("ALT + Print", hl.dsp.exec_cmd(
    [[hyprctl activewindow -j |
      jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' |
      grim -g - - |
      wl-copy --type image/png]]
))

hl.bind(mainMod .. " + Q", hy3.kill_active())

hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + B", hy3.make_group("h"))
hl.bind(mainMod .. " + V", hy3.make_group("v"))

hl.bind(mainMod .. " + W", hy3.change_group("tab"))
hl.bind(mainMod .. " + E", hy3.change_group("opposite"))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + A", hy3.change_focus("raise"))
hl.bind(mainMod .. " + X", hy3.change_focus("lower"))

hl.bind(mainMod .. " + D", hy3.toggle_focus_layer())

hl.bind(mainMod .. " + H", hy3.move_focus("l"))
hl.bind(mainMod .. " + L", hy3.move_focus("r"))
hl.bind(mainMod .. " + K", hy3.move_focus("u"))
hl.bind(mainMod .. " + J", hy3.move_focus("d"))

hl.bind(mainMod .. " + SHIFT + H", hy3.move_window("l"))
hl.bind(mainMod .. " + SHIFT + L", hy3.move_window("r"))
hl.bind(mainMod .. " + SHIFT + K", hy3.move_window("u"))
hl.bind(mainMod .. " + SHIFT + J", hy3.move_window("d"))

hl.bind(mainMod .. " + Period", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + Comma", hl.dsp.focus({ monitor = "-1" }))
hl.bind(mainMod .. " + SHIFT + Period", hl.dsp.window.move({ monitor = "+1", follow = false }))
hl.bind(mainMod .. " + SHIFT + Comma", hl.dsp.window.move({ monitor = "-1", follow = false }))

for i = 1, 5 do
   hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
   hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i , follow = false}))
   hl.workspace_rule({ workspace = i, monitor = "DP-1" })
end

for i = 6, 10 do
   local key = i - 5
   hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.focus({ workspace = i }))
   hl.bind(mainMod .. " + ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
   hl.workspace_rule({ workspace = i, monitor = "DP-2" })
end

hl.bind(mainMod .. " + minus", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.window_rule({
      name  = "move-discord",
      match = { class = "^(discord)$" },
      no_initial_focus  = true,
      center = true,
      workspace = 8,
})

hl.window_rule({
      name  = "move-steam",
      match = { class = "^(steam)$" },
      no_initial_focus  = true,
      center = true,
      workspace = 4,
})

hl.window_rule({
      name  = "fix-xwayland-drags",
      match = {
         class      = "^$",
         title      = "^$",
         xwayland   = true,
         float      = true,
         fullscreen = false,
         pin        = false,
      },

      no_focus = true,
})

hl.window_rule({
      name  = "move-hyprland-run",
      match = { class = "hyprland-run" },
      
      move  = "20 monitor_h-120",
      float = true,
})
