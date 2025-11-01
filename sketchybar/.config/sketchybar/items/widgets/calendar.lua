local icons = require("icons")
local widget = require("helpers.widget")

-- Create base calendar widget
local calendar = widget.new("widgets.calendar", {
    icon = icons.calendar,
    label = "Loading...",
    update_freq = 30,
    update_background_on_theme = true,
})

-- Add time update subscription
calendar:subscribe({ "routine", "forced", "system_woke" }, function(env)
    calendar:set({
        label = { string = os.date("%a %d %b %H:%M") }
    })
end)

-- Add click handler
calendar:subscribe("mouse.clicked", function(env)
    sbar.exec("open -a 'Fantastical'")
end)
