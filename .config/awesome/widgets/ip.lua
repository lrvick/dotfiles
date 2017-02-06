local wibox = require("wibox")
local watch = require("awful.widget.watch")
local icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/ip.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(icon, 5, 0, 5, 0)
}
local widget = wibox.widget.textbox()
watch("ip r get 192.0.2.4", 5, function(w, stdout)
    local ip = stdout:match('src ([^\n]+)')
    if ip then
        widget:set_text(" " .. ip)
    else
        widget:set_text(" no-ip")
    end
end)
return { widget = widget, icon = icon }
