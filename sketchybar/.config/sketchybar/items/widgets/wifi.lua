local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "network_update"
-- for the network interface "en0", which is fired every 2.0 seconds.
sbar.exec(
    "killall network_load >/dev/null; $CONFIG_DIR/helpers/event_providers/network_load/bin/network_load en0 network_update 2.0"
)

local popup_width = 250

-- Helper function to format bandwidth
local function format_bandwidth(bw_string)
    -- Handle different formats: "5000 Bps", "104KBps", "000 Bps"
    if not bw_string or bw_string == "" then
        return " 0.0 Mbps"
    end

    local kbps

    -- Check if already in KBps format (e.g., "104KBps")
    local kbps_value = bw_string:match("(%d+)KBps")
    if kbps_value then
        kbps = tonumber(kbps_value)
    else
        -- Otherwise assume "Bps" format (e.g., "5000 Bps")
        local bps = tonumber(bw_string:match("(%d+)"))
        if not bps then return " 0.0 Mbps" end
        kbps = bps / 1000.0
    end

    -- Always display as Mbps with one decimal place
    local mbps = kbps / 1000.0
    return string.format("%4.1f Mbps", mbps)
end

-- Upload (top row)
local wifi_up = sbar.add("item", "widgets.wifi1", {
    position = "right",
    padding_left = -5,
    padding_right = 1,
    width = 0,
    icon = {
        padding_right = 0,
        font = {
            style = settings.font.style_map["Semibold"],
            size = 8.0,
        },
        string = icons.wifi.upload,
        color = colors.lavender,
    },
    label = {
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Semibold"],
            size = 8.0,
        },
        padding_right = 8,
        color = colors.lavender,
        string = " 0.0 Mbps",
        width = 60, -- Fixed width to prevent shifting
    },
    y_offset = 4,
})

-- Download (bottom row)
local wifi_down = sbar.add("item", "widgets.wifi2", {
    position = "right",
    padding_left = -5,
    padding_right = 1,
    icon = {
        padding_right = 0,
        font = {
            style = settings.font.style_map["Regular"],
            size = 8.0,
        },
        string = icons.wifi.download,
        color = colors.lavender,
    },
    label = {
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Regular"],
            size = 8.0,
        },
        padding_right = 8,
        color = colors.lavender,
        string = " 0.0 Mbps",
        width = 60, -- Fixed width to prevent shifting
    },
    y_offset = -4,
})

-- WiFi status icon
local wifi = sbar.add("item", "widgets.wifi.padding", {
    position = "right",
    padding_left = 1,
    icon = {
        string = icons.wifi.connected,
        padding_left = 8,
        padding_right = 4,
        color = colors.lavender,
        font = {
            style = settings.font.style_map["Regular"],
            size = 15.0,
        },
    },
    label = { drawing = false },
})

-- Background around all items
local wifi_bracket = sbar.add("bracket", "widgets.wifi.bracket", {
    wifi.name,
    wifi_up.name,
    wifi_down.name,
}, {
    background = {
        color = colors.bg0,
        border_width = 1,
        height = 26,
        border_color = colors.bg3,
    },
    popup = { align = "center", height = 30 },
})

sbar.add("item", "widgets.wifi.padding", {
    position = "right",
    width = settings.group_paddings,
})

local ssid = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        font = {
            style = settings.font.style_map["Bold"],
        },
        string = icons.wifi.router,
    },
    width = popup_width,
    align = "center",
    label = {
        font = {
            size = 15,
            style = settings.font.style_map["Bold"],
        },
        max_chars = 18,
        string = "????????????",
    },
    background = {
        height = 2,
        color = colors.grey,
        y_offset = -15,
    },
})

local hostname = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        align = "left",
        string = "Hostname:",
        width = popup_width / 2,
    },
    label = {
        max_chars = 20,
        string = "????????????",
        width = popup_width / 2,
        align = "right",
    },
})

local ip = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        align = "left",
        string = "IP:",
        width = popup_width / 2,
    },
    label = {
        string = "???.???.???.???",
        width = popup_width / 2,
        align = "right",
    },
})

local mask = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        align = "left",
        string = "Subnet mask:",
        width = popup_width / 2,
    },
    label = {
        string = "???.???.???.???",
        width = popup_width / 2,
        align = "right",
    },
})

local router = sbar.add("item", {
    position = "popup." .. wifi_bracket.name,
    icon = {
        align = "left",
        string = "Router:",
        width = popup_width / 2,
    },
    label = {
        string = "???.???.???.???",
        width = popup_width / 2,
        align = "right",
    },
})

wifi_up:subscribe("network_update", function(env)
    -- Use the raw values from the event
    local upload_str = env.upload or "0 Bps"
    local download_str = env.download or "0 Bps"

    -- Format to Kbps or Mbps with fixed width
    local upload_formatted = format_bandwidth(upload_str)
    local download_formatted = format_bandwidth(download_str)

    wifi_up:set({
        icon = { color = colors.lavender },
        label = {
            string = upload_formatted,
            color = colors.lavender,
        },
    })
    wifi_down:set({
        icon = { color = colors.lavender },
        label = {
            string = download_formatted,
            color = colors.lavender,
        },
    })
end)

wifi:subscribe({ "wifi_change", "system_woke" }, function(env)
    sbar.exec("ipconfig getifaddr en0", function(ip)
        local connected = not (ip == "")
        wifi:set({
            icon = {
                string = connected and icons.wifi.connected or icons.wifi.disconnected,
                color = colors.lavender,
            },
        })
    end)
end)

local function hide_details()
    wifi_bracket:set({ popup = { drawing = false } })
end

local function toggle_details()
    local should_draw = wifi_bracket:query().popup.drawing == "off"
    if should_draw then
        wifi_bracket:set({ popup = { drawing = true } })
        sbar.exec("networksetup -getcomputername", function(result)
            hostname:set({ label = result })
        end)
        sbar.exec("ipconfig getifaddr en0", function(result)
            ip:set({ label = result })
        end)
        sbar.exec(
            "networksetup -listpreferredwirelessnetworks en0 | sed -n '2p' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'",
            function(result)
                ssid:set({ label = result })
            end)
        sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Subnet mask: ' '/^Subnet mask: / {print $2}'", function(result)
            mask:set({ label = result })
        end)
        sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
            router:set({ label = result })
        end)
    else
        hide_details()
    end
end

wifi_up:subscribe("mouse.clicked", toggle_details)
wifi_down:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.exited.global", hide_details)

local function copy_label_to_clipboard(env)
    local label = sbar.query(env.NAME).label.value
    sbar.exec('echo "' .. label .. '" | pbcopy')
    sbar.set(env.NAME, { label = { string = icons.clipboard, align = "center" } })
    sbar.delay(1, function()
        sbar.set(env.NAME, { label = { string = label, align = "right" } })
    end)
end

ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
ip:subscribe("mouse.clicked", copy_label_to_clipboard)
mask:subscribe("mouse.clicked", copy_label_to_clipboard)
router:subscribe("mouse.clicked", copy_label_to_clipboard)

wifi:subscribe("theme_changed", function()
    wifi:set({
        icon = { color = colors.lavender },
    })
    wifi_up:set({
        icon = { color = colors.lavender },
        label = { color = colors.lavender },
    })
    wifi_down:set({
        icon = { color = colors.lavender },
        label = { color = colors.lavender },
    })
end)

wifi_bracket:subscribe("theme_changed", function()
    wifi_bracket:set({
        background = {
            color = colors.bg0,
            border_color = colors.bg3,
        },
    })
end)
