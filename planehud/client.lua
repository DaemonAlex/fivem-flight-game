local isReverseThrusting = false
local airports = {
    { name = "~g~McKenzie Airfield", coords = vector3(2121.3, 4796.5, 40.9) },
    { name = "~b~Los Santos Airport", coords = vector3(-1034.6, -2734.4, 13.8) },
    { name = "~p~Sandy Shores Airfield", coords = vector3(1741.7, 3280.6, 41.0) }
}
local distance_to_closest_airport = 0.0

Citizen.CreateThread(function()
    for _, airport in ipairs(airports) do
        local blip = AddBlipForCoord(airport.coords.x, airport.coords.y, airport.coords.z)
        SetBlipSprite(blip, 307) --icon
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 5) --color
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(airport.name)
        EndTextCommandSetBlipName(blip)
    end

    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        local playerVehicle = GetVehiclePedIsIn(playerPed, false)

        if DoesEntityExist(playerVehicle) and IsThisModelAPlane(GetEntityModel(playerVehicle)) then
            local playerCoords = GetEntityCoords(playerVehicle)
            local altitude = playerCoords.z
            local speed = GetEntitySpeed(playerVehicle) * 2.23694

            local currentGear = GetVehicleCurrentGear(playerVehicle)
            isReverseThrusting = currentGear == 0

            local altitudeText = string.format("Altitude: %.2f meters", altitude)
            local speedText = string.format("Speed: %.2f knots", speed)
            local thrustText = isReverseThrusting and "~g~Reverse Thrust" or "~r~Reverse Thrust"
            local headingText = string.format("Heading: %.2f", GetEntityHeading(playerVehicle))

            local pitch = GetEntityPitch(playerVehicle)
            local pitchText = string.format("Pitch: %.2f degrees", pitch)

            DrawTextOnScreen(altitudeText, 0.015, 0.75, 0.4, 255, 255, 255)
            DrawTextOnScreen(speedText, 0.1, 0.75, 0.4, 255, 255, 255)
            DrawTextOnScreen(thrustText, 0.015, 0.72, 0.4, 255, isReverseThrusting and 0 or 255, 0)
            DrawTextOnScreen(headingText, 0.47, 0.06, 0.4, 255, 255, 255)
            DrawTextOnScreen(pitchText, 0.47, 0.09, 0.4, 255, 255, 255)

            DrawTextOnScreen(string.format("RADIO CHANNELS"), 0.85, 0.45, 0.4, 255, 255, 255)
            DrawTextOnScreen(string.format("LS international - 307"), 0.85, 0.47, 0.4, 255, 255, 255)
            DrawTextOnScreen(string.format("Sandy Shores AF - 168"), 0.85, 0.49, 0.4, 255, 255, 255)
            DrawTextOnScreen(string.format("McKenzie AF - 177"), 0.85, 0.51, 0.4, 255, 255, 255)

            local closestAirport, distance = GetClosestAirport(playerCoords)
            DrawTextOnScreen(string.format("Closest to you: %s (%.2f miles)", closestAirport, distance), 0.85, 0.54, 0.4, 255, 255, 255)
        end
    end
end)

function GetClosestAirport(playerCoords)
    local closestAirport = airports[1].name
    local minDistance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, airports[1].coords.x, airports[1].coords.y, airports[1].coords.z)

    for _, airport in ipairs(airports) do
        local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, airport.coords.x, airport.coords.y, airport.coords.z)
        if distance < minDistance then
            minDistance = distance
            closestAirport = airport.name
        end
    end

    local distanceInMiles = minDistance * 0.000621371
    return closestAirport, distanceInMiles
end


function DrawTextOnScreen(text, x, y, scale, r, g, b)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, 255)
    
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
