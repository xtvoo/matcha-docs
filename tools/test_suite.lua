-- Test Suite for Matcha Documentation
-- Verifies availability and basic functionality of documented methods

local function test(name, func)
    print("Testing: " .. name)
    local success, err = pcall(func)
    if success then
        print("[PASS] " .. name)
    else
        print("[FAIL] " .. name .. " - Error: " .. tostring(err))
    end
end

print("=== Starting Matcha Test Suite ===")

test("identifyexecutor", function()
    local name, ver = identifyexecutor()
    print("  Executor: " .. tostring(name) .. ", Version: " .. tostring(ver))
    assert(name == "Matcha", "Executor name mismatch")
end)

test("getgenv", function()
    local env = getgenv()
    assert(type(env) == "table", "getgenv did not return a table")
end)

test("Console Functions", function()
    print("  Testing print...")
    warn("  Testing warn...")
    -- error("Testing error...") -- logic flow break
end)

test("Input Functions availability", function()
    assert(setrobloxinput, "setrobloxinput missing")
    assert(isrbxactive, "isrbxactive missing")
    assert(keypress, "keypress missing")
    assert(mouse1click, "mouse1click missing")
end)

test("Memory Functions availability", function()
    assert(memory_write, "memory_write missing")
    -- assert(memory_read, "memory_read missing") -- Assuming read exists if write exists?
end)

test("Drawing Library", function()
    assert(Drawing, "Drawing library missing")
    assert(Drawing.new, "Drawing.new missing")
    
    local square = Drawing.new("Square")
    assert(square, "Failed to create Square")
    square.Visible = true
    square.Color = Color3.fromRGB(0, 255, 0)
    square.Position = Vector2.new(100, 100)
    task.wait(1)
    square:Remove()
    print("  Drawing test complete")
end)

test("Instance.Address", function()
    local plr = game:GetService("Players").LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    
    if hum.Address then
        print("  Humanoid Address: " .. tostring(hum.Address))
        local hex = string.format("%X", hum.Address)
        print("  Hex Address: " .. hex)
    else
        error("Instance.Address property missing")
    end
end)

print("=== Test Suite Complete ===")
