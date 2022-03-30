local ESX = nil
if config.Legacy then
    ESX = exports['es_extended']:getSharedObject()
else
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)
                ESX = obj
            end)
            Citizen.Wait(100)
        end
    end)
end

Citizen.CreateThread(function()
    AddTarget()
    Wait(1000)
    SendNUIMessage({
        action = 'insert',
        locale = locale,
        weapons = config.weapons,
        attachments = config.attachments,
        bullets = config.bullets,
        currency = config.currency,
    })
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    AddTarget()
end)

function AddTarget()
    for k,v in ipairs(config.weapon_shops) do
        exports.qtarget:AddBoxZone(v.name, v.coords, 0.5, 0.5, {
            name=v.name,
            heading=v.heading,
            debugPoly=false,
            minZ=v.coords.z - 0.2,
            maxZ=v.coords.z + 0.2,
            }, {
                options = {
                    {
                        event = "d-weaponshop:openmenu",
                        icon = "fa-solid fa-gun",
                        label = locale['access_menu'],
                    },
                },
                distance = 3.0
        })
    end
end

RegisterNetEvent('d-weaponshop:openmenu', function()
    local coords = GetEntityCoords(PlayerPedId())
    for k,v in ipairs(config.weapon_shops) do
        if #(coords - v.coords) < 3.0 then
            ESX.TriggerServerCallback('d-weaponshop:GetUserData', function(data)
                TriggerScreenblurFadeIn(500)
                SendNUIMessage({
                    action = 'menu',
                    show = true,
                    user_data = data,
                })
                SetNuiFocus(true, true)
            end)
        end
    end
end)

RegisterNUICallback('buy', function(data)
    SendNUIMessage({
        action = 'menu',
        show = false,
    })
    TriggerScreenblurFadeOut(500)
    SetNuiFocus(false, false)
    ESX.TriggerServerCallback('d-weaponshop:buyweapon', function(data)
    end, data)
end)

RegisterNUICallback('close', function(data)
    SendNUIMessage({
        action = 'menu',
        show = false,
    })
    TriggerScreenblurFadeOut(500)
    SetNuiFocus(false, false)
end)

RegisterNetEvent('d-weaponshop:notify', function(icon, text, duration)
    SendNUIMessage({
        action = 'notify',
        icon = icon,
        text = text,
        duration = duration,
    })
end)
