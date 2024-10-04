local energyDetectorSide = "left"  -- Side where the energy detector is connected
local monitorSide = "right"  -- Side where the monitor is connected
local updateInterval = 2  -- Time in seconds for updates

-- Wrap peripherals using default sides
local energyDetector = peripheral.wrap(energyDetectorSide)
local monitor = peripheral.wrap(monitorSide)

-- Check if peripherals are properly wrapped
if not energyDetector then
    error("Failed to find energy detector on side: " .. energyDetectorSide)
end
if not monitor then
    error("Failed to find monitor on side: " .. monitorSide)
end

monitor.setTextScale(0.5)  -- Adjust the text scale for readability

-- Function to get transfer rate stats from the energy detector
local function getTransferRateStats()
    local transferRate = energyDetector.getTransferRate()
    local transferRateLimit = energyDetector.getTransferRateLimit()

    if transferRate and transferRateLimit then
        return {
            rate = transferRate,
            limit = transferRateLimit,
            percent = (transferRate / transferRateLimit) * 100
        }
    else
        error("Failed to read transfer rate stats from the energy detector!")
    end
end

-- Function to display transfer rate stats on the monitor
local function displayTransferRateStats()
    while true do
        local stats = getTransferRateStats()

        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Energy Transfer Monitor")
        monitor.setCursorPos(1, 2)
        monitor.write("----------------------------")
        monitor.setCursorPos(1, 3)
        monitor.write("Transfer Rate: " .. string.format("%.2f", stats.rate) .. " RF/t")
        monitor.setCursorPos(1, 4)
        monitor.write("Rate Limit: " .. string.format("%.2f", stats.limit) .. " RF/t")
        monitor.setCursorPos(1, 5)
        monitor.write("Usage Percentage: " .. string.format("%.2f", stats.percent) .. " %")
        monitor.setCursorPos(1, 6)
        monitor.write("----------------------------")

        sleep(updateInterval)
    end
end

-- Start displaying the transfer rate stats
displayTransferRateStats()
