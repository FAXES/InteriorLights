--------------------------------------
--- Interior Lights, Made by FAXES ---
--------------------------------------

--- Config ---

activateWay = 0 -- 0 = use command, 1 = use keybind, 2 = use both command and keybind
keybindKey = 182 -- http://docs.fivem.net/game-references/controls/
intCommand = "il" -- If using the command, what do you want the command to be?



--- Code Shit ---

function toggleInteriorLights(ped, veh)
    if IsPedInVehicle(ped, veh, false) then
        if IsVehicleInteriorLightOn(veh) then
            SetVehicleInteriorlight(veh, false)
        else
            SetVehicleInteriorlight(veh, true)
        end
    else
        TriggerEvent("chat:addMessage", "^1^*You are not in a vehicle.")
    end
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(PlayerId())
        local veh = GetVehiclePedIsUsing(ped)
        if activateWay == 1 or activateWay == 2 then
            if IsControlJustPressed(1, keybindKey) then
                toggleInteriorLights(ped, veh)
            end
        end
	end
end)

RegisterCommand(intCommand, function(source, args, raw)
    local ped = GetPlayerPed(PlayerId())
    local veh = GetVehiclePedIsUsing(ped)
    if activateWay == 0 or activateWay == 2 then
        toggleInteriorLights(ped, veh)
    end
end)