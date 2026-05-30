-- Items
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/modifiers.json")
Tracker:AddItems("items/knowledge_elements.json")

Tracker:AddMaps("maps/maps.json")
ScriptHost:LoadScript("scripts/locations.lua")

-- Layout
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

-- Update total cubes with Golden and Anti counts
local function updateTotal()
    local g = Tracker:FindObjectForCode("golden")
    local a = Tracker:FindObjectForCode("anti")
    local t = Tracker:FindObjectForCode("total")

    if not g or not a or not t then
        return
    end

    t.AcquiredCount = g.AcquiredCount + a.AcquiredCount
end

ScriptHost:AddWatchForCode("WatchGolden", "golden", updateTotal)
ScriptHost:AddWatchForCode("WatchAnti", "anti", updateTotal)
ScriptHost:AddWatchForCode("PreventTotal", "total", updateTotal)

local function updateKnowTetro()
    local total = Tracker:FindObjectForCode("total")
    local throne = Tracker:FindObjectForCode("bigthrone_room")
    local know_tetro = Tracker:FindObjectForCode("know_tetro")

    if not total or not throne or not know_tetro then
        return
    end

    know_tetro.Active = throne.Active and total.AcquiredCount >= 2
end

ScriptHost:AddOnFrameHandler("updateKnowTetro", updateKnowTetro)
