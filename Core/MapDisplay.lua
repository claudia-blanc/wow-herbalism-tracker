-- Map display module for HerbalismTracker
local addonName = "HerbalismTracker"

-- Load addon namespace
local HT = _G[addonName]

-- Map display module
HT.MapDisplay = {}

-- Initialize map display
function HT.MapDisplay.Initialize()
    -- Hook into world map updates
    WorldMapFrame:HookScript("OnShow", HT.MapDisplay.UpdateMapPins)
    if WorldMapFrame.ScrollContainer then
        WorldMapFrame.ScrollContainer:HookScript("OnSizeChanged", HT.MapDisplay.UpdateMapPins)
    end
end

print("MapDisplay.lua loaded successfully!")

-- Table to store map pins
local mapPins = {}

-- Function to create a map pin
local function CreateMapPin(mapID, x, y, itemName)
    local pin = CreateFrame("Frame", nil, WorldMapFrame.ScrollContainer)
    pin:SetSize(11, 11)

    local texture = pin:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints()

    local iconPath = HT.Classic.GetHerbIconPath(itemName) or "Interface\\Icons\\INV_Misc_Herb_07"
    texture:SetTexture(iconPath)
    local herbLevels = HT.Classic.GetHerbLevels(itemName)

    pin.mapID = mapID
    pin.x = x
    pin.y = y
    pin.itemName = itemName

    pin:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(itemName, 1, 1, 1)
        GameTooltip:AddLine(string.format("(%d-%d-%d-%d)", herbLevels[1], herbLevels[2], herbLevels[3], herbLevels[4]), 0.85, 0.85, 0.85)
        GameTooltip:AddLine(string.format("%.1f, %.1f", x, y), 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)

    pin:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    return pin
end

-- Function to update map pins
function HT.MapDisplay.UpdateMapPins()
    -- Clear existing pins
    for _, pin in pairs(mapPins) do
        pin:Hide()
    end

    -- Get current map
    local currentMapID = WorldMapFrame:GetMapID()
    local mapData = HT.Storage.GetMapLocations(currentMapID) -- List of key-value pairs (herbName -> {x, y, time})

    if not mapData then
        return
    end

    -- Create pins for current map
    local pinIndex = 1
    for itemName, locations in pairs(mapData) do
        for _, location in pairs(locations) do
            -- Reuse existing pin or create new one
            if not mapPins[pinIndex] then
                mapPins[pinIndex] = CreateMapPin(currentMapID, location.x, location.y, itemName)
            end

            local pin = mapPins[pinIndex]
            pin.mapID = currentMapID
            pin.x = location.x
            pin.y = location.y
            pin.itemName = itemName

            -- **FIX: Update the texture for the current herb**
            local iconPath = HT.Classic.GetHerbIconPath(itemName) or "Interface\\Icons\\INV_Misc_Herb_07"
            select(1, pin:GetRegions()):SetTexture(iconPath) -- Get the first region (texture) and update it

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
