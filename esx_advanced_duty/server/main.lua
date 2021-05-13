ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_advanced_duty:changeDutyStatus') 
AddEventHandler('esx_advanced_duty:changeDutyStatus', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name then

        local jobName = xPlayer.job.name 

        if string.match(jobName, "off") then 
            jobName = jobName:gsub("%off", "") xPlayer.setJob(jobName, xPlayer.job.grade)

            TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
            return
        else
            xPlayer.setJob('off' .. jobName, xPlayer.job.grade)

            TriggerClientEvent('esx:showNotification', _source, _U('offduty'))
        end
    else
        print("[Error] Player has no job to perform this action.")
    end
end)
