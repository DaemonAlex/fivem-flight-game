RegisterCommand("r", function(source, args)
    if args[1] then 
        TriggerClientEvent('flight-radio:t', source, args[1]) 
    end
end)

RegisterCommand("rl", function(source)
    TriggerClientEvent('flight-radio:tk', source)
end)
