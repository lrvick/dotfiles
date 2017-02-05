local wibox = require("wibox")
local watch = require("awful.widget.watch")

ip_widget_icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/ip.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(ip_widget_icon, 5, 0, 5, 0)
}
ip_widget = wibox.widget.textbox()
watch("ip r get 192.0.2.4", 5, function(widget, stdout)
    local ip = stdout:match('src ([^\n]+)')
    if ip then
        ip_widget:set_text(" " .. ip)
    else
        ip_widget:set_text(" no-ip")
    end
end)
