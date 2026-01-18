local bind = 0x2E -- DEL key
local health_offset = 0x194
local Players = game:GetService("Players")
local player = Players and Players.LocalPlayer

local function getHumanoid()
    if not player then return nil end
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

spawn(function()
    local last = false
    while true do
        if isrbxactive() then
            local pressed = iskeypressed(bind)
            if pressed and not last then
                local hum = getHumanoid()
                if hum and hum.Address then
                    -- Write -10 to health offset to potentially glitch/reset character state (Anti-Stomp)
                    memory_write("float", hum.Address + health_offset, -10)
                end
            end
            last = pressed
        else
            last = false
        end

        wait(0.05)
    end
end)
