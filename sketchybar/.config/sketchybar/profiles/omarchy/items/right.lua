local colors = require("profiles.omarchy.colors")
local icons = require("icons")
local settings = require("settings")

local function open_control_center_wifi()
    sbar.exec([[osascript <<'APPLESCRIPT'
tell application "System Events"
  tell process "ControlCenter"
    set panelOpened to false
    repeat with mbIndex in {1, 2}
      try
        set menuItems to every menu bar item of menu bar mbIndex
        repeat with menuItem in menuItems
          set itemDescription to ""
          try
            set itemDescription to (value of attribute "AXDescription" of menuItem) as text
          end try
          if (itemDescription contains "Wi-Fi") or (itemDescription contains "WiFi") or ((itemDescription contains "Wi") and (itemDescription contains "Fi")) then
            perform action "AXPress" of menuItem
            set panelOpened to true
            exit repeat
          end if
        end repeat
      end try
      if panelOpened then exit repeat
    end repeat

    if panelOpened is false then
      repeat with mbIndex in {1, 2}
        try
          set menuItems to every menu bar item of menu bar mbIndex
          repeat with menuItem in menuItems
            set itemDescription to ""
            try
              set itemDescription to (value of attribute "AXDescription" of menuItem) as text
            end try
            if itemDescription contains "Control Center" then
              perform action "AXPress" of menuItem
              set panelOpened to true
              exit repeat
            end if
          end repeat
        end try
        if panelOpened then exit repeat
      end repeat
    end if

    if panelOpened is false then error "Wi-Fi panel not found"
  end tell
end tell
APPLESCRIPT
if [ $? -ne 0 ]; then
  open /System/Library/PreferencePanes/Network.prefPane
fi]])
end

local function open_control_center_sound()
    sbar.exec([[osascript <<'APPLESCRIPT'
tell application "System Events"
  tell process "ControlCenter"
    set panelOpened to false
    repeat with mbIndex in {1, 2}
      try
        set menuItems to every menu bar item of menu bar mbIndex
        repeat with menuItem in menuItems
          set itemDescription to ""
          try
            set itemDescription to (value of attribute "AXDescription" of menuItem) as text
          end try
          if itemDescription contains "Sound" or itemDescription contains "Volume" then
            perform action "AXPress" of menuItem
            set panelOpened to true
            exit repeat
          end if
        end repeat
      end try
      if panelOpened then exit repeat
    end repeat

    if panelOpened is false then
      repeat with mbIndex in {1, 2}
        try
          set menuItems to every menu bar item of menu bar mbIndex
          repeat with menuItem in menuItems
            set itemDescription to ""
            try
              set itemDescription to (value of attribute "AXDescription" of menuItem) as text
            end try
            if itemDescription contains "Control Center" then
              perform action "AXPress" of menuItem
              set panelOpened to true
              exit repeat
            end if
          end repeat
        end try
        if panelOpened then exit repeat
      end repeat
    end if

    if panelOpened is false then error "Sound panel not found"
  end tell
end tell
APPLESCRIPT
if [ $? -ne 0 ]; then
  open /System/Library/PreferencePanes/Sound.prefPane
fi]])
end

local clock = sbar.add("item", "omarchy.clock", {
    position = "right",
    icon = { drawing = false },
    label = {
        string = "--- -- --- --:--",
        color = colors.fg,
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Regular"],
            size = 13.0,
        },
    },
    update_freq = 30,
    padding_left = 8,
    padding_right = 10,
})

clock:set({ label = { string = os.date("%a %d %b %H:%M") } })

clock:subscribe({ "routine", "forced", "system_woke" }, function()
    clock:set({
        label = { string = os.date("%a %d %b %H:%M") },
    })
end)

clock:subscribe("mouse.clicked", function()
    sbar.exec([[osascript -e 'tell application "System Events" to key code 49 using {control down, option down}']])
end)

local battery = sbar.add("item", "omarchy.battery", {
    position = "right",
    icon = {
        string = icons.battery._100,
        color = colors.fg,
    },
    label = { drawing = false },
    update_freq = 120,
    padding_left = 8,
    padding_right = 2,
})

battery:subscribe({ "routine", "forced", "power_source_change", "system_woke" }, function()
    sbar.exec("pmset -g batt", function(batt_info)
        local icon = icons.battery._100
        local charge = tonumber(batt_info:match("(%d+)%%") or "100")
        local charging = batt_info:find("AC Power") ~= nil

        if charging then
            icon = icons.battery.charging
        elseif charge > 80 then
            icon = icons.battery._100
        elseif charge > 60 then
            icon = icons.battery._75
        elseif charge > 40 then
            icon = icons.battery._50
        elseif charge > 20 then
            icon = icons.battery._25
        else
            icon = icons.battery._0
        end

        battery:set({
            icon = {
                string = icon,
                color = charge <= 20 and colors.red or colors.fg,
            },
        })
    end)
end)

local cpu = sbar.add("item", "omarchy.cpu", {
    position = "right",
    icon = {
        string = icons.cpu,
        color = colors.fg,
    },
    label = { drawing = false },
    padding_left = 8,
    padding_right = 2,
})

cpu:subscribe("mouse.clicked", function()
    sbar.exec(
        'osascript -e \'tell application "System Events" to tell process "Raycast" to perform action "AXPress" of menu bar item 1 of menu bar 2\'')
end)

local function get_weather_icon(condition)
    local normalized = condition:lower()
    if normalized:match("sun") or normalized:match("clear") then
        return icons.weather.sun
    elseif normalized:match("rain") or normalized:match("drizzle") then
        return icons.weather.rain
    elseif normalized:match("snow") then
        return icons.weather.snow
    elseif normalized:match("wind") then
        return icons.weather.wind
    end
    return icons.weather.cloud
end

local weather = sbar.add("item", "omarchy.weather", {
    position = "right",
    icon = {
        string = icons.weather.cloud,
        color = colors.fg,
    },
    label = {
        string = "--C",
        color = colors.fg,
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Regular"],
            size = 13.0,
        },
    },
    update_freq = 60,
    padding_left = 8,
    padding_right = 2,
})

weather:subscribe("mouse.clicked", function()
    sbar.exec(
        'osascript -e \'tell application "System Events" to tell process "Raycast" to perform action "AXPress" of menu bar item 2 of menu bar 2\'')
end)

local function update_weather()
    local function apply_weather(raw)
        if raw == "" or raw:match("missing value") then
            return false
        end

        local temp, condition = raw:match("([^,]+),%s*(.+)")
        if not temp then
            return false
        end

        temp = temp:match("^%s*(.-)%s*$")
        condition = condition:match("^%s*(.-)%s*$")
        temp = temp:gsub("℃", "")
        temp = temp:gsub("°", "")
        temp = temp .. "C°"

        weather:set({
            icon = { string = get_weather_icon(condition) },
            label = { string = temp },
        })

        return true
    end

    sbar.exec(
        'osascript -e \'tell application "System Events" to tell process "Raycast" to get {name, help} of menu bar item 1 of menu bar 2\'',
        function(result)
            local raw = result or ""
            if apply_weather(raw) then
                return
            end

            sbar.exec(
                'osascript -e \'tell application "System Events" to tell process "Raycast" to get {name, help} of menu bar item 2 of menu bar 2\'',
                function(fallback)
                    apply_weather(fallback or "")
                end)
        end)
end

weather:subscribe({ "routine", "forced", "system_woke" }, update_weather)

local volume = sbar.add("item", "omarchy.volume", {
    position = "right",
    width = 26,
    icon = {
        string = icons.volume._100,
        color = colors.fg,
        width = 16,
        align = "center",
        padding_left = 0,
        padding_right = 0,
    },
    label = { drawing = false },
    padding_left = 8,
    padding_right = 2,
})

volume:subscribe("volume_change", function(env)
    local value = tonumber(env.INFO) or 0
    local icon = icons.volume._0

    if value > 60 then
        icon = icons.volume._100
    elseif value > 30 then
        icon = icons.volume._66
    elseif value > 10 then
        icon = icons.volume._33
    elseif value > 0 then
        icon = icons.volume._10
    end

    volume:set({
        icon = {
            string = icon,
            color = value == 0 and colors.fg_muted or colors.fg,
        },
    })
end)

volume:subscribe("mouse.clicked", function()
    open_control_center_sound()
end)

sbar.exec("osascript -e 'output volume of (get volume settings)'", function(initial_volume)
    local value = tonumber(initial_volume:match("%d+")) or 0
    sbar.trigger("volume_change", { INFO = tostring(value) })
end)

local wifi = sbar.add("item", "omarchy.wifi", {
    position = "right",
    icon = {
        string = icons.wifi.connected,
        color = colors.fg,
    },
    label = { drawing = false },
    padding_left = 8,
    padding_right = 2,
})

wifi:subscribe({ "wifi_change", "system_woke", "forced" }, function()
    sbar.exec("ipconfig getifaddr en0", function(ip)
        local connected = ip and ip ~= ""
        wifi:set({
            icon = {
                string = connected and icons.wifi.connected or icons.wifi.disconnected,
                color = connected and colors.fg or colors.fg_muted,
            },
        })
    end)
end)

wifi:subscribe("mouse.clicked", function()
    open_control_center_wifi()
end)

sbar.add("bracket", "omarchy.segment.right", {
    clock.name,
    battery.name,
    cpu.name,
    weather.name,
    volume.name,
    wifi.name,
}, {
    background = {
        drawing = true,
        color = colors.bg,
        border_color = colors.border,
        border_width = 1,
        corner_radius = 10,
        height = 30,
    },
})

sbar.trigger("forced")
