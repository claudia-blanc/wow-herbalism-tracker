-- Main HerbalismTracker addon file
local addonName = "HerbalismTracker"

-- Get addon namespace
local HT = _G[addonName]

-- Create main addon frame
-- A frame is a fundamental UI object that can handle events and user interactions.
local frame = CreateFrame("Frame", "HerbalismTracker")

-- Function to get player coordinates
local function GetPlayerCoords()
    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then
        return nil, nil, nil
    end

    local position = C_Map.GetPlayerMapPosition(mapID, "player")
    if not position then
        return nil, nil, nil
    end

    local x, y = position:GetXY()
    return mapID, x * 100, y * 100 -- Convert to percentages (0-100)
end

-- Register events we want to listen for
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("CHAT_MSG_LOOT")

-- ... captures the event parameters
-- ADDON_LOADED -> addonName
-- CHAT_MSG_LOOT -> message
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "HerbalismTracker" then
            print("HerbalismTracker: Addon loaded successfully!")
            -- Initialize modules
            HT.Storage.Initialize()
            HT.Classic.Initialize()
            HT.MapDisplay.Initialize()
        end

    elseif event == "PLAYER_LOGIN" then
        -- Show how many locations we have stored (after SavedVariables are loaded)
        local totalLocations = HT.Storage.GetTotalLocationCount()
        print(string.format("HerbalismTracker: Loaded %d saved herb locations", totalLocations))

    elseif event == "CHAT_MSG_LOOT" then
        local message = ...

        -- Only process if it's YOUR loot (starts with "You receive loot:")
        if message:find("^You receive loot:") then
            local itemName = message:match("%[(.+)%]")

            -- print("DEBUG: Looted item:", itemName)
            -- print("DEBUG: Is herb:", HT.Classic.IsHerb(itemName))
            if itemName and HT.Classic.IsHerb(itemName) then
                local mapID, x, y = GetPlayerCoords()
                if mapID and x and y then
                    local saved = HT.Storage.SaveHerbLocation(itemName, mapID, x, y)
                    if saved then
                        HT.MapDisplay.UpdateMapPins()
                    end
                end
            end
        end
    end
end)
