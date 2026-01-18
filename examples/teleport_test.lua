-- Teleport Debug Script
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

print("--- Teleport Debug ---")
local success, err = pcall(function()
    print("Vector3 type: " .. type(Vector3))
    print("CFrame type: " .. type(CFrame))
    
    local pos = root.Position
    print("Current Pos: " .. tostring(pos))
    
    -- Check if we can access components
    local x = pos.X
    local y = pos.Y
    local z = pos.Z
    print("Coords: " .. x .. ", " .. y .. ", " .. z)
    
    -- Create new vector manually
    local newPos = Vector3.new(x, y + 50, z)
    print("New Target Pos: " .. tostring(newPos))
    
    -- Try setting Position directly
    print("Setting root.Position...")
    root.Position = newPos
    
    -- Optional: Try CFrame.new if Position doesn't replicate well
    -- print("Setting root.CFrame...")
    -- root.CFrame = CFrame.new(newPos) 
end)

if not success then
    print("[ERROR] Teleport failed: " .. tostring(err))
else
    print("Teleport seemingly successful.")
end
