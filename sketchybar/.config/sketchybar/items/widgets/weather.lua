local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local widget = require("helpers.widget")

-- Create weather widget using widget helper (not alias, since Raycast doesn't render in aliases)
local weather = widget.new("widgets.weather", {
    icon = icons.weather.cloud,
    label = "...",
    update_freq = 60,         -- Update every minute to keep temperature current
    update_background_on_theme = false,
    label_padding_right = 16, -- Increase right padding to prevent truncation
})

-- Map weather conditions to icons
local function get_weather_icon(condition)
    condition = condition:lower()
    if condition:match("sun") or condition:match("clear") then
        return icons.weather.sun
    elseif condition:match("rain") or condition:match("drizzle") then
        return icons.weather.rain
    elseif condition:match("snow") then
        return icons.weather.snow
    elseif condition:match("wind") then
        return icons.weather.wind
    else
        return icons.weather.cloud
    end
end

-- Fetch weather from Raycast's menu bar item
local function update_weather()
    sbar.exec(
        'osascript -e \'tell application "System Events" to tell process "Raycast" to get {name, help} of menu bar item 1 of menu bar 2\'',
        function(result)
            local temp, condition = result:match("([^,]+),%s*(.+)")
            if temp and condition then
                temp = temp:match("^%s*(.-)%s*$") -- Trim whitespace
                condition = condition:match("^%s*(.-)%s*$")

                -- Strip the ℃ symbol and replace with °C or just the number
                temp = temp:gsub("℃", "°C")

                local icon = get_weather_icon(condition)
                weather:set({
                    icon = { string = icon },
                    label = temp
                })
            end
        end)
end

-- Update immediately on load
update_weather()

-- Subscribe to routine updates
weather:subscribe("routine", update_weather)

-- Click to open Raycast weather popup
weather:subscribe("mouse.clicked", function()
    sbar.exec(
        'osascript -e \'tell application "System Events" to tell process "Raycast" to perform action "AXPress" of menu bar item 1 of menu bar 2\'')
end)

-- Add bracket (consistent with other widgets)
sbar.add("bracket", "widgets.weather.bracket", { weather.name }, {
    background = {
        color = colors.transparent,
        border_color = colors.transparent,
    },
})

-- Add padding (consistent with other widgets)
sbar.add("item", "widgets.weather.padding", {
    position = "right",
    width = settings.group_paddings,
})

-- Subscribe to theme changes to update colors
weather:subscribe("theme_changed", function()
    weather:set({
        background = {
            color = colors.bg0,
            border_color = colors.bg3,
        },
    })
end)
