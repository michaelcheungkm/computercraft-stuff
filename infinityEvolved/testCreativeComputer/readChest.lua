local glasses = peripheral.wrap("left")

function draw_image(image)
    local x_offset = 10
    local y_offset = 10

    for y, row in ipairs(image) do
        for x, color in ipairs(row) do
            local r,g,b = table.unpack(color)
            local pixel = glasses.addBox(x_offset + x, y_offset + y, 1, 1, 0x000000)
            pixel.setColor(rgbToHex(r,g,b))
        end
    end
end
 
function rgbToHex(r,g,b)
    return (r * 65536) + (g * 256) + b
end

function displayImage(image)
    draw_image(image)
end

function start()
    local image = {}

    while true do
        glasses.clear()
        displayImage(image)
        glasses.sync()
        sleep(0.1)
    end
end

start()