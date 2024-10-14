data:extend({
  -- remove corpses
  {
    type = 'custom-input',
    name = 'rbc-remove-biters',
    key_sequence = 'BACKSPACE',
    alternative_key_sequence = 'CONTROL + BACKSPACE',
    localised_name = {'custom-input-name.rbc-remove-biters'},
    localised_description = {'custom-input-description.rbc-remove-biters'},
  },
  -- adjust zoom
  {
    name = 'rbc-zoom-in',
    type = 'custom-input',
    key_sequence = '',
    linked_game_control = 'zoom-in',
    consuming = 'none'
  },
  {
    name = 'rbc-zoom-out',
    type = 'custom-input',
    key_sequence = '',
    linked_game_control = 'zoom-out',
    consuming = 'none'
  },
})