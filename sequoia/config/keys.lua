
-----------------
-- file constants
local mod = { config.modkey }
local shift_mod = { config.modkey, "Shift" }
local ctrl = { "Control" }
local ctrl_mod = { config.modkey, "Control" }
local ctrl_alt = { "Mod1", "Control" }


-------------------
-- imported actions
local run = require("sequoia.widgets.run-shell")

local revelation = require("sequoia.widgets.revelation");
revelation.init();
local function reveal()
    revelation.expose()
end


----------------------
-- window manipulation
local function swap_window(direction)
    return function ()
        awful.client.swap.global_bydirection(direction)
    end
end

local function focus_window(direction)
    return function ()
        awful.client.focus.global_bydirection(direction)
    end
end

local function increase_size()
    awful.tag.incmwfact(0.05)
end

local function decrease_size()
    awful.tag.incmwfact(-0.05)
end

local function toggle_floating()
    c = awful.client.focus.history.get()
    if c == nil then return end
    c.floating = not c.floating
end

local function hide(c)
    c = awful.client.focus.history.get()
    if c == nil then return end
    c.minimized = true
end

local function close(c)
    c = awful.client.focus.history.get()
    if c == nil then return end
    c:kill()
end

----------------
-- other actions
local function logout()
    awful.spawn.with_shell("kill -9 -1")
end

local function spawn_terminal() 
    awful.spawn(config.terminal)
end

local function lock()
    awful.spawn.with_shell("lock.sh")
end

local function screenshot()
    awful.spawn.with_shell("screenshot.sh")
end


---------------
-- key bindings
return gears.table.join(

    awful.key(mod, "t", spawn_terminal),
    awful.key(mod, "s", screenshot),

    awful.key(ctrl, "space", run),
    awful.key(mod, "e", reveal),

    awful.key(mod, "x", lock),
    awful.key(mod, "Escape", awesome.restart),
    awful.key(ctrl_alt, "BackSpace", logout),

    awful.key(mod, "f", toggle_floating),
    awful.key(mod, "h", hide),
    awful.key(mod, "q", close),

    awful.key(mod, "m", increase_size),
    awful.key(mod, "n", decrease_size),

    awful.key(mod, "i", focus_window("up")),
    awful.key(mod, "k", focus_window("down")),
    awful.key(mod, "j", focus_window("left")),
    awful.key(mod, "l", focus_window("right")),

    awful.key(shift_mod, "i", swap_window("up")),
    awful.key(shift_mod, "k", swap_window("down")),
    awful.key(shift_mod, "j", swap_window("left")),
    awful.key(shift_mod, "l", swap_window("right"))
)


----------------
-- broken / todo

-- never used but maybe i did idk
-- awful.key(ctrl_mod, "n", restore_minimized),
-- local function restore_minimized()
--     local c = awful.client.restore()
--     if c then
--         c:emit_signal(
--             "request::activate", "key.unminimize", {raise = true}
--         )
--     end
-- end

-- this may not fit in soon
-- awful.key(mod, "f", toggle_floating),
-- local function toggle_floating()
--     awful.layout.inc(1)
-- end

-- doesn't work how i want
-- awful.key(mod, "Tab", focus_forward),
-- local function focus_forward()
--     awful.client.focus.byidx(1)
-- end 

-- doesn't work how i want
-- awful.key(shift_mod, "Tab", focus_backward),
-- local function focus_backward()
--     awful.client.focus.byidx(-1)
-- end

-- depends on other library
-- awful.key(mod, "e", reveal),
-- local function reveal()
-- end


-- local function run()
-- end
