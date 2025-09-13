-- Classic database module for HerbalismTracker
local addonName = "HerbalismTracker"

-- Load addon namespace
local HT = _G[addonName]

-- Classic database module
HT.Classic = {}

function HT.Classic.Initialize()
    -- This function can be used for future initialization if needed
end

print("Classic.lua loaded successfully!")

local herbsClassic = {
    ["Peacebloom"] = {
        ["Levels"] = { 1, 25, 50, 100 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Peacebloom"
    },
    ["Silverleaf"] = {
        ["Levels"] = { 1, 25, 50, 100 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Silverleaf"
    },
    ["Earthroot"] = {
        ["Levels"] = { 15, 40, 65, 115 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Earthroot"
    },
    ["Mageroyal"] = {
        ["Levels"] = { 50, 75, 100, 150 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Mageroyal"
    },
    ["Briarthorn"] = {
        ["Levels"] = { 70, 95, 120, 170 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Briarthorn"
    },
    ["Swiftthistle"] = {
        ["Levels"] = { 50, 75, 100, 150 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Swiftthistle"
    },
    ["Stranglekelp"] = {
        ["Levels"] = { 85, 110, 135, 185 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Stranglekelp"
    },
    ["Bruiseweed"] = {
        ["Levels"] = { 100, 125, 150, 200 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Bruiseweed"
    },
    ["Wild Steelbloom"] = {
        ["Levels"] = { 115, 140, 165, 215 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Wild Steelbloom"
    },
    ["Grave Moss"] = {
        ["Levels"] = { 120, 145, 170, 220 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Grave Moss"
    },
    ["Kingsblood"] = {
        ["Levels"] = { 125, 150, 175, 225 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Kingsblood"
    },
    ["Liferoot"] = {
        ["Levels"] = { 150, 175, 200, 250 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Liferoot"
    },
    ["Fadeleaf"] = {
        ["Levels"] = { 160, 185, 210, 260 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Fadeleaf"
    },
    ["Goldthorn"] = {
        ["Levels"] = { 170, 195, 220, 270 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Goldthorn"
    },
    ["Khadgar's Whisker"] = {
        ["Levels"] = { 185, 210, 235, 285 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Khadgar's Whisker"
    },
    ["Wintersbite"] = {
        ["Levels"] = { 195, 220, 245, 295 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Wintersbite"
    },
    ["Firebloom"] = {
        ["Levels"] = { 205, 230, 255, 305 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Firebloom"
    },
    ["Purple Lotus"] = {
        ["Levels"] = { 210, 235, 260, 310 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Purple Lotus"
    },
    ["Arthas' Tears"] = {
        ["Levels"] = { 220, 245, 270, 320 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Arthas' Tears"
    },
    ["Sungrass"] = {
        ["Levels"] = { 230, 255, 280, 330 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Sungrass"
    },
    ["Blindweed"] = {
        ["Levels"] = { 235, 260, 285, 335 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Blindweed"
    },
    ["Ghost Mushroom"] = {
        ["Levels"] = { 245, 270, 295, 345 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Ghost Mushroom"
    },
    ["Gromsblood"] = {
        ["Levels"] = { 250, 275, 300, 350 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Gromsblood"
    },
    ["Golden Sansam"] = {
        ["Levels"] = { 260, 285, 310, 360 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Golden Sansam"
    },
    ["Dreamfoil"] = {
        ["Levels"] = { 270, 290, 315, 370 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Dreamfoil"
    },
    ["Mountain Silversage"] = {
        ["Levels"] = { 280, 305, 330, 380 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Mountain Silversage"
    },
    ["Plaguebloom"] = {
        ["Levels"] = { 285, 310, 335, 385 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Plaguebloom"
    },
    ["Icecap"] = {
        ["Levels"] = { 290, 315, 340, 390 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Icecap"
    },
    ["Black Lotus"] = {
        ["Levels"] = { 300, 325, 350, 400 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\Black Lotus"
    },
}

local soilClassic = {
    ["Un'Goro Soil"] = {
        ["Levels"] = { 48, 55 },
        ["Icon"] = "Interface\\AddOns\\HerbalismTracker\\Icons\\soil.tga"
    },
}

local levelColors = {
    "|cffff8000", -- orange
    "|cffffff00", -- yellow
    "|cff00ff00", -- green
    "|cff808080", -- gray
}

function HT.Classic.GetHerbIconPath(herbName)
    return herbsClassic[herbName]["Icon"]
end

function HT.Classic.GetSoilIconPath(soilName)
    return soilClassic[soilName]["Icon"]
end

function HT.Classic.GetHerbLevels(herbName)
    return herbsClassic[herbName]["Levels"]
end

function HT.Classic.GetSoilLevels(soilName)
    return soilClassic[soilName]["Levels"]
end

function HT.Classic.GetLevelColors(i)
    return levelColors[i]
end

function HT.Classic.IsHerb(itemName)
    return herbsClassic[itemName] ~= nil
end

function HT.Classic.IsSoil(itemName)
    return soilClassic[itemName] ~= nil
end

-- Map data for Classic WoW
local mapsClassic = {
    ["maps"] = {
        [947] = {
            ["id"] = 947,
            ["name"] = "Azeroth",
            ["instance"] = -1,
        },
        [1414] = {
            ["id"] = 1414,
            ["name"] = "Kalimdor",
            ["instance"] = -1,
        },
        [1416] = {
            ["id"] = 1416,
            ["name"] = "Alterac Mountains",
            ["instance"] = 0,
        },
        [1417] = {
            ["id"] = 1417,
            ["name"] = "Arathi Highlands",
            ["instance"] = 0,
        },
        [1418] = {
            ["id"] = 1418,
            ["name"] = "Badlands",
            ["instance"] = 0,
        },
        [1419] = {
            ["id"] = 1419,
            ["name"] = "Blasted Lands",
            ["instance"] = 0,
        },
        [1428] = {
            ["id"] = 1428,
            ["name"] = "Burning Steppes",
            ["instance"] = 0,
        },
        [1430] = {
            ["id"] = 1430,
            ["name"] = "Deadwind Pass",
            ["instance"] = 0,
        },
        [1426] = {
            ["id"] = 1426,
            ["name"] = "Dun Morogh",
            ["instance"] = 0,
        },
        [1431] = {
            ["id"] = 1431,
            ["name"] = "Duskwood",
            ["instance"] = 0,
        },
        [1423] = {
            ["id"] = 1423,
            ["name"] = "Eastern Plaguelands",
            ["instance"] = 0,
        },
        [1429] = {
            ["id"] = 1429,
            ["name"] = "Elwynn Forest",
            ["instance"] = 0,
        },
        [1424] = {
            ["id"] = 1424,
            ["name"] = "Hillsbrad Foothills",
            ["instance"] = 0,
        },
        [1455] = {
            ["id"] = 1455,
            ["name"] = "Ironforge",
            ["instance"] = 0,
        },
        [1432] = {
            ["id"] = 1432,
            ["name"] = "Loch Modan",
            ["instance"] = 0,
        },
        [1433] = {
            ["id"] = 1433,
            ["name"] = "Redridge Mountains",
            ["instance"] = 0,
        },
        [1427] = {
            ["id"] = 1427,
            ["name"] = "Searing Gorge",
            ["instance"] = 0,
        },
        [1421] = {
            ["id"] = 1421,
            ["name"] = "Silverpine Forest",
            ["instance"] = 0,
        },
        [1453] = {
            ["id"] = 1453,
            ["name"] = "Stormwind City",
            ["instance"] = 0,
        },
        [1434] = {
            ["id"] = 1434,
            ["name"] = "Stranglethorn Vale",
            ["instance"] = 0,
        },
        [1435] = {
            ["id"] = 1435,
            ["name"] = "Swamp of Sorrows",
            ["instance"] = 0,
        },
        [1425] = {
            ["id"] = 1425,
            ["name"] = "The Hinterlands",
            ["instance"] = 0,
        },
        [1420] = {
            ["id"] = 1420,
            ["name"] = "Tirisfal Glades",
            ["instance"] = 0,
        },
        [1458] = {
            ["id"] = 1458,
            ["name"] = "Undercity",
            ["instance"] = 0,
        },
        [1422] = {
            ["id"] = 1422,
            ["name"] = "Western Plaguelands",
            ["instance"] = 0,
        },
        [1436] = {
            ["id"] = 1436,
            ["name"] = "Westfall",
            ["instance"] = 0,
        },
        [1437] = {
            ["id"] = 1437,
            ["name"] = "Wetlands",
            ["instance"] = 0,
        },
        [1440] = {
            ["id"] = 1440,
            ["name"] = "Ashenvale",
            ["instance"] = 1,
        },
        [1447] = {
            ["id"] = 1447,
            ["name"] = "Azshara",
            ["instance"] = 1,
        },
        [1439] = {
            ["id"] = 1439,
            ["name"] = "Darkshore",
            ["instance"] = 1,
        },
        [1457] = {
            ["id"] = 1457,
            ["name"] = "Darnassus",
            ["instance"] = 1,
        },
        [1443] = {
            ["id"] = 1443,
            ["name"] = "Desolace",
            ["instance"] = 1,
        },
        [1411] = {
            ["id"] = 1411,
            ["name"] = "Durotar",
            ["instance"] = 1,
        },
        [1445] = {
            ["id"] = 1445,
            ["name"] = "Dustwallow Marsh",
            ["instance"] = 1,
        },
        [1448] = {
            ["id"] = 1448,
            ["name"] = "Felwood",
            ["instance"] = 1,
        },
        [1444] = {
            ["id"] = 1444,
            ["name"] = "Feralas",
            ["instance"] = 1,
        },
        [1412] = {
            ["id"] = 1412,
            ["name"] = "Mulgore",
            ["instance"] = 1,
        },
        [1451] = {
            ["id"] = 1451,
            ["name"] = "Silithus",
            ["instance"] = 1,
        },
        [1442] = {
            ["id"] = 1442,
            ["name"] = "Stonetalon Mountains",
            ["instance"] = 1,
        },
        [1446] = {
            ["id"] = 1446,
            ["name"] = "Tanaris",
            ["instance"] = 1,
        },
        [1438] = {
            ["id"] = 1438,
            ["name"] = "Teldrassil",
            ["instance"] = 1,
        },
        [1413] = {
            ["id"] = 1413,
            ["name"] = "The Barrens",
            ["instance"] = 1,
        },
        [1441] = {
            ["id"] = 1441,
            ["name"] = "Thousand Needles",
            ["instance"] = 1,
        },
        [1449] = {
            ["id"] = 1449,
            ["name"] = "Un'Goro Crater",
            ["instance"] = 1,
        },
        [1452] = {
            ["id"] = 1452,
            ["name"] = "Winterspring",
            ["instance"] = 1,
        },
    }
}
