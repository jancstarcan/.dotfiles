-- ==== WAYWALL GENERIC CONFIG ====
return {
    debug_text = false,

    -- ==== LOOKS ====
    resolution = { 1920, 1080 },

    bg_col = "#000000",
    toggle_bg_picture = false,
    text_col = "#FFFFFF",

    ninbot_anchor = {
        position = "topright",
        x = 0,
        y = 90,
    },
    ninbot_opacity = 1,


    -- ==== ALTERNATIVE RESOLUTIONS ====
    thin_res = { 340, 1080 },
    wide_res = { 1920, 300 },
    tall_res = { 384, 16384 },


    -- ==== MIRRORS ====
    e_count = { enabled = true, x = 1325, y = 300, size = 5, colorkey = false },

    thin_pie = { enabled = true, x = 1200, y = 400, size = 4, colorkey = true },
    tall_pie = { enabled = true, x = 1200, y = 400, size = 4, colorkey = true },

    thin_percent = { enabled = true, x = 1420, y = 440, size = 5, colorkey = false },
    tall_percent = { enabled = true, x = 1420, y = 440, size = 5, colorkey = false },
    percentages_match_text = false,

    measuring_window = { enabled = true, x = 30, y = 340, size = 10 },
    stretched_measure = true,
    glowdar_mirror = false,

    -- ==== KEYBINDS ====
    -- resolution changes
    thin = { key = "*-MB5", f3_safe = false, ingame_only = false },
    wide = { key = "*-MB4", f3_safe = false, ingame_only = false },
    tall = { key = "*-Y", f3_safe = false, ingame_only = false },

    -- startup actions
    -- toggle_fullscreen_key = "Shift-O",
    -- launch_paceman_key = "Shift-P",

    toggle_ninbot_key = "*-Alt-Escape",
    toggle_remaps_key = "Backslash",

    toggle_crosshair_key = "*-Period",
    crosshair_size = 20,

    -- ==== KEYBOARD ====
    xkb_config = {
        enabled = false,
        layout = "mc", -- ~/.config/xkb/symbols/mc
        rules = nil,   -- ~/.config/xkb/rules/...
        variant = "basic",
        options = "caps:none",
    },
    remaps_text_config = { text = "chat mode", x = 1920/2 - 285, y = 1080/2 - 70, size = 8, color = "#FF00FF" },

    -- ==== MISC ====
    res_1440 = false,
    sens_change = { enabled = true, normal = 5.71448656, tall = 0.38549585 },
    enable_resize_animations = false,
}
