local energyCubeName = "peripheral_name_of_energy_cube"
local monitorName = "monitor_0"  -- Update with your monitor name
local updateInterval = 2

local monitor = peripheral.wrap(monitorName)
monitor.setTextScale(0.5)  -- Adjust scale for readability

local function getEnergyStats()
    local cube = peripheral.wrap(energyCubeName)
    if not cube then
        error("Energy Cube not connected or wrong name!")
    end

    local energyStored = cube.getEnergy()
    local energyCapacity = cube.getMaxEnergy()

    return {
        stored = energyStored,
        capacity = energyCapacity,
        percent = (energyStored / energyCapacity) * 100
    }
end

local function monitorPowerFlow()
    local lastEnergy = getEnergyStats().stored
    local lastUpdate = os.clock()

    while true do
        local currentEnergy = getEnergyStats().stored
        local currentTime = os.clock()
        local timeDiff = currentTime - lastUpdate
        local energyDiff = currentEnergy - lastEnergy
        local flowRate = energyDiff / timeDiff

        lastEnergy = currentEnergy
        lastUpdate = currentTime

        -- Display on the monitor
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Power Monitoring - Basic Energy Cube")
        monitor.setCursorPos(1, 2)
        monitor.write("-------------------------------")
        monitor.setCursorPos(1, 3)
        monitor.write("Stored Power: " .. string.format("%.2f", getEnergyStats().stored) .. " RF")
        monitor.setCursorPos(1, 4)
        monitor.write("Capacity: " .. string.format("%.2f", getEnergyStats().capacity) .. " RF")
        monitor.setCursorPos(1, 5)
        monitor.write("Power Percentage: " .. string.format("%.2f", getEnergyStats().percent) .. " %")
        monitor.setCursorPos(1, 6)
        monitor.write("-------------------------------")
        if flowRate > 0 then
            monitor.setCursorPos(1, 7)
            monitor.write("Incoming Power: " .. string.format("%.2f", flowRate) .. " RF/t")
        elseif flowRate < 0 then
            monitor.setCursorPos(1, 7)
            monitor.write("Outgoing Power: " .. string.format("%.2f", -flowRate) .. " RF/t")
        else
            monitor.setCursorPos(1, 7)
            monitor.write("Power Flow: Stable (no change)")
        end

        sleep(updateInterval)
    end
end

-- Start the program
monitorPowerFlow()
