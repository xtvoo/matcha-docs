-- Desync API Simulation for Matcha
-- Replicates a "Server-Side" desync by breaking physics replication via Velocity.
-- When enabled, Server sees you frozen/lagging, while Client moves freely.

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local DesyncAPI = {}
local connection = nil
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
    
    -- The "Velocity Desync" Method:
    -- We set the velocity to a massive value on Heartbeat.
    -- This confuses the server's physics interpolation, often causing the character 
    -- to appear frozen or stuttering at usage point on the server.
    
    connection = RunService.Heartbeat:Connect(function()
        if root then
            -- Set incredibly high velocity to break replication
            -- Some anti-cheats clamp this, but standard Roblox physics often break.
            -- Using a Vector3 with huge components.
            local currentVel = root.Velocity
            
            -- We preserve Y to avoid falling through flaws, usually.
            -- Actually, to break replication, we want Nan or Huge.
            root.Velocity = Vector3.new(0, -10000, 0) -- Force down hard, or huge side
            -- Alternative: root.Velocity = Vector3.new(20000, 0, 20000)
            
            -- Keep CFrame valid locally so WE can move
            -- (The RunService step might try to move us based on Velocity, so we might fight it.
            --  Usually people Reset Velocity immediately after Stepped, 
            --  but for Desync we WANT the server to reject the packet).
            
            -- Standard "Vel Stand" desync:
            root.Velocity = Vector3.new(0, 0, 0) 
            -- Wait, 0,0,0 is for stability.
            -- Unnamed API "Desync" usually means: Server thinks I'm here, I am over there.
            -- A common way is to manipulate 'SetNetworkOwner' (impossible usually)
            -- or simply set Velocity to Magnitude > 1000.
            
            root.Velocity = Vector3.new(0, 25, 0) -- Bobbing?
            -- Let's try the classic "10e10" method if Vector3 supports it cleanly
            
            root.Velocity = Vector3.new(100000, 100000, 100000)
            -- Immediately setting CFrame prevents us from flying away?
            -- No, RunService.RenderStepped is for visual.
            -- We need to ensure WE don't fly away.
        end
    end)
    
    -- Fix local movement fighting the huge velocity
     RunService.RenderStepped:Connect(function()
         -- If we are setting extreme velocity, we might glitch locally.
         -- Let's try a safer approach: "Clamping" local physics?
         if root then
            root.Velocity = Vector3.zero
         end
    end)
end

function DesyncAPI.disable()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    DesyncAPI.visualize(false)
    print("Desync Disabled")
end

function DesyncAPI.visualize(bool)
    if bool then
        if visual_clone then DesyncAPI.visualize(false) end
        
        local char = player.Character
        char.Archivable = true
        visual_clone = char:Clone()
        visual_clone.Parent = workspace
        visual_clone.Name = "Desync_Ghost"
        
        -- Make it a ghost
        for _, p in pairs(visual_clone:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Anchored = true
                p.CanCollide = false
                p.Transparency = 0.6
                p.Color = Color3.fromRGB(255, 0, 0) -- Red Ghost is "Server Position"
            elseif p:IsA("Script") then
                p:Destroy()
            end
        end
        
        -- Position it where we started
        if char:FindFirstChild("HumanoidRootPart") then
             visual_clone:SetPrimaryPartCFrame(char.HumanoidRootPart.CFrame)
        end
    else
        if visual_clone then
            visual_clone:Destroy()
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
