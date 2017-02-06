local wibox = require("wibox")
local watch = require("awful.widget.watch")
local icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/wifi.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(icon, 5, 0, 5, 0),
}
local widget = wibox.widget.textbox()
watch("iwconfig", 10, function(w, stdout)
        essid = ""
        bitrate = ""
        quality = ""
        linkq1,linkq2 = string.match(stdout, 'Link Quality[=:](%d+)/(%d+)')
        essid   = string.match(stdout, '.*ESSID[=:]"(.*)" ')
        if essid then
            if linkq1 then
                quality = math.floor(100*linkq1/linkq2)
            end
            if linkq1 then
                bitrate = string.gsub(string.match(stdout, 'Bit Rate[=:]([%s%w%.]*%/%a+)'), "%s", "")
            end
            widget:set_text(" "..essid.." "..quality.."% "..bitrate.." ")
        end
end)
return { widget = widget, icon = icon }
