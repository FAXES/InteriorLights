--------------------------------------
--- Interior Lights, Made by FAXES ---
--------------------------------------

-- Config --

local activateWay = 2 -- 0 = use command, 1 = use keybind, 2 = use both command and keybind
local keybindKey = 182 -- http://docs.fivem.net/game-references/controls/
local intCommand = "il" -- If using the command, what do you want the command to be?
local errorNotify = true -- enable/disable error notifications (not in a vehicle & attempting to change interior lighting)
local errorTitle = true -- enable/disable title ontop of error notification (title is: Interior Lights)

-- Light Toggling Function --

function toggleInteriorLights()
	local ped = GetPlayerPed(PlayerId()) -- get local player's ID
	local veh = GetVehiclePedIsUsing(ped) -- get vehicle ID that local player is in
    if veh ~= 0 then -- if GetVehiclePedIsUsing returned a 0, then they aren't in a vehicle
        if IsVehicleInteriorLightOn(veh) then -- if light is on
            SetVehicleInteriorlight(veh, false) -- turn interior light off
        else
            SetVehicleInteriorlight(veh, true) -- turn interior light on
        end
    elseif errorNotify then -- don't show error if errors are disabled
        ShowNotification('You are not in a vehicle.')
    end
end

-- Error Notification --

if errorNotify then -- check config... don't create this function, if it won't be used
	function ShowNotification(text)
		if errorTitle then -- if error titles are enabled
			text = ('~y~~h~Interior Lights~h~~s~~n~' .. text) -- add title to error notification
		end
		SetNotificationTextEntry('STRING') -- set notification type
		AddTextComponentString(text) -- add string to the notification we are going to display
		local notification = DrawNotification(false, false) -- display the error & save as "notification" so we can remove it
		Citizen.Wait(1000) -- how long to wait before removing the error notification
		RemoveNotification(notification) -- remove error notification
	end
end

-- Keypress Listening --

if activateWay == 1 or activateWay == 2 then -- check config... don't create this infinite loop, if it won't be used
	Citizen.CreateThread(function() -- creates a seperate thread
		while true do -- infinite loop
			Citizen.Wait(2) -- adjusted polling rate to further minimize resource usage
			if IsControlJustPressed(1, keybindKey) then -- if control is pressed
				toggleInteriorLights() -- run the Light Toggling Function
			end
		end
	end)
end

-- Command Registering --

if activateWay == 0 or activateWay == 2 then -- check config... don't register this command, if it won't be used
	RegisterCommand(intCommand, function(source, args, raw) -- register command
			toggleInteriorLights() -- run the Light Toggling Function
	end)
end