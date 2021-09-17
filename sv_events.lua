RegisterNetEvent("np-fx:smoke:grenade", function(pCoords)
    local players = GetNerbyPlayers(pCoords, 100)
    -- local ptDict, ptName = "scr_fbi3", "scr_fbi3_elec_spranks"
    -- local ptDict, ptName = "scr_michael2", "scr_mich2_sprank_impact"
    -- local ptDict, ptName = "core", "ent_brk_spranking_wires"
    -- local ptDict, ptName = "scr_xs_dr", "scr_xs_dr_amp"
    local ptDict, ptName = "core", "exp_grd_grenade_smoke"
    local position = {
        coords = { { x = pCoords.x, y = pCoords.y, z = pCoords.z } },
        rot = { x = 0.0, y = 0.0, z = 0.0 },
        scale = 1.0,
        alpha = 10.0,
    }
    TriggerParticleAtCoord(ptDict, ptName, true, position, 15000, players)
    position.coords[1].z = position.coords[1].z + 1.0
    Wait(1000)
    TriggerParticleAtCoord(ptDict, ptName, true, position, 15000, players)
end)

RegisterNetEvent("np-fx:chain:blingDiamonds", function(pCoords, pType, pSize, pStrengh, pScale)
    local serverId = source
    local players = GetNerbyPlayers(pCoords, 25)
    local ptDict, ptName = "", ""
    if pType == "diamonds" then
        ptDict, ptName = "scr_bike_adversary", "scr_adversary_weap_glow"
    end
    if pType == "ruby" then
        ptDict, ptName = "scr_bike_adversary", "scr_adversary_foot_flames"
    end
    if pType == "tanzanite" then
        ptDict, ptName = "scr_bike_adversary", "scr_adversary_gunsmith_weap_change"
    end
    local scale = (math.min[0.5, math.max[0.1, 0.025 * pSize]]) * (pScale or 1.0)
    local alpha = 1.0 + (pStrengh / 10)
    local position = {
        offset = {x = -0.04, y = 0.17, z = -0.1},
        rot = {x = -386.0, y = 19.0, z = -163.0},
        scale = scale,
        alpha = alpha
    }
    TriggerParticleOnPlayer(ptDict, ptName, true, serverId, 10706, position, 2000, players)
end)

-- RegisterCommand("bling", function()
--     local players = GetNerbyPlayers(vector3(731.14,8.91,83.53), 100)
--     local ptDict, ptName = "scr_bike_adversary", "scr_adversary_weap_glow"
--     local position = {
--         offset = {x = -0.04, y = 0.15, z = -0.6},
--         rot = {x = -386.0, y = 19.0, z = -163.0},
--         scale = 0.25,
--         alpha = 10.0,
--     }
-- end)

local function getpos(i)
    local x = -951.59 - (5.89 * i)
    local y = -3365.78 + (3.23 * i)
    local z = 55.99
    local p = {
        coords = { { x = x, y = y, z = z } },
        rot = { x = 0.0, y = 0.0, z = 0.0 },
        scale = 0.5,
        alpha = 10.0,
    }
    return p
end

local function doFx(fx, i, offset)
    Citizen.CreateThread(function()
        local ptDict, ptName = fx.dict, fx.fx
        local position = getpos(i - offset)
        TriggerEvent("np-scenes:addSceneToClient", {
            coords = vector3(position.coords[1].x, position.coords[1].y, position.coords[1].z),
            text = "<font size='50'>" .. "(" .. i .. ") - " .. fx.dict .. " - " .. fx.fx .. "</font>",
            distance = 100,
            color = "white",
            caret = false,
            font = 0,
            solid = false,
            background = {
              r = 255,
              g = 255,
              b = 255,
              alpha = 255,
            }
        })
        while true do 
            TriggerParticleAtCoord(ptDict, ptName, true, position, 5000, players)
            Citizen.Wait(5000)
        end
    end)
end

local numbersToKeep = {3, 5, 6, 9, 13, 20, 31, 32, 33, 34, 37, 43, 50, 51, 52, 55, 65, 69, 74, 76, 88, 95, 97, 101, 113, 114, 117, 119, 121, 122, 123, 126, 130, 137, 138, 147,
150, 151, 152, 153, 168, 169, 170, 171, 175, 177, 179, 180, 190, 194, 195, 196, 201, 209, 211, 214, 218, 228, 229, 230, 232, 234, 241, 250, 255, 257, 262, 265, 272, 272, 273, 
275, 278, 289, 296, 300, 302, 305, 310, 317, 318, 326, 337, 345, 352, 357, 359, 369, 370, 386, 389, 391, 396, 397,
400, 402, 404, 406, 415, 416, 419, 421, 425, 427, 430, 433, 437, 440, 443, 444, 449, 454, 456, 459, 461, 464, 465, 471, 477, 480, 483, 492, 500. 502, 503, 505, 506, 508, 510,
511, 514, 517, 518, 527, 533, 5316, 538, 541, 543, 547, 551, 552, 562, 569, 571, 572, 582, 594, 602, 606, 609, 616, 619, 626, 635, 637, 646, 652, 673, 679, 683, 688, 713, 725,
741, 750, 762, 772, 787, 791, 802, 833, 865, 915, 924, 1101, 1118, 1142, 1156, 1187, 1238, 1332, 1349, 1411, 1422, 1426, 1493, 1500, 1502, 1536, 1644, 1775, 1810, 1817, 1821, 
1826, 1911, 1946, 1968, 2001, 2003, 2005, 2007, 2024, 2030, 2094, 2124, 2202, 2203, 2236, 2209, 2311, 2317, }
Citizen.CreateThread(function()
    Citizen.Wait(2000)
    local players = GetNerbyPlayers(vector3(-951.59,-3365.78,13.99), 1000)
    local i = 0
    local offset = 200
    for _, fx in pairs(FX_LIST) do
        if i > offset and i < (offset + 100) then 
            print(fx.dict, fx.fx, players)
            doFx(fx, i, 50)
            Citizen.Wait(100)
        end
        i = i + 1
    end
end)
