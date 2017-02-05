local wibox = require("wibox")
local widget = wibox.widget.textclock()
local icon = wibox.widget {
    {
        id = "icon",
        image = os.getenv("HOME").."/.config/awesome/themes/default/icons/clock.png",
        widget = wibox.widget.imagebox,
        resize = false
    },
    layout = wibox.container.margin(icon, 5, 0, 5, 0),
}
return { widget = widget, icon = icon }
