RegisterServerEvent('esx_advanced_duty:changeDutyStatus') 
AddEventHandler('esx_advanced_duty:changeDutyStatus', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name then
        local jobName = xPlayer.job.name 

        if string.match(jobName, "off") then 
            jobName = jobName:gsub("%off", "") xPlayer.setJob(jobName, xPlayer.job.grade)

            TriggerClientEvent('esx:showNotification', source, _U('onduty'))
            return
        else
            xPlayer.setJob('off' .. jobName, xPlayer.job.grade)

            TriggerClientEvent('esx:showNotification', source, _U('offduty'))
        end
    else
        print("[Error] Player has no job to perform this action.")
    end
end)
