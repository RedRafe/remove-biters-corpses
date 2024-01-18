local RENDER_GAME = defines.render_mode.game
local ZOOM_STEP = 1.12
local ZOOM_MAX = 10.0
local ZOOM_MIN =  0.1

global.zoom = global.zoom or {}

-- @ index uint
-- @ zoom double
local function setPlayerZoom(index, zoom)
  if not index then return end

  global.zoom[index] = zoom or 1.0
end

-- @ index uint
local function getPlayerZoom(index)
  return global.zoom and global.zoom[index] or 1.0
end

-- @ event defines.events.on_player_created|on_player_joined_game
local function init_new_player(event)
  setPlayerZoom(event.player_index)
end

-- @ event: CustomInputEvent
-- Docs: https://lua-api.factorio.com/latest/events.html#CustomInputEvent
local function zoomIn(event)
  local index = event.player_index
  local player = game.players[index]
  if not (player and player.valid) then return end
  if not settings.get_player_settings(index)['rbc-zoom-level'].value then return end

  if player.render_mode == RENDER_GAME then
    local zoom = math.min(getPlayerZoom(index) * ZOOM_STEP, ZOOM_MAX)
    player.zoom = zoom
    setPlayerZoom(index, zoom)
  end
end

-- @ event: CustomInputEvent
-- Docs: https://lua-api.factorio.com/latest/events.html#CustomInputEvent
local function zoomOut(event)
  local index = event.player_index
  local player = game.players[index]
  if not (player and player.valid) then return end
  if not settings.get_player_settings(index)['rbc-zoom-level'].value then return end

  if player.render_mode == RENDER_GAME then
    local zoom = math.max(getPlayerZoom(index) / ZOOM_STEP, ZOOM_MIN)
    player.zoom = zoom
    setPlayerZoom(index, zoom)
  end
end

--=================================================================================================

---@type ScriptLib
local Public = {}

Public.on_init = function()
  global.zoom = global.zoom or {}

  for _, player in pairs(game.players) do
    setPlayerZoom(player.index)
  end
end

Public.events = {
  [defines.events.on_player_created] = init_new_player,
  [defines.events.on_player_joined_game] = init_new_player,
  ['rbc-zoom-in'] = zoomIn,
  ['rbc-zoom-out'] = zoomOut,
}

return Public