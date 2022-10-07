
-- click to focus
function focus(c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
end

local clientbuttons = gears.table.join(
    awful.button({}, 1, focus),
    awful.button({}, 2, focus),
    awful.button({}, 3, focus),
    awful.button({ "Mod4" }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ "Mod4" }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- sloppy focus
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)


awful.mouse.snap.edge_enabled = false
awful.mouse.snap.client_enabled = false


awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}


awful.rules.rules = {
    { 
        rule = {},                  -- All clients
        properties = { 
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },
    { 
        rule_any = {                -- Floating clients.
            instance = {
                "DTA",              -- firefox addon downthemall.
                "copyq",            -- includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "rs_game",          -- kal rust game windows
                "MessageWin",       -- kalarm.
                "Sxiv",
                "Tor Browser",      -- needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },
            name = {
                "Event Tester",     -- xev.
            },
            role = {
                "AlarmWindow",      -- thunderbird's calendar.
                "ConfigManager",    -- thunderbird's about:config.
                "pop-up",           -- e.g. google chrome's (detached) devtools.
            }
        }, 
        properties = { 
            floating = true,
            ontop = true
        }
    },
    {
        rule_any = {                -- Normal Clients
            type = { "normal", "dialog" }
        }, 
        properties = {              -- add title bars
            titlebars_enabled = true 
        }
    }
}
