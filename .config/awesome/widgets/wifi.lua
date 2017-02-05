local wibox = require("wibox")
local watch = require("awful.widget.watch")

wifi_widget_icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/wifi.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(wifi_widget_icon, 5, 0, 5, 0),
}
wifi_widget = wibox.widget.textbox()
watch(
    "wifi", 10,
    function(widget, stdout, stderr, exitreason, exitcode)
        essid = ""
        bitrate = ""
        quality = ""
        if wireless_dev ~= "" then
            local f = io.popen("iwconfig")
            if f then
                local iwOut = f:read('*a')
                f:close()
                linkq1,linkq2 = string.match(iwOut, 'Link Quality[=:](%d+)/(%d+)')
                essid   = string.match(iwOut, '.*ESSID[=:]"(.*)" ')
                if essid then
                    if linkq1 then
                        quality = math.floor(100*linkq1/linkq2)
                    end
                    if linkq1 then
                        bitrate = string.gsub(string.match(iwOut, 'Bit Rate[=:]([%s%w%.]*%/%a+)'), "%s", "")
                    end
                    wifi_widget:set_text(" "..essid.." "..quality.."% "..bitrate.." ")
                end
            end
        end
    end
)
