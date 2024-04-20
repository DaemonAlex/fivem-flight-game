local radioVolume = 100

RegisterCommand('radio', function()
    local playerPed = PlayerPedId()
    local currentVehicle = GetVehiclePedIsIn(playerPed, false)
    if IsPedInAnyVehicle(playerPed, false) then
        enableRadio(true)
    else
        showNotification("Radio is not available")
    end
end, false)

RegisterNUICallback('joinRadio', function(data)
    setPlayerRadioChannel(tonumber(data.channel), true)
	enableRadio(false)
	SetNuiFocus(false,false)
end)

RegisterNUICallback('leaveRadio', function(data)
    radioLeave(true)
end)

RegisterNUICallback('hidenui', function(data)
    enableRadio(false)
	SetNuiFocus(false, false)
end)

RegisterNUICallback('volumeup', function(data)
    PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	radioVolume = radioVolume + 5
	if radioVolume > 160 then radioVolume = 160 end
	exports["pma-voice"]:setRadioVolume(radioVolume/100)
	showNotification("Sound Level: "..radioVolume.."%")
end)

RegisterNUICallback('volumedown', function(data)
	PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	radioVolume = radioVolume - 10
	if radioVolume < 10 then radioVolume = 10 end
	exports["pma-voice"]:setRadioVolume(radioVolume/100)
	showNotification("Sound Level: "..radioVolume.."%")
end)

function setPlayerRadioChannel(channel)
	exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
	exports["pma-voice"]:setVoiceProperty("micClicks", true)
	exports["pma-voice"]:setRadioChannel(channel)
	exports["pma-voice"]:setRadioVolume(1.0)
    enableRadio(false)
end

function radioLeave()
    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("micClicks", false)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    showNotification("You left the radio frequency")
end

function enableRadio(enable)
    SetNuiFocus(true, true)
    SendNUIMessage({type = "enableui", enable = enable})
end

Citizen.CreateThread(function()
    RegisterKeyMapping('radio', 'Radio', 'keyboard', Config.RaidoKey)
end)
