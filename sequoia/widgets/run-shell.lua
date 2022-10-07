
local awful = require("awful")
local gfs = require("gears.filesystem")
local wibox = require("wibox")
local gears = require("gears")
local completion = require("awful.completion")

local run_shell = awful.widget.prompt{ prompt = "> " }

function new_run()

    local widget_instance = {
        _cached_wiboxes = {}
    }

    function widget_instance:_create_wibox()
        local w = wibox {
            visible = false,
            ontop = true,
            height = mouse.screen.geometry.height,
            width = mouse.screen.geometry.width,
            bg = '#111111' .. 'dd'
        }

        w:setup {
            {
                {
                    {
                        {
                            run_shell,
                            left = 10,
                            layout = wibox.container.margin,
                        },
                        id = 'left',
                        layout = wibox.layout.fixed.horizontal
                    },
                    bg = '#333',
                    shape = function(cr, width, height)
                        gears.shape.rectangle(cr, width, height)
                    end,
                    shape_border_color = '#333',
                    shape_border_width = 1,
                    forced_width = 300,
                    forced_height = 32,
                    widget = wibox.container.background
                },
                left = 10,
                bottom = 10,
                layout = wibox.container.margin
            },
            halign = "left",
            valign = "bottom",
            layout = wibox.container.place
        }

        return w
    end

    function widget_instance:launch()
        local s = mouse.screen
        if not self._cached_wiboxes[s] then
            self._cached_wiboxes[s] = {}
        end
        if not self._cached_wiboxes[s][1] then
            self._cached_wiboxes[s][1] = self:_create_wibox()
        end
        local w = self._cached_wiboxes[s][1]
        w.visible = true
        awful.placement.top(w, { margins = { bottom = 2 }, parent = s })
        awful.prompt.run {
            prompt = '> ',
            bg_cursor = '#333',
            textbox = run_shell.widget,
            completion_callback = completion.shell,
            exe_callback = function(...)
                run_shell:spawn_and_handle_error(...)
            end,
            history_path = gfs.get_cache_dir() .. "/history",
            done_callback = function() w.visible = false end
        }
    end

    return widget_instance
end

widget = new_run();

local function run()
    widget:launch();
end

return run;
