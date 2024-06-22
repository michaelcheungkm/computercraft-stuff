local sandDrawer = peripheral.wrap("left")
local gunDrawer = peripheral.wrap("back")

local stopProgram = false

local function craftTNT()
    gunDrawer.pushItem("west", 2, 5)
    sandDrawer.pushItem("north", 2, 4)
end

local function pulseRedstone()
    redstone.setOutput("top", true)
    os.sleep(0.1)
    redstone.setOutput("top", false)
end

local function cycle()
    while stopProgram == false do
        craftTNT()
        os.sleep(0.5)
        pulseRedstone()
        os.sleep(10)
    end
end

local function waitForKeyPress()
    print("Press any key to stop program")
    os.pullEvent("key")
    stopProgram = true
end

parallel.waitForAny(waitForKeyPress, cycle)