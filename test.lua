local energyDetectorSide = "left"  -- Replace with the side your energy detector is on

local energyDetector = peripheral.wrap(energyDetectorSide)

if energyDetector then
    print("Energy Detector Methods:")
    for methodName, _ in pairs(energyDetector) do
        print(methodName)
    end
else
    print("Failed to find energy detector on side: " .. energyDetectorSide)
end
