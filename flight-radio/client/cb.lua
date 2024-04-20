local CurrentRequestId = 0
local ServerCallbacks = {}

RegisterNetEvent('flight-radio:Client:TriggerCallback')
AddEventHandler('flight-radio:Client:TriggerCallback', function(requestId, ...)
	if ServerCallbacks[requestId] then
		ServerCallbacks[requestId](...)
		ServerCallbacks[requestId] = nil
	end
end)

function TriggerCallback(name, cb, ...)
	ServerCallbacks[CurrentRequestId] = cb
	TriggerServerEvent("flight-radio:Server:TriggerCallback", name, CurrentRequestId, ...)
	if CurrentRequestId < 65535 then CurrentRequestId = CurrentRequestId + 1 else CurrentRequestId = 0 end
end

RegisterNetEvent("flight-radio:client:notif")
AddEventHandler("flight-radio:client:notif", function(text)
	showNotification(text)
end)