local bind = 0x2E -- DEL    https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
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
        local hum = getHumanoid()
        if hum and hum.Address then
            -- 1. Low Health Auto-Reset
            if hum.Health <= 25 and hum.Health > 0 then
                memory_write("float", hum.Address + health_offset, -10)
            end

            -- 2. Keybind Reset
            if isrbxactive() then
                local pressed = iskeypressed(bind)
                if pressed and not last then
                    memory_write("float", hum.Address + health_offset, -10)
                end
                last = pressed
            else
                last = false
            end
        end

        wait(0.05)
    end
end)
