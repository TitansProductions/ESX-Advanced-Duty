
-- Action Functions
local CurrentAction, LastZone = nil, nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local HasAlreadyEnteredMarker = false


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Markers
AddEventHandler('esx_advanced_duty:hasEnteredMarker', function (zone)
  CurrentActionData, CurrentActionMsg = {}, ''
	CurrentAction     = nil
end)

AddEventHandler('esx_advanced_duty:hasExitedMarker', function (zone)
  CurrentActionData, CurrentActionMsg = {}, ''
  CurrentAction     = nil
end)


-- Enter / Exit marker job events
CreateThread(function ()
  while true do
    Wait(0)
			
    while ESX.PlayerData.job == nil do
	    Wait(100)
    end

    local coords = GetEntityCoords(PlayerPedId())
    local isInMarker = false
    local currentZone = nil
    local sleep = true

    for k,v in pairs(Config.Zones) do
      local distance = #(coords - v.Pos)
      if distance <= Config.DrawDistance then
        local jobName = ESX.PlayerData.job.name

        if string.match(jobName, "off") then jobName = jobName:gsub("%off", "") end

        if v.JobRequired == jobName then
          sleep = false
          isInMarker  = true
          currentZone = k

          CurrentAction     = 'esx_advanced_duty_changejob'
          CurrentActionMsg  = _U('duty')
          CurrentActionData = {}
        end
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone                = currentZone
      TriggerEvent('esx_advanced_duty:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('esx_advanced_duty:hasExitedMarker', LastZone)
    end

    if sleep then
      Wait(1000)
    end
  end
end)




--keycontrols
CreateThread(function ()
  while true do
    Wait(5)
    
    if CurrentAction ~= nil then
      ESX.ShowHelpNotification(CurrentActionMsg, true)

      if IsControlJustReleased(0, 38) then
        TriggerServerEvent('esx_advanced_duty:changeDutyStatus')
      end

      CurrentActionData, CurrentActionMsg = {}, ''
      CurrentAction     = nil
    end
  end

end)

-- Display markers
CreateThread(function ()
  while true do
    Wait(0)

    local coords = GetEntityCoords(PlayerPedId())
    local sleep = true

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then

        local jobName = ESX.PlayerData.job.name
        if string.match(jobName, "off") then jobName = jobName:gsub("%off", "") end

        if v.JobRequired == jobName then
          sleep = false
          DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end

    if sleep then
      Wait(1000)
    end
  end
end)
