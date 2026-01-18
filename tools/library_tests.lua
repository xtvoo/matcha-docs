-- Library Tests for Matcha
local function dumplib(lib, name)
    if not lib then print(name .. " not found") return end
    print("--- " .. name .. " ---")
    for k, v in pairs(lib) do
        print(k .. " (" .. type(v) .. ")")
    end
end

print("=== Library Test Start ===")

dumplib(bit32, "bit32")
dumplib(vector, "vector")
dumplib(buffer, "buffer")
dumplib(utf8, "utf8")
dumplib(os, "os")
dumplib(table, "table")
dumplib(debug, "debug")

print("\n--- Probing Hidden Libs ---")
local hidden = {"crypt", "lz4", "WebSocket", "http", "fluxus", "syn", "bit"}
local env = getgenv and getgenv() or getfenv and getfenv() or _G
for _, name in ipairs(hidden) do
    if env[name] then
        print("[FOUND] " .. name)
    else
        print("[MISS] " .. name)
    end
end

print("\n--- Testing create_run_secure ---")
if create_run_secure then
    print("create_run_secure found")
    -- Not calling it to avoid crashes/security triggers, just checking existence effectively
else
    print("create_run_secure MISSING")
end

print("=== Library Test End ===")
