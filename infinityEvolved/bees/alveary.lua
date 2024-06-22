local stopProgram = false

local breedingTree = {
    {"Common", "Sorcerous"},
    {"Sorcerous", "Cultivated"},
    {"Cultivated", "Eldritch"},
    {"Eldritch", "Esoteric"},
    {"Esoteric", "Mysterious"}
}

local CHEST_NAME = "right"
local chest = peripheral.wrap(CHEST_NAME)

local ALVEARY_NAME = "items_1"
local alveary = peripheral.wrap(ALVEARY_NAME)

local deadQueen = false

local function timePrint(string)
    print(os.time(), ": ", string)
end

local function returnBeeIndex(beeDisplayName)
    local inv = chest.getAllStacks()

    for invSlot, value in pairs(inv) do
        if value.basic().display_name == beeDisplayName then
            timePrint("Found ".. beeDisplayName .. " at " .. invSlot)
            return invSlot
        end
    end

    timePrint(beeDisplayName .. "not found")
    return -1
end

local function breedingBees()
    for i = #breedingTree, 1, -1 do

        local bee1Drone = returnBeeIndex(breedingTree[i][1] .. " Drone")
        local bee2Princess = returnBeeIndex(breedingTree[i][2] .. " Princess")


        if (bee2Princess ~= -1) and (bee1Drone ~= -1) then
            return { bee2Princess, bee1Drone }
        end

        local bee1Princess = returnBeeIndex(breedingTree[i][1] .. " Princess")
        local bee2Drone = returnBeeIndex(breedingTree[i][2] .. " Drone")

        if (bee2Drone ~= -1) and (bee1Princess ~= -1) then
            return { bee2Drone, bee1Princess }
        end
    end
end

local function pushBees(indicies)
    local index1 = indicies[1]
    local index2 = indicies[2]

    chest.pushItem("up", index1, 1)
    chest.pushItem("up", index2, 1)
end

local function detectDeadQueen()
    local QUEEN_SLOT = 1

    local alvInv = alveary.getAllStacks()
    if alvInv[QUEEN_SLOT] == nil then
        deadQueen = true
    else
        deadQueen = false
    end
end

local function cycle()
    while stopProgram == false do
        timePrint("Scanning for dead queen")
        detectDeadQueen()
        if deadQueen then
            os.sleep(5)
            timePrint("Dead queen detected")
            pushBees(breedingBees())
        end

        os.sleep(10)
    end
end

local function waitForKeyPress()
    print("Press any key to stop program")
    os.pullEvent("key")
    stopProgram = true
end

parallel.waitForAny(waitForKeyPress, cycle)