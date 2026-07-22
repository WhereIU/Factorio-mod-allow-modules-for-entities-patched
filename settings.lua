data:extend({
  -- =========================================================
  -- 1. MODULE CATEGORIES & UNLOCKS
  -- =========================================================
  {
    type = "bool-setting",
    name = "amfe2-allow-all-cat",
    setting_type = "startup",
    default_value = true,
    order = "a0"
  },
  {
    type = "string-setting",
    name = "amfe2-allow-cat",
    setting_type = "startup",
    default_value = "speed, efficiency, productivity, quality, overclock",
    allow_blank = true,
    order = "a1"
  },

  -- =========================================================
  -- 2. GLOBAL ENTITY & DLC SETTINGS
  -- =========================================================
  {
    type = "bool-setting",
    name = "amfe2-allow-entity",
    setting_type = "startup",
    default_value = true,
    order = "b0"
  },
  {
    type = "bool-setting",
    name = "amfe2-allow-surface",
    setting_type = "startup",
    default_value = true,
    order = "b1"
  },
  {
    type = "int-setting",
    name = "amfe2-module-extra",
    setting_type = "startup",
    default_value = 0,
    minimum_value = 0,
    maximum_value = 64,
    order = "b2"
  },

  -- =========================================================
  -- 3. TARGET BUILDING CATEGORIES
  -- =========================================================
  { type = "bool-setting", name = "amfe2-allow-asem", setting_type = "startup", default_value = true, order = "c1" },
  { type = "bool-setting", name = "amfe2-allow-furn", setting_type = "startup", default_value = true, order = "c2" },
  { type = "bool-setting", name = "amfe2-allow-silo", setting_type = "startup", default_value = true, order = "c3" },
  { type = "bool-setting", name = "amfe2-allow-lab",  setting_type = "startup", default_value = true, order = "c4" },
  { type = "bool-setting", name = "amfe2-allow-dril", setting_type = "startup", default_value = true, order = "c5" },
  { type = "bool-setting", name = "amfe2-allow-beac", setting_type = "startup", default_value = true, order = "c6" },

  -- =========================================================
  -- 4. BEACON EFFECTS & PROFILES
  -- =========================================================
  {
    type = "string-setting",
    name = "amfe2-profile",
    setting_type = "startup",
    default_value = "1,0.7071,0.5773,0.5,0.4472,0.4082,0.3779,0.3535,0.3333,0.3162,0.3015,0.2886,0.2773,0.2672,0.2581,0.25",
    allow_blank = true,
    order = "d1"
  },
  {
    type = "string-setting",
    name = "amfe2-counter",
    setting_type = "startup",
    allowed_values = {"total", "same_type"},
    default_value = "total",
    order = "d2"
  },

  -- =========================================================
  -- 5. RECIPE RESTRICTIONS
  -- =========================================================
  {
    type = "bool-setting",
    name = "amfe2-allow-recipe",
    setting_type = "startup",
    default_value = true,
    order = "e1"
  },

  -- =========================================================
  -- 6. PRODUCTIVITY LIMITS
  -- =========================================================
  {
    type = "double-setting",
    name = "amfe2-maximum-productivity",
    setting_type = "startup",
    minimum_value = 0.0,
    default_value = 0.0,
    maximum_value = 100.0,
    order = "f1"
  }
})