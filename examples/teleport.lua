-- Teleport Example
-- NOTE: 'CFrame' global may be nil in this environment.
-- Use 'Position' property of HumanoidRootPart instead.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- offset: Vector3 (x, y, z)
local function teleport(x, y, z)
    if root then
        local current = root.Position
        local target = Vector3.new(current.X + x, current.Y + y, current.Z + z)
        root.Position = target
        print("Teleported to: " .. tostring(target))
    end
end

-- Example: Teleport 50 studs up
teleport(0, 50, 0)
