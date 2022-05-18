local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX = nil
local aspetta = 1500
local text = false

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(aspetta)
    end
end)

Citizen.CreateThread(function ()
    while true do
        aspetta = 1000
        local player = PlayerPedId()
          for i = 1, #ERZ_COORDINATE do
             if #(GetEntityCoords(player) - ERZ_COORDINATE[i].coords) <= 1.5 then
                  aspetta = 10
                  if ERZ_COORDINATE[i].type == "prodotti" then
                    text = "~r~[E]~s~ Prodotti"             
                  elseif ERZ_COORDINATE[i].type == "trasfcarne" then
                      text = "~r~[E]~s~ Cuocere Carne"
                  elseif ERZ_COORDINATE[i].type == "trasfpane" then
                      text = "~r~[E]~s~ Prepare Pane"
                  elseif ERZ_COORDINATE[i].type == "trasflattu" then
                      text = "~r~[E]~s~ Lavare Lattuga"
                  elseif ERZ_COORDINATE[i].type == "cucinare" then
                      text = "~r~[E]~s~ Cucina Hamburger"
                  end
                  DrawText3D(ERZ_COORDINATE[i].coords.x, ERZ_COORDINATE[i].coords.y, ERZ_COORDINATE[i].coords.z, text or "Empty")
                  if IsControlJustReleased(0, 38) and #(GetEntityCoords(player) - ERZ_COORDINATE[i].coords) <= 1.5 then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "collecting",
                        duration = 5000,
                        label = 'Preparando...',
                        useWhileDead = false,
                        canCancel = false,
                         controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "mp_arresting",
                            anim = "a_uncuff",
                            flags = 49,
                        },
                        }, function(status)
                        if not status then
                            TriggerServerEvent('erz_burger:Product', ERZ_COORDINATE[i].Items, ERZ_COORDINATE[i].ReqItems)
                        else
                            ESX.ShowNotification('Transazione annullata')
                        end
                    end)
                end
             end
          end
          Citizen.Wait(aspetta)
      end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
	local coords = vector3(-1179.39, -880.961, 13.890)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 80)
	SetBlipScale(blip, 0.5)
	SetBlipColour(blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Negozio Hamburger')
	EndTextCommandSetBlipName(blip)
end)


Citizen.CreateThread(function()
    
    while true do
        aspetta = 1000
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.Vendere.x, Config.Vendere.y, Config.Vendere.z, false)
        if distance < 3 then
            aspetta = 5
            DrawText3D(Config.Vendere.x, Config.Vendere.y, Config.Vendere.z, '~g~E ~w~- Vendi Hamburger')
            DrawMarker(2, Config.Vendere.x, Config.Vendere.y, Config.Vendere.z -0.2, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 0, 90, 0, 255, 0, 0, 2, 1, 0, 0, 0)
            if IsControlJustPressed(0, 38) then
                SetNewWaypoint(Config.NPCTesto.x, Config.NPCTesto.y, Config.NPCTesto.z)
                --exports['mythic_notify']:SendAlert('inform', 'Punto di consegna segnato sulla Mappa', 5000)
                --ESX.ShowNotification('Ottimo')
            end
        end
        Citizen.Wait(aspetta)
    end
end)

Citizen.CreateThread(function()
    
    while true do
        aspetta = 1000
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, Config.NPCTesto.x, Config.NPCTesto.y, Config.NPCTesto.z, false)
        if distance < 5 then
            aspetta = 5
            DrawText3D(Config.NPCTesto.x, Config.NPCTesto.y, Config.NPCTesto.z, '~g~E ~w~- ERZ Development')
            if IsControlJustPressed(0, 38) then
                Chatting()
            end
        end
        Citizen.Wait(aspetta)
    end
end)

-- NPC KISMI
Citizen.CreateThread(function()
    if Config.NPCAttivo == true then
        RequestModel(Config.NPCModello)
        while not HasModelLoaded(Config.NPCModello) do
            Wait(1)
        end
    
        stanley = CreatePed(1, Config.NPCModello, Config.NPCVendere.x, Config.NPCVendere.y, Config.NPCVendere.z, Config.NPCVendere.h, false, true)
        SetBlockingOfNonTemporaryEvents(stanley, true)
        SetPedDiesWhenInjured(stanley, false)
        SetPedCanPlayAmbientAnims(stanley, true)
        SetPedCanRagdollFromPlayerImpact(stanley, false)
        SetEntityInvincible(stanley, true)
        FreezeEntityPosition(stanley, true)
    end
end)

function Chatting()
     text31("Pablo : Eccoti", 3)
     Citizen.Wait(1700)
     text31("Pablo : Quanti ne hai?", 3)
     Citizen.Wait(1700)
     ExecuteCommand("e box") 
     TriggerEvent("mythic_progbar:client:progress", {
        name = "selling",
        duration = 5000,
        label = 'Consegna Pacco',
        useWhileDead = false,
        canCancel = false,
         controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        }, function(status)
        if not status then
            OpenMenu()
        else
            ESX.ShowNotification('Transazione Annullata')
        end
    end)
     Citizen.Wait(2000)
     text31("Pablo : Il cibo sembra delizioso!", 3)
end

RegisterCommand("fixmenu",function()
    ESX.UI.Menu.CloseAll()
end)

text31 = function(text, duration)
    local sure = duration * 1000
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(sure, 1)
  end
  
function OpenMenu()
    local elements = {
        {label = 'Vendi Hamburger',   value = 'hamburger'},
        {label = 'Chiudi',       value = 'closemenu'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_actions', {
        title    = 'Vendita Hamburger',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'hamburger' then
            TriggerServerEvent("erz_burger:Sell")
        elseif data.current.value == 'closemenu' then
            menu.close()
        end
    end)
end
