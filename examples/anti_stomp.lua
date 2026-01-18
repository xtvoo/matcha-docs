-- Anti-Stomp & Low Health Reset Script
-- Automatically resets character if health is low to prevent stomping.
-- Validates keybind execution with memory_write.

local bind = 0x2E -- DEL key
local health_offset = 0x194 -- Offset for health (example)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("Anti-Stomp Script Loaded")

local function getHumanoid(char)
    return char:FindFirstChildOfClass("Humanoid")
end

local function handleCharacter(char)
    -- Wait for humanoid to exist
    local hum = char:WaitForChild("Humanoid", 10)
    if not hum then return end

    print("Character hooked: " .. char.Name)

    task.spawn(function()
        local last_key_state = false
        
        while char and char.Parent and hum.Health > 0 do
            -- 1. Low Health Reset (Auto-Reset)
            -- 1. Low Health Reset (Auto-Reset)
            -- If health is low, glitch it to -10 immediately
            if hum.Health <= 25 and hum.Health > 0 then
                 pcall(function() 
                      memory_write("float", hum.Address + health_offset, -10)
                 end)
            end

            -- 2. Manual Anti-Stomp / Glitch Keybind
            if isrbxactive() then
                local pressed = iskeypressed(bind)
                if pressed and not last_key_state then
                    if hum.Address then
                        print("[Anti-Stomp] Key pressed, attempting memory glitch...")
                        -- Verify current value before writing if we had memory_read
                        -- For now, just write as per original logic
                        local success, err = pcall(function() 
                             memory_write("float", hum.Address + health_offset, -10)
                        end)
                        if success then
                            print("[Anti-Stomp] Memory write success")
                        else
                            warn("[Anti-Stomp] Write failed: " .. tostring(err))
                        end
                    else
                        warn("[Anti-Stomp] Humanoid Address not available")
                    end
                end
                last_key_state = pressed
            else
                last_key_state = false
            end

            task.wait(0.05) -- Check rate
        end
        print("Character loop ended for " .. char.Name)
    end)
end

-- Initialize for current character
pcall(function()
    if player.Character then
        handleCharacter(player.Character)
    end
end)

-- Auto-Load: Handle future characters with safe check
if player.CharacterAdded then
    player.CharacterAdded:Connect(handleCharacter)
    print("Hooked CharacterAdded event")
else
    warn("CharacterAdded event missing, using fallback loop")
    task.spawn(function()
        local lastChar = player.Character
        while true do
            task.wait(1)
            if player.Character ~= lastChar then
                lastChar = player.Character
                if lastChar then
                    handleCharacter(lastChar)
                end
            end
        end
    end)
end
