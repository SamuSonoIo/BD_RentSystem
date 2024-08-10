RegisterNetEvent('bd:hasoldi')
AddEventHandler('bd:hasoldi', function(veicolo, costoveicolo)
    local xPlayer = ESX.GetPlayerFromId(source)
    local soldi = xPlayer.getMoney()  -- Usa xPlayer.getMoney() per ottenere il saldo

    if soldi < costoveicolo then
        TriggerClientEvent('esx:showNotification', source, 'Non hai abbastanza soldi!')
    else
        xPlayer.removeMoney(costoveicolo)

        TriggerClientEvent('esx:showNotification', source, 'Veicolo noleggiato con successo!')

        TriggerClientEvent('bd:spawnveicolo', source, veicolo)
    end
end)
