-- Void Desync Script
-- Toggles chaotic teleportation on keybind 'V'.
-- Uses Vector3 directory manipulation for valid movement.

local bind = 0x56 -- Keybind 'V'
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local enabled = false
local last_key_state = false
local saved_pos = nil

print("Void Desync Loaded. Press 'V' to toggle.")

spawn(function()
    while true do
        -- Keybind Toggle
        if isrbxactive() then
            local pressed = iskeypressed(bind)
            if pressed and not last_key_state then
                enabled = not enabled
                print("Void Desync: " .. tostring(enabled))
                
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        if enabled then
                            -- Save position when enabling
                            saved_pos = root.Position
                            print("Saved Pos: " .. tostring(saved_pos))
                        else
                            -- Restore position when disabling
                            if saved_pos then
                                root.Position = saved_pos
                                print("Restored Pos: " .. tostring(saved_pos))
                            end
                        end
                    end
                end
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
                if root and saved_pos then
                    -- Generate random offset relative to SAVED position to prevent drift
                    -- User requested: "keep our y level and change the x and z"
                    
                    local randX = math.random(-50, 50) -- Jitter range
                    local randZ = math.random(-50, 50)
                    
                    -- Anchor to saved_pos to avoid "zooming off"
                    local target = Vector3.new(saved_pos.X + randX, saved_pos.Y, saved_pos.Z + randZ)
                    root.Position = target
                end
            end
        end

        -- Speed of desync (Very fast)
        wait(0.01) 
    end
end)
