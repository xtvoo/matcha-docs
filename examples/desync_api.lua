-- Desync API Simulation for Matcha
-- Replicates a "Server-Side" desync by breaking physics replication via Velocity.
-- When enabled, Server sees you frozen/lagging, while Client moves freely.

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local DesyncAPI = {}
local connection = nil
local stepped_conn = nil
local visualizing = false
local visual_clone = nil

function DesyncAPI.enable()
    if connection then return end
    print("Desync Enabled")
    
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Create visual Ghost (Server Position Representation)
    DesyncAPI.visualize(true)
    
    local RunService = game:GetService("RunService")
    
    -- 1. Heartbeat: Set Massive Velocity to confuse Server Replication
    connection = RunService.Heartbeat:Connect(function()
        if root and root.Parent then
            -- Setting velocity to huge numbers breaks the physics packet on server side
            -- causing it to discard the movement updates, effectively freezing you there.
            root.Velocity = Vector3.new(20000, 20000, 20000) 
            -- Some scripts use Vector3.new(0/0,0/0,0/0) (NaN) but that can crash client.
            
            -- We also spam CFrame setting locally to override the velocity drift?
            -- No, RunService.Stepped handles physics.
            root.RotVelocity = Vector3.new(20000, 20000, 20000)
        end
    end)
    
    -- 2. RenderStepped: Keep client smooth / Override physics drift
    stepped_conn = RunService.RenderStepped:Connect(function()
        if root and root.Parent then
            -- Force velocity back to zero LOCALLY immediately after frame
            -- so we don't fling off screen on our own screen.
            root.Velocity = Vector3.new(0, 0, 0)
            root.RotVelocity = Vector3.new(0, 0, 0)
        end
    end)
end

function DesyncAPI.disable()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    if stepped_conn then
        stepped_conn:Disconnect()
        stepped_conn = nil
    end
    DesyncAPI.visualize(false)
    print("Desync Disabled")
end

function DesyncAPI.visualize(bool)
    if bool then
        if visual_clone then DesyncAPI.visualize(false) end
        
        local char = player.Character
        if not char then return end
        
        -- Check if Instance.new is available
        if not Instance or not Instance.new then
            warn("Visualizer disabled: 'Instance' global is missing.")
            return
        end
        
        -- Manual Ghost Creation (Archivable/Clone bypass)
        local success, err = pcall(function()
            local ghostFolder = Instance.new("Folder")
            ghostFolder.Name = "Desync_Ghost"
            ghostFolder.Parent = workspace
            visual_clone = ghostFolder
            
            for _, p in pairs(char:GetChildren()) do
                if p:IsA("BasePart") then
                    -- Create a simple block for each body part
                    local part = Instance.new("Part")
                    part.Name = p.Name
                    part.Size = p.Size
                    part.Position = p.Position
                    
                    pcall(function() part.Rotation = p.Rotation end)
                    
                    part.Anchored = true
                    part.CanCollide = false
                    part.Transparency = 0.6
                    part.Color = Color3.fromRGB(255, 0, 0)
                    part.Material = Enum.Material.Neon
                    part.Parent = ghostFolder
                end
            end
        end)
        
        if not success then
            warn("Visualizer failed: " .. tostring(err))
        end
    else
        if visual_clone then
            pcall(function() visual_clone:Destroy() end)
            visual_clone = nil
        end
    end
end

function DesyncAPI.toggle()
    if connection then
        DesyncAPI.disable()
    else
        DesyncAPI.enable()
    end
end

-- Bind to X
local bind = 0x58 -- X
local last = false

print("Desync API Loaded. Press 'X' to toggle.")

spawn(function()
    while true do
        if isrbxactive() then
            local pressed = iskeypressed(bind)
            if pressed and not last then
                DesyncAPI.toggle()
            end
            last = pressed
        else
            last = false
        end
        wait(0.05)
    end
end)
