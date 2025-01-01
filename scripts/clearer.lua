local blacklist = {
  ['character-corpse'] = true,
  ['transport-caution-corpse'] = true,  -- Transport Drones
  ['spidertron-enhancements-corpse'] = true, -- Spidertron Enhancements
  ['spidertron-remnants'] = true, -- Spidertron Enhancements
}

local YELLOW = { r = 254/255, g = 255/255, b = 10/255, a = 1}
local GREEN = { r = 49/255, g = 190/255, b = 48/255, a = 1}

--=================================================================================================

-- @ event: CustomInputEvent
-- Docs: https://lua-api.factorio.com/latest/events.html#CustomInputEvent
local function removeCorpses(event)
  local player = game.get_player(event.player_index)
  if not player then
    return
  end
  local radius = settings.get_player_settings(event.player_index)['rbc-radius'].value
  
  local bodyCount = 0
  for ___, entity in pairs(player.surface.find_entities_filtered{
    position = player.position,
    radius = radius,
    type = 'corpse'
  }) do 
    if not blacklist[entity.name] then 
      --game.print(entity.name)
      entity.destroy()
      bodyCount = bodyCount + 1
    end
  end
  if bodyCount > 0 then 
    player.print('Removed ' .. tostring(bodyCount) .. ' corpses', { color = YELLOW })
  else 
    player.print('Clear', { color = GREEN })
  end
end

--=================================================================================================

---@type ScriptLib
local Public = {}

Public.events = {
  ['rbc-remove-biters'] = removeCorpses
}

return Public