
-- Standard awesome library
gears = require("gears")
awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
menubar = require("menubar")

-- Handle startup errors
if awesome.startup_errors then
    naughty.notify({ 
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then 
            return 
        end
        
        in_error = true
        naughty.notify({ 
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",                 
            text = tostring(err) 
        })
        in_error = false
    end)
end

-- Run Sequoia
require("sequoia")
