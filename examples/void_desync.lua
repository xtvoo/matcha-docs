-- Void Desync Script
-- Toggles chaotic teleportation on keybind 'V'.
-- Uses Vector3 directory manipulation for valid movement.

local bind = 0x56 -- Keybind 'V'
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local enabled = false
local last_key_state = false

print("Void Desync Loaded. Press 'V' to toggle.")

spawn(function()
    while true do
        -- Keybind Toggle
        if isrbxactive() then
            local pressed = iskeypressed(bind)
            if pressed and not last_key_state then
                enabled = not enabled
                print("Void Desync: " .. tostring(enabled))
            end
            last_key_state = pressed
        else
            last_key_state = false
        end

        -- Desync Logic
        if enabled then
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    -- Generate random offset
                    local randX = math.random(-500, 500)
                    local randY = math.random(-100, 100) -- Keep height relatively sane or go wild
                    local randZ = math.random(-500, 500)
                    
                    -- Apply random position
                    -- We re-read position each time to teleport relative to current "center"
                    -- OR we can just set absolute random positions if we want true chaos
                    local current = root.Position
                    if current then
                        -- Jitter movement
                        local target = Vector3.new(current.X + randX, current.Y + randY, current.Z + randZ)
                        root.Position = target
                    end
                end
            end
        end

        -- Speed of desync (Very fast)
        wait(0.01) 
    end
end)
