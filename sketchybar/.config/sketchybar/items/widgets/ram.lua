local icons = require("icons")
local colors = require("colors")
local widget = require("helpers.widget")

-- Create base RAM widget with lavender color
local ram = widget.new("widgets.ram", {
    icon = icons.ram,
    label = "??%",
    update_background_on_theme = true,
    icon_color = colors.lavender,
    label_color = colors.lavender,
})

-- Update RAM usage every 15 seconds
ram:subscribe({ "routine", "forced", "system_woke" }, function(env)
    sbar.exec("memory_pressure", function(output)
        local free_percentage = output:match("System%-wide memory free percentage: (%d+)")
        if free_percentage then
            local load = 100 - tonumber(free_percentage)

            -- Color changes based on load: lavender or red only
            local color = colors.lavender
            if load > 70 then
                color = colors.red
            end

            ram:set({
                label = {
                    string = load .. "%",
                    color = color,
                },
                icon = {
                    color = color,
                },
            })
        end
    end)
end)

ram:subscribe("mouse.clicked", function(env)
    sbar.exec("open -a 'Activity Monitor'")
end)
