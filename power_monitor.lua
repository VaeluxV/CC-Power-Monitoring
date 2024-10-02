local networkName = "integrateddynamics_network"  -- Replace with your network's peripheral name
local monitorName = "monitor_0"  -- Replace with your monitor name
local updateInterval = 2  -- Time in seconds for updates

local network = peripheral.wrap(networkName)
local monitor = peripheral.wrap(monitorName)
monitor.setTextScale(0.5)  -- Adjust the text scale for readability

-- Function to get energy stats from Integrated Dynamics
local function getEnergyStats()
    local energyStored = network.getEnergy()  -- Assuming Integrated Dynamics reads energy
    local energyCapacity = network.getMaxEnergy()

    if energyStored and energyCapacity then
        return {
            stored = energyStored,
            capacity = energyCapacity,
            percent = (energyStored / energyCapacity) * 100
        }
    else
        error("Failed to read energy stats from Integrated Dynamics!")
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
