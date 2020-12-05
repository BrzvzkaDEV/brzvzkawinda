local stages = {
        [-1] = vector3(-1097.81,-849.9,4.88),
        [0] = vector3(-1097.81,-849.9,19.0),
        [1] = vector3(-1097.81,-849.9,23.04),
        [3] = vector3(-1097.72,-850.0,30.76),
        [4] = vector3(-1097.72,-850.0,34.36),
        [10] = vector3(-1097.72,-850.0,38.24)
    
    }
    ESX = nil
    local PlayerData = {}
    Citizen.CreateThread(function ()
        while ESX == nil do
          TriggerEvent('esx:getShMTaredObjMTect', function(obj) ESX = obj end)
          Citizen.Wait(0)
          PlayerData = ESX.GetPlayerData()
        end
      end)
    
      RegisterNetEvent('esx:playerLoaded')
      AddEventHandler('esx:playerLoaded', function(xPlayer)
          PlayerData = xPlayer
      end)
    
      RegisterNetEvent('esx:setJob')
      AddEventHandler('esx:setJob', function(job)
          PlayerData.job = job
          
      end)
    
    CreateThread(function()
        SetNuiFocus(false)
    end)
    
    CreateThread(function()
        while true do
            Wait(0)
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            for i,v in pairs(stages) do
                local dist = Vdist2(coords,v)
                if dist < 0.5 then -- and PlayerData.job.name == 'police' then
                    DrawText3D(v.x,v.y,v.z, "~b~E~w~ - Choose Floor")
                    if dist < 1 and IsControlJustPressed(1,51) then
                
                        EnableNui(i)
                    end                
                else
                if dist < 2.8 then
                    
                DrawText3D(v.x,v.y,v.z, "Elevator")
        
                end
                end
            end
        end
    end)
    
    function DrawText3D(x,y,z, text)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        local p = GetGameplayCamCoords()
        local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
        local scale = (1 / distance) * 2
        local fov = (1 / GetGameplayCamFov()) * 100
        local scale = scale * fov
        if onScreen then
            SetTextScale(0.35, 0.35)
            SetTextFont(4)
            SetTextProportional(1)
            
            SetTextColour(255, 255, 255, 215)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
            local factor = (string.len(text)) / 370
            DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 100)
          end
      end
    
    function loadAnimDict( dict )
        while ( not HasAnimDictLoaded( dict ) ) do
            RequestAnimDict( dict )
            Citizen.Wait( 5 )
        end
    end 
    
    
    RegisterNUICallback("choose", function(data,cb)
        SetNuiFocus(false,false)
        local stagetogo = data.stagetogo
        ChangeStage(stages[tonumber(stagetogo)]) 
        exports["mythic_notify"]:SendAlert('success',   'You have reached the floor '.. data.stagetogo ..' successfully')
    end)
    
    RegisterNUICallback("exit2", function(data,cb)
        SetNuiFocus(false,false)
    end)
    
    function EnableNui(st)
        SetNuiFocus(true,true)
        SendNUIMessage({
            type = "ui",
            stage = tostring(st)
        })
    end
    
    function DisableNui()
        SetNuiFocus(false)
            SendNUIMessage({
                type = "close"
            })
    end
    
    function ChangeStage(coords)
        local ped = PlayerPedId()
        Wait(700)
        DisableNui()
        Wait(1200)
        DoScreenFadeOut(100)
        Wait(750)
        ESX.Game.Teleport(ped, coords)
        DoScreenFadeIn(100)
    end
    
    
    
     --CreateThread(function()
         --while true do
            --Wait(0)
            --local ped = PlayerPedId()
            --local coords = GetEntityCoords(ped)
            --for i,v in pairs(stages) do
                --local dist = Vdist2(coords,v) 
               --if dist < 10 then
                    --DrawMarker(21,v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.8, 0.8, 0.5, 51, 153, 255, 100, false, true, 2, false, false, false, false)
                    --if dist < 3 and IsControlJustPressed(1,51) then
                        --EnableNui(i)
                    --end
    --             end
    --        end
     --   end
    -- end)