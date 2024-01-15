data:extend({
  {
    type = 'int-setting',
    name = 'rbc-radius',
    setting_type = 'runtime-per-user',
    default_value = 32 * 5 / 2, -- 5 chunks
    minimum_value = 1,
    maximum_value = 32 * 50, -- 1000 chunks
    localised_name = {'mod-setting-name.rbc-radius'},
    localised_description = {'mod-setting-description.rbc-radius'},
    order = 'a'
  },
  {
    type = 'double-setting',
    name = 'rbc-zoom-level',
    setting_type = 'runtime-per-user',
    default_value = true,
    localised_name = {'mod-setting-name.rbc-black-lines'},
    localised_description = {'mod-setting-description.rbc-black-lines'},
    order = 'c'
  },
  {
    type = 'bool-setting',
    name = 'rbc-black-lines',
    setting_type = 'startup',
    default_value = true,
    localised_name = {'mod-setting-name.rbc-black-lines'},
    localised_description = {'mod-setting-description.rbc-black-lines'},
    order = 'c'
  }
})