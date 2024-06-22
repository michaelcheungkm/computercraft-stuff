local side = "back" 
local apiary = peripheral.wrap(side)

if not apiary then
    print("No apiary found on the specified side.")
    return
end

local function checkForPrincessAndDrones()
    local slots = apiary.getInventorySize()
    for slot = 1, slots do
        local item = apiary.getStackInSlot(slot)
        if item then
            if item.name == "forestry:beePrincessGE" then
                print("Princess found in slot " .. slot)
                -- Add your custom logic here (e.g., notifying or triggering an event)
            elseif item.name == "forestry:beeDroneGE" then
                print("Drone found in slot " .. slot)
                -- Add your custom logic here (e.g., notifying or triggering an event)
            end
        end
    end
end

while true do
    checkForPrincessAndDrones()
    os.sleep(10)
end
