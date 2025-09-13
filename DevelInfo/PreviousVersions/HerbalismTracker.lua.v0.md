```lua
-- Create main addon frame
-- A frame is a fundamental UI object that can handle events and user interactions.
local frame = CreateFrame("Frame", "HerbalismTracker")

-- Initialize database
-- Database structure: [mapID][herbName] = {{x=45, y=67, time=123456}, ...}
-- Saved when the user logs out in
-- /Applications/World of Warcraft/_classic_era_/WTF/Account/LAOSLOS/SavedVariables/HerbalismTracker.lua
HerbalismTrackerDB = HerbalismTrackerDB or {}

-- List of herbs (add more as you discover them)
local herbList = {
    ["Peacebloom"] = true,
    ["Silverleaf"] = true,
    ["Earthroot"] = true,
    ["Mageroyal"] = true,
    ["Briarthorn"] = true,
    ["Swiftthistle"] = true,
    ["Stranglekelp"] = true,
    ["Bruiseweed"] = true,
    ["Wild Steelbloom"] = true,
    ["Grave Moss"] = true,
    ["Kingsblood"] = true,
    ["Liferoot"] = true,
    ["Fadeleaf"] = true,
    ["Goldthorn"] = true,
    ["Khadgar's Whisker"] = true,
    ["Wintersbite"] = true,
    ["Firebloom"] = true,
    ["Purple Lotus"] = true,
    ["Arthas' Tears"] = true,
    ["Sungrass"] = true,
    ["Blindweed"] = true,
    ["Ghost Mushroom"] = true,
    ["Gromsblood"] = true,
    ["Golden Sansam"] = true,
    ["Dreamfoil"] = true,
    ["Mountain Silversage"] = true,
    ["Plaguebloom"] = true,
    ["Icecap"] = true,
    ["Black Lotus"] = true,
}

local herbLevels = {
    ["Peacebloom"] = { 1, 25, 50, 100 },
    ["Silverleaf"] = { 1, 25, 50, 100 },
    ["Earthroot"] = { 15, 40, 65, 115 },
    ["Mageroyal"] = { 50, 75, 100, 150 },
    ["Briarthorn"] = { 70, 95, 120, 170 },
    ["Swiftthistle"] = { 50, 75, 100, 150 },
    ["Stranglekelp"] = { 85, 110, 135, 185 },
    ["Bruiseweed"] = { 100, 125, 150, 200 },
    ["Wild Steelbloom"] = { 115, 140, 165, 215 },
    ["Grave Moss"] = { 120, 145, 170, 220 },
    ["Kingsblood"] = { 125, 150, 175, 225 },
    ["Liferoot"] = { 150, 175, 200, 250 },
    ["Fadeleaf"] = { 160, 185, 210, 260 },
    ["Goldthorn"] = { 170, 195, 220, 270 },
    ["Khadgar's Whisker"] = { 185, 210, 235, 285 },
    ["Wintersbite"] = { 195, 220, 245, 295 },
    ["Firebloom"] = { 205, 230, 255, 305 },
    ["Purple Lotus"] = { 210, 235, 260, 310 },
    ["Arthas' Tears"] = { 220, 245, 270, 320 },
    ["Sungrass"] = { 230, 255, 280, 330 },
    ["Blindweed"] = { 235, 260, 285, 335 },
    ["Ghost Mushroom"] = { 245, 270, 295, 345 },
    ["Gromsblood"] = { 250, 275, 300, 350 },
    ["Golden Sansam"] = { 260, 285, 310, 360 },
    ["Dreamfoil"] = { 270, 290, 315, 370 },
    ["Mountain Silversage"] = { 280, 305, 330, 380 },
    ["Plaguebloom"] = { 285, 310, 335, 385 },
    ["Icecap"] = { 290, 315, 340, 390 },
    ["Black Lotus"] = { 300, 325, 350, 400 },
}

-- Table to store map pins
local mapPins = {}

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

-- Function to calculate distance between two points
local function GetDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

-- Function to check if location is too close to existing ones
local function IsLocationTooClose(herbName, mapID, x, y, minDistance)
    if not HerbalismTrackerDB[mapID] or not HerbalismTrackerDB[mapID][herbName] then
        return false -- No existing locations, so it's not too close
    end
    
    -- Check distance to all existing locations of this herb type
    for _, location in pairs(HerbalismTrackerDB[mapID][herbName]) do
        local distance = GetDistance(x, y, location.x, location.y)
        if distance < minDistance then
            return true -- Too close to an existing location
        end
    end
    
    return false -- Not too close to any existing location
end

-- Function to save location
local function SaveHerbLocation(herbName, mapID, x, y)
    local minDistance = 1 -- Minimum distance between herb icons
    
    -- Check if this location is too close to existing ones
    if IsLocationTooClose(herbName, mapID, x, y, minDistance) then
        print(string.format("Skipped %s at %.1f, %.1f (too close to existing location)", 
            herbName, x, y))
        return
    end
    
    -- Create map entry if it doesn't exist
    if not HerbalismTrackerDB[mapID] then
        HerbalismTrackerDB[mapID] = {}
    end
    
    -- Create herb entry if it doesn't exist
    if not HerbalismTrackerDB[mapID][herbName] then
        HerbalismTrackerDB[mapID][herbName] = {}
    end
    
    -- Add this location to the herb's location list
    table.insert(HerbalismTrackerDB[mapID][herbName], {x = x, y = y, time = time()})
    
    print(string.format("Saved %s at %.1f, %.1f (Total: %d locations)", 
        herbName, x, y, #HerbalismTrackerDB[mapID][herbName]))
        
    -- Update map display
    UpdateMapPins()
end

-- Icon mapping for each herb (add this after the herbList)
local herbIcons = {
    ["Peacebloom"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Peacebloom",
    ["Silverleaf"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Silverleaf",
    ["Earthroot"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Earthroot",
    ["Mageroyal"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Mageroyal",
    ["Briarthorn"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Briarthorn",
    ["Swiftthistle"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Swiftthistle",
    ["Bruiseweed"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Bruiseweed",
    ["Stranglekelp"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Stranglekelp",
    ["Wild Steelbloom"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Wild Steelbloom",
    ["Grave Moss"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Grave Moss",
    ["Kingsblood"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Kingsblood",
    ["Liferoot"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Liferoot",
    ["Fadeleaf"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Fadeleaf",
    ["Goldthorn"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Goldthorn",
    ["Khadgar's Whisker"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Khadgar's Whisker",
    ["Wintersbite"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Wintersbite",
    ["Firebloom"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Firebloom",
    ["Purple Lotus"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Purple Lotus",
    ["Arthas' Tears"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Arthas' Tears",
    ["Sungrass"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Sungrass",
    ["Blindweed"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Blindweed",
    ["Ghost Mushroom"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Ghost Mushroom",
    ["Gromsblood"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Gromsblood",
    ["Golden Sansam"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Golden Sansam",
    ["Dreamfoil"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Dreamfoil",
    ["Mountain Silversage"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Mountain Silversage",
    ["Plaguebloom"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Plaguebloom",
    ["Icecap"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Icecap",
    ["Black Lotus"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Black Lotus",
}

-- Function to create a map pin
local function CreateMapPin(mapID, x, y, herbName)
    local pin = CreateFrame("Frame", nil, WorldMapFrame.ScrollContainer)
    pin:SetSize(11, 11)
    
    -- Create the herb icon
    local texture = pin:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints()

    -- Use specific herb icon or fallback to generic
    local iconPath = herbIcons[herbName] or "Interface\\Icons\\INV_Misc_Herb_07"
    texture:SetTexture(iconPath)
    
    -- Store info about this pin
    pin.mapID = mapID
    pin.x = x
    pin.y = y
    pin.herbName = herbName
    
    -- Add tooltip
    pin:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(herbName, 1, 1, 1)
        GameTooltip:AddLine(string.format("%.1f, %.1f", x, y), 0.8, 0.8, 0.8)
        GameTooltip:Show()
    end)
    
    pin:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    
    return pin
end

-- Function to update map pins
function UpdateMapPins()
    -- Clear existing pins
    for _, pin in pairs(mapPins) do
        pin:Hide()
    end
    
    -- Get current map
    local currentMapID = WorldMapFrame:GetMapID()
    if not currentMapID or not HerbalismTrackerDB[currentMapID] then
        return
    end
    
    -- Create pins for current map
    local pinIndex = 1
    for herbName, locations in pairs(HerbalismTrackerDB[currentMapID]) do
        for _, location in pairs(locations) do
            -- Reuse existing pin or create new one
            if not mapPins[pinIndex] then
                mapPins[pinIndex] = CreateMapPin(currentMapID, location.x, location.y, herbName)
            end
            
            local pin = mapPins[pinIndex]
            pin.mapID = currentMapID
            pin.x = location.x
            pin.y = location.y
            pin.herbName = herbName
            
            -- **FIX: Update the texture for the current herb**
            local iconPath = herbIcons[herbName] or "Interface\\Icons\\INV_Misc_Herb_07"
            pin:GetRegions():SetTexture(iconPath)  -- Get the first region (texture) and update it
            
            -- Position the pin
            local x = location.x / 100
            local y = location.y / 100
            pin:SetPoint("CENTER", WorldMapFrame.ScrollContainer, "TOPLEFT", 
                x * WorldMapFrame.ScrollContainer:GetWidth(), 
                -y * WorldMapFrame.ScrollContainer:GetHeight())
            
            pin:Show()
            pinIndex = pinIndex + 1
        end
    end
end


-- Register events we want to listen for
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("CHAT_MSG_LOOT")
-- frame:RegisterEvent("CHAT_MSG_SYSTEM")

-- Hook into world map updates
WorldMapFrame:HookScript("OnShow", UpdateMapPins)
if WorldMapFrame.ScrollContainer then
    WorldMapFrame.ScrollContainer:HookScript("OnSizeChanged", UpdateMapPins)
end

-- ... captures the event parameters
-- ADDON_LOADED -> addonName
-- CHAT_MSG_LOOT -> message
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "HerbalismTracker" then
            print("HerbalismTracker: Addon loaded successfully!")
        end

    elseif event == "PLAYER_LOGIN" then
        -- Show how many locations we have stored (after SavedVariables are loaded)
        local totalLocations = 0
        for mapID, mapData in pairs(HerbalismTrackerDB) do
            -- Only process if mapID is a number (actual map data)
            if type(mapID) == "number" then
                for herbName, locations in pairs(mapData) do
                    totalLocations = totalLocations + #locations
                end
            end
        end
        print(string.format("HerbalismTracker: Loaded %d saved herb locations", totalLocations))

--[[     elseif event == "PLAYER_LOGIN" then
        print("DEBUG: PLAYER_LOGIN fired")
        print("DEBUG: HerbalismTrackerDB type:", type(HerbalismTrackerDB))

        if HerbalismTrackerDB then
            print("DEBUG: HerbalismTrackerDB exists")
            local totalLocations = 0
            for mapID, mapData in pairs(HerbalismTrackerDB) do
                print("DEBUG: Processing key:", mapID, "type:", type(mapID))
                if type(mapID) == "number" then
                    print("DEBUG: Found numeric mapID:", mapID)
                    for herbName, locations in pairs(mapData) do
                        print("DEBUG: Herb:", herbName, "locations:", #locations)
                        totalLocations = totalLocations + #locations
                    end
                end
            end
            print(string.format("HerbalismTracker: Loaded %d saved herb locations", totalLocations))
        else
            print("DEBUG: HerbalismTrackerDB is nil!")
        end ]]

    elseif event == "CHAT_MSG_LOOT" then
        local message = ...

        -- Only process if it's YOUR loot (starts with "You receive loot:")
        if message:find("^You receive loot:") then
            local itemName = message:match("%[(.+)%]")

            if itemName and herbList[itemName] then
                local mapID, x, y = GetPlayerCoords()
                if mapID and x and y then
                    SaveHerbLocation(itemName, mapID, x, y)
                end
            end
        end

--[[     elseif event == "CHAT_MSG_SYSTEM" then
        local message = ...

        -- Check for skill too low messages
        if message:find("Requires Herbalism 285") then
            local mapID, x, y = GetPlayerCoords()
            if mapID and x and y then
                print(string.format("HIGH-LEVEL HERB at %.1f, %.1f (Map: %d) - %s",
                    x, y, mapID, message))
            end
        end ]]
    end
end)
```
