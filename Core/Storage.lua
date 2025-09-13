-- Storage module for HerbalismTracker
local addonName = "HerbalismTracker"

-- Create addon namespace
if not _G[addonName] then
    _G[addonName] = {}
end
local HT = _G[addonName]

-- Storage module
HT.Storage = {}

-- Initialize database
-- Saved, when the user logs out, in
-- /Applications/World of Warcraft/_classic_era_/WTF/Account/<USERNAME>/SavedVariables/HerbalismTracker.lua
function HT.Storage.Initialize()
    HerbalismTrackerDB = HerbalismTrackerDB or {
        ["char"] = {},
        ["global"] = {
            ["nodes"] = {
                ["herbalism"] = {},
                ["soil"] = {}
            },
            ["maps"] = {}
        }
    }
end

print("Storage.lua loaded successfully!")

-- Function to calculate distance between two points
local function GetDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

-- Function to check if location is too close to existing ones
local function IsLocationTooClose(herbName, mapID, x, y, minDistance)
    local herbData = HerbalismTrackerDB["global"]["nodes"]["herbalism"][mapID]
    if not herbData or not herbData[herbName] then
        return false
    end

    for _, location in pairs(herbData[herbName]) do
        local distance = GetDistance(x, y, location.x, location.y)
        if distance < minDistance then
            return true
        end
    end

    return false
end

-- Save herb location
function HT.Storage.SaveHerbLocation(herbName, mapID, x, y)
    local minDistance = 1.0 -- Minimum distance in percentage (0-100) to consider a location as new

    if IsLocationTooClose(herbName, mapID, x, y, minDistance) then
        print(string.format("Skipped %s at %.1f, %.1f (too close to existing location)",
            herbName, x, y))
        return false
    end

    -- Create structure if it doesn't exist
    local herbData = HerbalismTrackerDB["global"]["nodes"]["herbalism"]
    if not herbData[mapID] then
        herbData[mapID] = {}
    end

    if not herbData[mapID][herbName] then
        herbData[mapID][herbName] = {}
    end

    -- Save the location
    table.insert(herbData[mapID][herbName], { x = x, y = y, time = time() })

    -- Save map info if we have it
    -- Check https://wowwiki-archive.fandom.com/wiki/InstanceMapID
    local mapName = C_Map.GetMapInfo(mapID).name
    local instance = { GetInstanceInfo() }
    if mapName and instance[1] and instance[8] then
        HerbalismTrackerDB["global"]["maps"][mapID] = {
            ["name"] = mapName,
            ["insName"] = instance[1],
            ["insID"] = instance[8]
        }
    else
        print(format("DEBUG: Missing map info for mapID %d", mapID))
    end

    print(string.format("Saved %s at %.1f, %.1f (Total: %d locations)",
        herbName, x, y, #herbData[mapID][herbName]))

    return true
end

function HT.Storage.SaveSoilLocation(soilName, mapID, x, y)
    local minDistance = 1.0 -- Minimum distance in percentage (0-100) to consider a location as new

    if IsLocationTooClose(soilName, mapID, x, y, minDistance) then
        print(string.format("Skipped %s at %.1f, %.1f (too close to existing location)",
            soilName, x, y))
        return false
    end

    -- Create structure if it doesn't exist
    local soilData = HerbalismTrackerDB["global"]["nodes"]["soil"]
    if not soilData[mapID] then
        soilData[mapID] = {}
    end

    if not soilData[mapID][soilName] then
        soilData[mapID][soilName] = {}
    end

    -- Save the location
    table.insert(soilData[mapID][soilName], { x = x, y = y, time = time() })

    -- Save map info if we have it
    -- Check https://wowwiki-archive.fandom.com/wiki/InstanceMapID
    local mapName = C_Map.GetMapInfo(mapID).name
    local instance = { GetInstanceInfo() }
    if mapName and instance[1] and instance[8] then
        HerbalismTrackerDB["global"]["maps"][mapID] = {
            ["name"] = mapName,
            ["insName"] = instance[1],
            ["insID"] = instance[8]
        }
    else
        print(format("DEBUG: Missing map info for mapID %d", mapID))
    end

    print(string.format("Saved %s at %.1f, %.1f (Total: %d locations)",
        soilName, x, y, #soilData[mapID][soilName]))

    return true
end

-- Get total location count
function HT.Storage.GetTotalLocationCount()
    local totalLocations = 0
    local herbData = HerbalismTrackerDB["global"]["nodes"]["herbalism"]
    -- herbData is a list of key-value pairs (mapID -> {herbName -> {x, y, time}})
    for mapID, mapData in pairs(herbData) do
        for herbName, locations in pairs(mapData) do
            totalLocations = totalLocations + #locations
        end
    end
    return totalLocations
end

-- Get locations for specific map
function HT.Storage.GetMapLocations(mapID)
    if HerbalismTrackerDB["global"]["nodes"]["herbalism"][mapID] then
        -- Returns list of key-value pairs (herbName -> {x, y, time})
        return HerbalismTrackerDB["global"]["nodes"]["herbalism"][mapID]
    end
    return nil
end
