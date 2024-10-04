local energyDetectorName = "energyDetector_0"  -- Replace with the correct energy detector name
local monitorName = "monitor_0"  -- Replace with the correct monitor name
local updateInterval = 2  -- Time in seconds for updates

-- Attempt to wrap peripherals
local energyDetector = peripheral.wrap(energyDetectorName)
local monitor = peripheral.wrap(monitorName)

-- Check if peripherals are properly wrapped
if not energyDetector then
    error("Failed to find energy detector! Check the peripheral name and connection.")
end
if not monitor then
    error("Failed to find monitor! Check the peripheral name and connection.")
end

monitor.setTextScale(0.5)  -- Adjust the text scale for readability

-- Function to get energy stats from the energy detector
local function getEnergyStats()
    local energyStored = energyDetector.getEnergy()
    local energyCapacity = energyDetector.getMaxEnergy()

    if energyStored and energyCapacity then
        return {
            stored = energyStored,
            capacity = energyCapacity,
            percent = (energyStored / energyCapacity) * 100
        }
    else
        error("Failed to read energy stats from the energy detector!")
    end
end

-- Function to display energy stats on the monitor
local function displayEnergyStats()
    while true do
        local stats = getEnergyStats()

        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Draconic Energy Core Monitor")
        monitor.setCursorPos(1, 2)
        monitor.write("----------------------------")
        monitor.setCursorPos(1, 3)
        monitor.write("Stored Power: " .. string.format("%.2f", stats.stored) .. " RF")
        monitor.setCursorPos(1, 4)
        monitor.write("Capacity: " .. string.format("%.2f", stats.capacity) .. " RF")
        monitor.setCursorPos(1, 5)
        monitor.write("Power Percentage: " .. string.format("%.2f", stats.percent) .. " %")
        monitor.setCursorPos(1, 6)
        monitor.write("----------------------------")

        sleep(updateInterval)
    end
end

-- Start displaying the energy stats
displayEnergyStats()
