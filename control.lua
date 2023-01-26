local blacklist = {
  "character-corpse"
}

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

-- @ event: CustomInputEvent
-- Docs: https://lua-api.factorio.com/latest/events.html#CustomInputEvent
script.on_event("rbc-remove-biters", function(event)
  local player = game.players[event.player_index]
  if not player then return end
  local radius = settings.get_player_settings(event.player_index)["rbc-radius"].value
  
  c = 0
  for ___, entity in pairs(player.surface.find_entities_filtered{
    position = player.position,
    radius = radius,
    type = "corpse"}
  ) do 
    if not tableContains(blacklist, entity.name) then 
      entity.destroy()
      c = c + 1
    end
  end
  if c > 0 then 
    game.print("Removed " .. tostring(c) .. " corpses", {r=254/255, g=255/255, b=10/255, a=1})
  else 
    game.print("Clear", {r=49/255, g=190/255, b=48/255, a=1})
  end
end)
