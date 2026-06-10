-- ==== WAYWALL ====
local waywall = require("waywall")
local helpers = require("waywall.helpers")

-- ==== USER CONFIG ====
local cfg = require("config")
local keyboard_remaps = require("remaps").remapped_kb
local other_remaps = require("remaps").normal_kb

-- ==== RESOURCES ====
local waywall_config_path = os.getenv("HOME") .. "/.config/waywall/"
local bg_path = waywall_config_path .. "resources/background.png"
local tall_overlay_path = waywall_config_path .. "resources/overlay_tall.png"
local thin_overlay_path = waywall_config_path .. "resources/overlay_thin.png"
local wide_overlay_path = waywall_config_path .. "resources/overlay_wide.png"

local pacem_path = waywall_config_path .. "resources/paceman-tracker-0.7.2.jar"
local nb_path = waywall_config_path .. "resources/Ninjabrain-Bot-1.5.2.jar"
local overlay_path = waywall_config_path .. "resources/measuring_overlay.png"
local stretched_overlay_path = waywall_config_path .. "resources/stretched_overlay.png"

local crosshair_path = waywall_config_path .. "resources/crosshair.png"

-- ==== INITS ====
local remaps_active = true
local rebind_text = nil
local thin_active = false
local keybinds_text = nil
local crosshair_image = nil
local crosshair_active = nil
local debug_text1 = nil
local debug_text2 = nil
local debug_text3 = nil
local debug_text4 = nil
local debug_text = "Press Shift + I to show keybinds.\n\n" ..
   "Look at the Github's README for a guide to config.\n\n" ..
   "disable this message by setting\n" ..
   "\'debug_text\' to false in ~/.config/waywall/config.lua\n"

-- ==== CONFIG TABLE ====
local read_file = function(name)
    local home = os.getenv("HOME")

    local file = io.open(home .. "/.config/waywall/" .. name, "r")
    local data = file:read("*a")
    file:close()

    return data
end

local config = {
   input = {
      layout = (cfg.xkb_config.enabled and cfg.xkb_config.layout) or nil,
      rules = (cfg.xkb_config.enabled and cfg.xkb_config.rules) or nil,
      variant = (cfg.xkb_config.enabled and cfg.xkb_config.variant) or nil,
      options = (cfg.xkb_config.enabled and cfg.xkb_config.options) or nil,

      repeat_rate = 40,
      repeat_delay = 300,
      remaps = keyboard_remaps,
      sensitivity = (cfg.sens_change.enabled and cfg.sens_change.normal) or 1.0,
      confine_pointer = false,
   },
   theme = {
      background = cfg.bg_col,
      background_png = cfg.toggle_bg_picture and bg_path or nil,
      ninb_anchor = cfg.ninbot_anchor,
      ninb_opacity = cfg.ninbot_opacity,
   },
   experimental = {
      debug = false,
      jit = false,
      tearing = false,
   },
   window = {
      fullscreen_width = cfg.resolution[1],
      fullscreen_height = cfg.resolution[2],
   },
   shaders = {
      ["pie_chart"] = {
         fragment = read_file("shaders/pie_chart.frag"),
      },
   },
}

-- ==== TOOLS ====
local is_ninb_running = function()
   local handle = io.popen("ps aux | grep '[N]injabrain-Bot.*\\.jar'")
   local result = handle:read("*l")
   handle:close()
   return result ~= nil
end

-- ==== MIRRORS ====
-- colors
local percentage_colors = {
   { input = "#E96D4D", output = cfg.percentages_match_text and cfg.text_col or "#CC5A3A" },
   { input = "#45CB65", output = cfg.percentages_match_text and cfg.text_col or "#35C46B" },
   -- { input = "#E145C2", output = cfg.percentages_match_text and cfg.text_col or "#E446C4" },
}

-- thin mirrors
if cfg.e_count.enabled then
   helpers.res_mirror(
      {
         src = { x = 13, y = 37, w = 37, h = 9 },
         dst = { x = cfg.e_count.x, y = cfg.e_count.y, w = 37 * cfg.e_count.size, h = 9 * cfg.e_count.size },
         depth = 2,
         color_key = cfg.e_count.colorkey and {
            input = "#DDDDDD",
            output = cfg.text_col,
                                              } or nil,
      },
      cfg.thin_res[1], cfg.thin_res[2]
   )
end

if cfg.thin_pie.enabled then
   local shader
   if cfg.tall_pie.colorkey then
      shader = "pie_chart"
   else
      shader = ""
   end

      helpers.res_mirror(
         {
            src = { x = cfg.thin_res[1] - 340, y = cfg.thin_res[2] - 406, w = 340, h = 221 },
            dst = { x = cfg.thin_pie.x, y = cfg.thin_pie.y, w = 420 * cfg.thin_pie.size / 4, h = 273 * cfg.thin_pie.size / 4 },
            shader = shader,
            depth = 2,
         },
         cfg.thin_res[1], cfg.thin_res[2]
      )
end

if cfg.thin_percent.enabled then
   if cfg.thin_percent.colorkey then
      for i, ck in ipairs(percentage_colors) do
         for j = 0, 2 do
            helpers.res_mirror({
                  src = {
                     x = cfg.thin_res[1] - 92,
                     y = cfg.thin_res[2] - 220 + j * 8,
                     w = 12,
                     h = 8,
                  },
                  
                  dst = {
                     x = cfg.thin_percent.x,
                     y = cfg.thin_percent.y + i * 8 * cfg.thin_percent.size - 2 * cfg.thin_percent.size,
                     w = 12 * cfg.thin_percent.size,
                     h = 8 * cfg.thin_percent.size,
                  },
                  
                  depth = 4,
                  color_key = ck,
               },
               
               cfg.thin_res[1], cfg.thin_res[2]
            )
         end
      end
   else
      helpers.res_mirror({
            src = {
               x = cfg.thin_res[1] - 93,
               y = cfg.thin_res[2] - 221,
               w = 13,
               h = 25,
            },
            
            dst = {
               x = cfg.thin_percent.x,
               y = cfg.thin_percent.y,
               w = 12 * cfg.thin_percent.size,
               h = 24 * cfg.thin_percent.size,
            },
            
            depth = 4,
         }, cfg.thin_res[1], cfg.thin_res[2]
      )
   end
end

-- tall mirrors
if cfg.tall_pie.enabled then
   local shader
   if cfg.tall_pie.colorkey then
      shader = "pie_chart"
   else
      shader = ""
   end

   helpers.res_mirror(
      {
         src = { x = 44, y = 15978, w = 340, h = 221 },
         dst = { x = cfg.tall_pie.x, y = cfg.tall_pie.y, w = 420 * cfg.tall_pie.size / 4, h = 273 * cfg.tall_pie.size / 4 },
         depth = 2,
         shader = shader,
      },
      cfg.tall_res[1], cfg.tall_res[2]
   )
end

if cfg.tall_percent.enabled then
   if cfg.tall_percent.colorkey then
      for i, ck in ipairs(percentage_colors) do
         for j = 0, 2 do
            helpers.res_mirror(
               {
                  src = {
                     x = 292,
                     y = 16164 + j * 8,
                     w = 12,
                     h = 8
                  },

                  dst = {
                     x = cfg.tall_percent.x,
                     y = cfg.tall_percent.y + i * 8 * cfg.tall_percent.size - 2 * cfg.tall_percent.size,
                     w = 12 * cfg.tall_percent.size,
                     h = 8 * cfg.tall_percent.size
                  },
                  depth = 3,
                  color_key = ck,
               },
               cfg.tall_res[1], cfg.tall_res[2]
            )
         end
      end
   else
      helpers.res_mirror(
         {
            src = {
               x = 291,
               y = 16163,
               w = 13,
               h = 25
            },
            
            dst = {
               x = cfg.tall_percent.x,
               y = cfg.tall_percent.y,
               w = 13 * cfg.tall_percent.size,
               h = 25 * cfg.tall_percent.size
            },
            depth = 3,
         },
         cfg.tall_res[1], cfg.tall_res[2]
      )
   end
end

helpers.res_mirror(
   {
      src = cfg.stretched_measure
         and { x = (cfg.tall_res[1] - 30) / 2, y = (cfg.tall_res[2] - 580) / 2, w = 30, h = 580 }
         or { x = (cfg.tall_res[1] - 60) / 2, y = (cfg.tall_res[2] - 580) / 2, w = 60, h = 580 },
      dst = { x = cfg.measuring_window.x, y = cfg.measuring_window.y, w = 70 * cfg.measuring_window.size, h = 40 * cfg.measuring_window.size },
      depth = 2,
   },
   cfg.tall_res[1], cfg.tall_res[2]
)

-- ==== IMAGES ====
helpers.res_image(
   cfg.stretched_measure and stretched_overlay_path or overlay_path,
   {
      dst = { x = cfg.measuring_window.x, y = cfg.measuring_window.y, w = 70 * cfg.measuring_window.size, h = 40 * cfg.measuring_window.size },
      depth = 3,
   },
   cfg.tall_res[1], cfg.tall_res[2]
)
helpers.res_image(
   tall_overlay_path,
   {
      dst = { x = 0, y = 0, w = cfg.resolution[1], h = cfg.resolution[2] },
      depth = 1,
   },
   cfg.tall_res[1], cfg.tall_res[2]
)
helpers.res_image(
   wide_overlay_path,
   {
      dst = { x = 0, y = 0, w = cfg.resolution[1], h = cfg.resolution[2] },
      depth = 1,
   },
   cfg.wide_res[1], cfg.wide_res[2]
)
helpers.res_image(
   thin_overlay_path,
   {
      dst = { x = 0, y = 0, w = cfg.resolution[1], h = cfg.resolution[2] },
      depth = 1,
   },
   cfg.thin_res[1], cfg.thin_res[2]
)

-- ==== PIE MIRROR ===
if cfg.glowdar_mirror then
   for i = 0, 3, 1 do
      local s = 4;
      helpers.res_mirror(
         {
            src = { x = 1828, y = 860 + i * 8, w = 32, h = 8 },
            dst = { x = 1750 - 16 * s, y = 760, w = 32 * s, h = 8 * s },
            depth = 3,
            color_key = { input = "#4de1ca", output = "#ffffff" }
         },
         0, 0
      )
      helpers.res_mirror(
         {
            src = { x = 1828, y = 860 + i * 8, w = 32, h = 8 },
            dst = { x = 1750 - 16 * s + s, y = 760 + s, w = 32 * s, h = 8 * s },
            depth = 2,
            color_key = { input = "#4de1ca", output = "#000000" }
         },
         0, 0
      )
   end
end

-- ==== DEBUG TEXT ====
waywall.listen("load", function()
                  if cfg.debug_text then
                     debug_text1 = waywall.text(debug_text,
                                                { x = 10, y = 10, color = "#FFFF00", size = 3 })
                     debug_text2 = waywall.text(debug_text,
                                                { x = 11, y = 11, color = "#FFFF00", size = 3 })
                     debug_text3 = waywall.text(debug_text,
                                                { x = 13, y = 13, color = "#000000", size = 3 })
                     debug_text4 = waywall.text(debug_text,
                                                { x = 14, y = 14, color = "#000000", size = 3 })
                  end
end)

-- ==== RESIZING STATES ====
local thin_enable = function()
   thin_active = true
   if cfg.sens_change.enabled then
      waywall.set_sensitivity(cfg.sens_change.normal)
   end
end
local tall_enable = function()
   if cfg.sens_change.enabled and not thin_active then
      waywall.set_sensitivity(cfg.sens_change.tall)
   end
   thin_active = false
end
local wide_enable = function()
   if cfg.sens_change.enabled then
      waywall.set_sensitivity(cfg.sens_change.normal)
   end
   thin_active = false
end
local res_disable = function()
   if cfg.sens_change.enabled then
      waywall.set_sensitivity(cfg.sens_change.normal)
   end
   thin_active = false
end

-- ==== RESOLUTIONS ====
local make_res = function(width, height, enable, disable)
   return function()
      local active_width, active_height = waywall.active_res()

      if active_width == width and active_height == height then
         if cfg.enable_resize_animations then
            os.execute('echo "0x0" > ~/.resetti_state')
            waywall.sleep(17)
         end
         waywall.set_resolution(0, 0)
         disable()
      else
         if cfg.enable_resize_animations then
            os.execute(string.format('echo "%dx%d" > ~/.resetti_state', width, height))
            waywall.sleep(17)
         end
         waywall.set_resolution(width, height)
         enable()
      end
   end
end

local resolutions = {
   thin = make_res(cfg.thin_res[1], cfg.thin_res[2], thin_enable, res_disable),
   tall = make_res(cfg.tall_res[1], cfg.tall_res[2], tall_enable, res_disable),
   wide = make_res(cfg.wide_res[1], cfg.wide_res[2], wide_enable, res_disable),
}

local function resize_helper(mode, run, ingame_only)
   local resize = function()
      if not remaps_active then
         return false
      end
      if mode.f3_safe and waywall.get_key("F3") then
         return false
      end
      return run()
   end

   if ingame_only then
      return helpers.ingame_only(resize)
   end

   return resize
end

-- ==== KEYBINDS ====
config.actions = {

   [cfg.thin.key] = resize_helper(cfg.thin, resolutions.thin, cfg.thin.ingame_only),
   [cfg.wide.key] = resize_helper(cfg.wide, resolutions.wide, cfg.wide.ingame_only),
   [cfg.tall.key] = resize_helper(cfg.tall, resolutions.tall, cfg.tall.ingame_only),

   [cfg.toggle_ninbot_key] = function()
      if not is_ninb_running() then
         waywall.exec("java -Dawt.useSystemAAFontSettings=on -jar " .. nb_path)
         waywall.show_floating(true)
      else
         helpers.toggle_floating()
      end
   end,

   [cfg.toggle_remaps_key] = function()
      if rebind_text then
         rebind_text:close()
         rebind_text = nil
      end
      if remaps_active then
         remaps_active = false
         waywall.set_remaps(other_remaps)

         if cfg.xkb_config.enabled then
            waywall.set_keymap({
                  layout = nil,
                  rules = nil,
                  variant = nil,
                  options = nil,
            })
         end

         rebind_text = waywall.text(cfg.remaps_text_config.text,
                                    {
                                       x = cfg.remaps_text_config.x,
                                       y = cfg.remaps_text_config.y,
                                       color = cfg.remaps_text_config.color,
                                       size = cfg.remaps_text_config.size
         })
      else
         remaps_active = true
         waywall.set_remaps(keyboard_remaps)

         if cfg.xkb_config.enabled then
            waywall.set_keymap({
                  layout = cfg.xkb_config.layout,
                  rules = cfg.xkb_config.rules,
                  variant = cfg.xkb_config.variant,
                  options = cfg.xkb_config.options
            })
         end
      end
   end,

   [cfg.toggle_crosshair_key] = function()
      if crosshair_image then
         crosshair_image:close(); crosshair_image = nil
      end
      if crosshair_active then
         crosshair_active = false
      else
         crosshair_active = true
         crosshair_image = waywall.image(crosshair_path, {
                                            dst = {
                                               x = (cfg.resolution[1] - cfg.crosshair_size - 1) / 2,
                                               y = (cfg.resolution[2] - cfg.crosshair_size - 1) / 2,
                                               w = cfg.crosshair_size,
                                               h = cfg.crosshair_size,
                                            }
         })
      end
   end
}

return config
