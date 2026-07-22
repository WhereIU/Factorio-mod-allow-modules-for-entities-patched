-- =========================================================
-- 1. DYNAMIC EFFECT COLLECTION & MODULE VISUALS
-- =========================================================
local allow_all_categories = settings.startup["amfe2-allow-all-cat"].value
local everywhere_categories = {}
local split_pattern = "[^%s,]+"

if not allow_all_categories then
  local setting_cat_value = settings.startup["amfe2-allow-cat"].value or ""
  for setcat in setting_cat_value:gmatch(split_pattern) do
    table.insert(everywhere_categories, setcat)
  end
end

local everywhere_effects = {}
local known_effects = {}

local default_tints = {
  productivity = {primary = {r=1, g=0.463, b=0.322, a=1}, secondary = {r=1, g=0.976, b=0.388, a=1}},
  quality      = {primary = {r=0.95, g=0.95, b=0.95, a=1}, secondary = {r=1, g=0.05, b=0.05, a=1}},
  speed        = {primary = {r=0.34, g=0.68, b=1, a=1},    secondary = {r=0.7, g=0.9, b=1, a=1}},
  consumption  = {primary = {r=0.4, g=0.9, b=0.4, a=1},    secondary = {r=0.8, g=1, b=0.8, a=1}}
}

if data.raw.module then
  for name, module in pairs(data.raw.module) do
    if module.effect then
      for effect_name, _ in pairs(module.effect) do
        if not known_effects[effect_name] then
          known_effects[effect_name] = true
          table.insert(everywhere_effects, effect_name)
        end
      end
    end

    module.art_style = module.art_style or "vanilla"
    module.requires_beacon_alt_mode = false

    if not module.beacon_tint and module.category then
      module.beacon_tint = default_tints[module.category] or default_tints.speed
    end
  end
end

-- =========================================================
-- 2. ENTITY PROCESSING (BUILDINGS & BEACONS)
-- =========================================================
local amfe2_profile = {}
local setting_profile_value = settings.startup["amfe2-profile"].value or ""
for setpro in setting_profile_value:gmatch(split_pattern) do
  table.insert(amfe2_profile, tonumber(setpro))
end

local machinetypes = {
  beac = "beacon", asem = "assembling-machine", silo = "rocket-silo",
  furn = "furnace", lab = "lab", dril = "mining-drill"
}

local allow_surface = settings.startup["amfe2-allow-surface"].value
local extra_slots = settings.startup["amfe2-module-extra"].value
local beacon_counter = settings.startup["amfe2-counter"].value

if settings.startup["amfe2-allow-entity"].value then
  for shorthand, mtype in pairs(machinetypes) do
    if settings.startup["amfe2-allow-" .. shorthand].value and data.raw[mtype] then
      for _, entity in pairs(data.raw[mtype]) do
        if entity.name ~= "beacon-interface--beacon" then
          
          if #everywhere_effects > 0 then
            entity.allowed_effects = everywhere_effects
          end

          entity.effect_receiver = entity.effect_receiver or {}
          entity.effect_receiver.uses_module_effects = true
          entity.effect_receiver.uses_beacon_effects = true
          if allow_surface then
            entity.effect_receiver.uses_surface_effects = true
          end

          if allow_all_categories then
            entity.allowed_module_categories = nil
          else
            entity.allowed_module_categories = entity.allowed_module_categories or {}
            local existing = {}
            for _, cat in ipairs(entity.allowed_module_categories) do existing[cat] = true end
            for _, category in ipairs(everywhere_categories) do
              if not existing[category] then
                table.insert(entity.allowed_module_categories, category)
              end
            end
          end

          if extra_slots > 0 then
            entity.module_slots = (entity.module_slots or 0) + extra_slots
          end

          if mtype == "beacon" and #amfe2_profile > 0 then
            entity.profile = amfe2_profile
            entity.beacon_counter = beacon_counter
          end

        end
      end
    end
  end
end

-- =========================================================
-- 3. RECIPE PROCESSING & PRODUCTIVITY LIMITS
-- =========================================================
if data.raw.recipe then
  local allow_recipes = settings.startup["amfe2-allow-recipe"].value
  local max_prod = settings.startup["amfe2-maximum-productivity"].value

  for _, recipe in pairs(data.raw.recipe) do
    if allow_recipes then
      recipe.allow_consumption = true
      recipe.allow_speed = true
      recipe.allow_productivity = true
      recipe.allow_pollution = true
      recipe.allow_quality = true
      recipe.allowed_module_categories = nil
    end

    if max_prod > 0 and recipe.allow_productivity then
      recipe.maximum_productivity = max_prod
    end
  end
end