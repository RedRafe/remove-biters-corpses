local ZOOM_STEP_SIZE = 1.104  -- Factorio zoom step size
local MAX_STD_ZOOM = 3.281    -- Factorio maximum zoom level
local MIN_STD_ZOOM = 0.276    -- Factorio minimum zoom level

local blacklist = {
  'character-corpse',
  'transport-caution-corpse'  -- Transport Drones
}

--=================================================================================================

-- @ tableIn: Table
-- @ element: any
local function tableContains(tableIn, element)
  for ___, value in pairs(tableIn) do
    if value == element then
      return true
    end
  end
  return false
end

--=================================================================================================

-- @ event: CustomInputEvent
-- Docs: https://lua-api.factorio.com/latest/events.html#CustomInputEvent
local function removeCorpses(event)
  local player = game.players[event.player_index]
  if not player then return end
  local radius = settings.get_player_settings(event.player_index)['rbc-radius'].value
  
  local bodyCount = 0
  for ___, entity in pairs(player.surface.find_entities_filtered{
    position = player.position,
    radius = radius,
    type = 'corpse'}
  ) do 
    if not tableContains(blacklist, entity.name) then 
      --game.print(entity.name)
      entity.destroy()
      bodyCount = bodyCount + 1
    end
  end
  if bodyCount > 0 then 
    game.print('Removed ' .. tostring(bodyCount) .. ' corpses', {r=254/255, g=255/255, b=10/255, a=1})
  else 
    game.print('Clear', {r=49/255, g=190/255, b=48/255, a=1})
  end
end

script.on_event('rbc-remove-biters', removeCorpses)

--=================================================================================================

-- @ event: CustomInputEvent
-- Docs: https://lua-api.factorio.com/latest/events.html#CustomInputEvent
local function zoomIn(event)
  local player = game.players[event.player_index]

  if player.render_mode == defines.render_mode.game then
    player.zoom = math.min(player.zoom * ZOOM_STEP_SIZE, 10.0)
  end
end

script.on_event("rbc-zoom-in", zoomIn)

--=================================================================================================

-- @ event: CustomInputEvent
-- Docs: https://lua-api.factorio.com/latest/events.html#CustomInputEvent
local function zoomOut(event)
  local player = game.players[event.player_index]

  if player.render_mode == defines.render_mode.game then
    player.zoom = math.max(player.zoom / ZOOM_STEP_SIZE, 0.1)
  end
end

script.on_event("rbc-zoom-out", zoomOut)