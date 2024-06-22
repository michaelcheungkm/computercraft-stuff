-- Initialize the peripheral
local monitor = peripheral.wrap("left") -- Replace "right" with the side your monitor is on
local colorsList = {colors.red, colors.green, colors.blue, colors.yellow}
local highlightedBlock = 1
local blockColors = {colors.red, colors.green, colors.blue, colors.yellow}

-- Function to draw the blocks
local function drawBlocks()
    monitor.clear()
    for i = 1, 4 do
        if i == highlightedBlock then
            monitor.setBackgroundColor(colors.white)
        else
            monitor.setBackgroundColor(blockColors[i])
        end
        monitor.setCursorPos(1, i)
        monitor.write("   ")
    end
    monitor.setBackgroundColor(colors.black)
end

-- Function to handle monitor touch event
local function handleTouch(x, y)
    if x >= 1 and x <= 3 and y >= 1 and y <= 4 then
        highlightedBlock = y
        blockColors[y] = colorsList[((table.find(colorsList, blockColors[y]) % #colorsList) + 1)]
        drawBlocks()
    end
end

-- Main function
local function main()
    monitor.setTextScale(0.5)
    drawBlocks()
    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")
        handleTouch(x, y)
    end
end

-- Utility function to find index of a value in a table
function table.find(t, value)
    for k,v in pairs(t) do
        if v == value then
            return k
        end
    end
    return nil
end

-- Run the main function
local function waitForKeyPress()
    print("Press any key to stop program")
    os.pullEvent("key")
    stopProgram = true
end

parallel.waitForAny(waitForKeyPress, main)