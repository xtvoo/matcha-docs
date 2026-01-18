-- Visual Tests for Matcha
-- Dumps fonts and tests drawing shapes

local function test(name, func)
    print("Testing: " .. name)
    local success, err = pcall(func)
    if not success then
        print("[FAIL] " .. name .. ": " .. tostring(err))
    else
        print("[PASS] " .. name)
    end
end

print("=== Visual Test Start ===")

-- Dump Fonts
if Drawing and Drawing.Fonts then
    print("\n--- Available Fonts ---")
    for k, v in pairs(Drawing.Fonts) do
        print("Font: " .. tostring(k) .. " = " .. tostring(v))
    end
else
    print("Drawing.Fonts not found")
end

-- Test Notify
test("notify", function()
    notify("Test Notification", "This is a test from visual_tests.lua", 5)
end)

-- Test Drawing Shapes
test("Drawing Shapes", function()
    local s = Drawing.new("Square")
    s.Visible = true
    s.Size = Vector2.new(50, 50)
    s.Position = Vector2.new(200, 200)
    s.Color = Color3.fromRGB(255, 0, 0)
    s.Filled = true
    print("Created Red Square at 200, 200")
    
    local c = Drawing.new("Circle")
    c.Visible = true
    c.Radius = 20
    c.Position = Vector2.new(300, 200)
    c.Color = Color3.fromRGB(0, 255, 0)
    print("Created Green Circle at 300, 200")

    local t = Drawing.new("Text")
    t.Visible = true
    t.Text = "Matcha Visual Test"
    t.Position = Vector2.new(200, 300)
    t.Size = 20.0
    t.Color = Color3.fromRGB(255, 255, 255)
    print("Created White Text at 200, 300")

    -- Clean up after 5 seconds
    task.spawn(function()
        task.wait(5)
        s:Remove()
        c:Remove()
        t:Remove()
        print("Removed visual tests")
    end)
end)

-- Test WorldToScreen
test("WorldToScreen", function()
    local cam = workspace.CurrentCamera
    if cam then
        local pos, visible = WorldToScreen(Vector3.new(0, 10, 0))
        print("WorldToScreen(0,10,0): " .. tostring(pos) .. ", Visible: " .. tostring(visible))
    else
        print("skipped WorldToScreen (no camera)")
    end
end)

print("=== Visual Test End ===")
