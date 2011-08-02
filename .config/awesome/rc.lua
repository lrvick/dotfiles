-- {{{ Initialization
require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
beautiful.init(os.getenv("HOME").."/.config/awesome/themes/default/theme.lua")
require("naughty")

-- }}}
-- {{{ Variable definitions
terminal      = "urxvt"
editor        = os.getenv("EDITOR") or "nano"
editor_cmd    = terminal .. " -e " .. editor
use_titlebar  = true
sizehints     = false                        -- true/false honor size hints (breaks some apps but adds several unusable pixils to window edges)
ethernet_dev  = "eth1"                       -- ethernet device (usually eth0 or eth1)
wireless_dev  = ""                           -- wireless device (usually wlan0 or ath0)
cpu_number    = "1"                          -- number of cpus in system
spacer        = "  "                         -- what you want displayed between all widgets (single space is default)
thermal_zone  = "0"                          -- thermal device to check (usually 0 or 1)
battery       = "0"                          -- battery device to check (usually 0 or 1)
modkey        = "Mod4"
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}
-- {{{ Tags
tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}
-- {{{ Menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })
mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}
-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))


netupwidget_icon       = widget({	type = 'imagebox'    , align = 'right' })
netupwidget_icon.image = image(beautiful.networkupwidget_icon)
netupwidget_icon.resize = false
netupwidget_icon.valign = 'center'
awful.widget.layout.margins[netupwidget_icon] = { top = 5 }
netupwidget = widget({ type = 'textbox'     , align = 'right' })
netdownwidget_icon       = widget({	type = 'imagebox'    , align = 'right' })
netdownwidget_icon.image = image(beautiful.networkdownwidget_icon)
netdownwidget_icon.resize = false
netdownwidget_icon.valign = 'center'
awful.widget.layout.margins[netdownwidget_icon] = { top = 5 }
netdownwidget = widget({ type = 'textbox'     , align = 'right' })
function update_netspeedwidgets()
    local curr_bytes_down = 0
    local curr_bytes_up = 0
    local net_up
    local net_down
    for line in io.lines('/proc/net/dev') do
        local device,bytes_down,bytes_up = line:match('^[%s]?[%s]?[%s]?[%s]?([%w]+):[%s]?([%d]+)[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+[%d]+[%s]+([%d]+)[%s]')
        if device then
            curr_bytes_down = curr_bytes_down + bytes_down
            curr_bytes_up = curr_bytes_up + bytes_up
        end
    end
    if (total_bytes_down == nil) then
        total_bytes_down = curr_bytes_down
    end
    if (total_bytes_up == nil) then
        total_bytes_up = curr_bytes_up
    end
    net_down = math.floor((((curr_bytes_down - total_bytes_down) / 1048576) * 10^2) + 0.5) / (10^2)
    net_up = math.floor((((curr_bytes_up - total_bytes_up) / 1048576) * 10^2) + 0.5) / (10^2)
    total_bytes_down = curr_bytes_down
    total_bytes_up = curr_bytes_up
    netdownwidget.text = spacer .. net_down .. spacer
    netupwidget.text = spacer .. net_up .. spacer
end
update_netspeedwidgets()
awful.hooks.timer.register(1, function() update_netspeedwidgets() end)


ipwidget_icon       = widget({	type = 'imagebox'    , align = 'right' })
ipwidget_icon.image = image(beautiful.ipwidget_icon)
ipwidget_icon.resize = false
ipwidget_icon.valign = 'center'
awful.widget.layout.margins[ipwidget_icon] = { top = 5 }
ipwidget = widget({ type = 'textbox'     , align = 'right' })
function update_ipwidget() 
  local f = io.popen("/sbin/ifconfig eth1")
  if f then
    local ifOut = f:read('*a')
    f:close()
    ip = string.match(ifOut, 'inet addr:(.+)  Bcast')
    if ip then
      ipwidget.text = spacer .. ip .. spacer
		else
      ipwidget.text = spacer .. "no-ip" .. spacer
		end
  end
end
update_ipwidget()
awful.hooks.timer.register(1, function() update_ipwidget() end)

wireless_dev = "eth1"
if wireless_dev ~= ""  then
  ratewidget = widget({ type = 'textbox'     , align = 'right' })
  essidwidget = widget({ type = 'textbox'     , align = 'right' })
  lqwidget = widget({ type = 'textbox'     , align = 'right' })
  function update_wirelesswidgets() --{{{ returns wireless or ethernet connection info
    if wireless_dev ~= "" then
        local f = io.popen("/sbin/iwconfig " .. wireless_dev)
        if f then
          local iwOut = f:read('*a')
          f:close()
          linkq1,linkq2 = string.match(iwOut, 'Link Quality[=:](%d+)/(%d+)')
          essid   = string.match(iwOut, '.*ESSID[=:]"(.*)" ')
          quality = math.floor(100*linkq1/linkq2)
          bitrate = string.gsub(string.match(iwOut, 'Bit Rate[=:]([%s%w%.]*%/%a+)'), "%s", "")
        end
      else
        essid   = "Not Connected"
        bitrate = " "
        quality = "0"
      end
	  ratewidget.text = bitrate .. spacer
	  lqwidget.text = quality .."%" .. spacer
	  essidwidget.text = essid .. spacer
  end --}}}
  --update_wirelesswidgets()
  --awful.hooks.timer.register(1, function() update_wirelesswidgets() end)
end

cpuloadwidget_icon       = widget({	type = 'imagebox'    , align = 'right' })
cpuloadwidget_icon.image = image(beautiful.cpuloadwidget_icon)
cpuloadwidget_icon.resize = false
cpuloadwidget_icon.valign = 'center'
awful.widget.layout.margins[cpuloadwidget_icon] = { top = 5 }
cpuloadwidget            = widget({ type = 'textbox'     , align = 'right' })
cpuspeedwidget            = widget({ type = 'textbox'     , align = 'right' })
function update_cpuloadwidget()
  if cpu0_total == null then
    cpu0_total  = 0
    cpu0_active = 0
  end
    local f = io.open('/proc/stat')
    for l in f:lines() do
     values = {}
     start = 1
     splitstart, splitend = string.find(l, ' ', start)
     while splitstart do
       m = string.sub(l, start, splitstart-1)
       if m:gsub(' ','') ~= '' then
         table.insert(values, m)
       end
       start = splitend+1
       splitstart, splitend = string.find(l, ' ', start)
     end
     m = string.sub(l, start)
     if m:gsub(' ','') ~= '' then
            table.insert(values, m)
     end
     cpu_usage = values
    if      cpu_usage[1] == "cpu0" then
            total_new     = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]+cpu_usage[5]
            active_new    = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]
            diff_total    = total_new-cpu0_total
            diff_active   = active_new-cpu0_active
            usage_percent = math.floor(diff_active/diff_total*100)
            cpu0_total    = total_new
            cpu0_active   = active_new
	        cpuloadwidget.text = spacer .. usage_percent .. "% /"
    end
end
f:close()
end
function update_cpuspeedwidget() --{{{ returns current cpu frequency
  local f = io.open("/proc/cpuinfo")
  local line = f:read()
  while line do
    if line:match("cpu MHz") then

      ghz = math.floor(((string.match(line, "%d+") / 1000) * 10^1) + 0.5) / (10^1)
    end
    line = f:read()
  end
  io.close(f)
	cpuspeedwidget.text = spacer .. ghz .. "Ghz" .. spacer
end --}}}
update_cpuspeedwidget()
update_cpuloadwidget()
awful.hooks.timer.register(1, function() update_cpuspeedwidget() end)
awful.hooks.timer.register(1, function() update_cpuloadwidget() end)

memoryusedwidget_icon       = widget({	type = 'imagebox'    , align = 'right' })
memoryusedwidget_icon.image = image(beautiful.memoryusedwidget_icon)
memoryusedwidget_icon.resize = false
memoryusedwidget_icon.valign = 'center'
awful.widget.layout.margins[memoryusedwidget_icon] = { top = 5 }
memoryusedwidget = widget({ type = 'textbox'     , align = 'right' })
function update_memoryusedwidget()
	local mem_free, mem_total, mem_c, mem_b
  local mem_percent, swap_percent, line, f, count
  count = 0
  f = io.open("/proc/meminfo")
  line = f:read()
  while line and count < 4 do
    if line:match("MemFree:") then
      mem_free = string.match(line, "%d+")
      count = count + 1;
    elseif line:match("MemTotal:") then
      mem_total = string.match(line, "%d+")
      count = count + 1;
    elseif line:match("Cached:") then
      mem_c = string.match(line, "%d+")
      count = count + 1;
    elseif line:match("Buffers:") then
      mem_b = string.match(line, "%d+")
      count = count + 1;
    end
    line = f:read()
  end
  io.close(f)
  --memoryusedwidget.text = spacer .. math.floor(100 * (mem_total - mem_free - mem_b - mem_c ) / mem_total).. "% /  " .. math.floor(mem_total / 1000) .. "M" .. spacer;
  memoryusedwidget.text = spacer .. math.floor(100 * (mem_total - mem_free - mem_b - mem_c ) / mem_total).. "%" .. spacer;
end
update_memoryusedwidget()
awful.hooks.timer.register(1, function() update_memoryusedwidget() end)

battery="0"
if battery ~= ""  then
  batterywidget_icon       = widget({	type = 'imagebox'    , align = 'right' })
  batterywidget_icon.image = image(beautiful.batterywidget_icon)
  batterywidget_icon.resize = false
  batterywidget_icon.valign = 'center'
  awful.widget.layout.margins[batterywidget_icon] = { top = 5 }
  batterywidget = widget({ type = 'textbox'     , align = 'right' })
  function update_batterywidget() --{{{ updates batterywidget with current battery charge level
    local a = io.popen("cat /sys/class/power_supply/BAT"..battery.."/energy_full")
    if a then
	    for line in a:lines() do
        full = line
      end
    end
    a:close()
    local b = io.popen("cat /sys/class/power_supply/BAT"..battery.."/energy_now")
    if b then
	    for line in b:lines() do
        now = line
      end
    end
    b:close()
	  if now and full then
	    batterywidget.text = spacer .. math.floor(now*100/full).."%" .. spacer
    end
  end --}}}
  update_batterywidget()
  awful.hooks.timer.register(1, function() update_batterywidget() end)
end

datewidget_icon       = widget({	type = 'imagebox'    , align = 'right' })
datewidget_icon.image = image(beautiful.datewidget_icon)
datewidget_icon.resize = false
datewidget_icon.valign = 'center'
awful.widget.layout.margins[datewidget_icon] = { top = 5 }
datewidget                     = widget({ type = 'textbox'     , align = 'right' })
function update_datewidget()
  datewidget.text  = spacer .. os.date('%a %d %b %H:%M') .. "  "
end
update_datewidget()
awful.hooks.timer.register(1, function() update_datewidget() end)



																					
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        --mylauncher,
        mylayoutbox[s],
        datewidget, datewidget_icon,
        batterywidget, batterywidget_icon,
        mytaglist[s],
        mypromptbox[s],
        cpuspeedwidget, cpuloadwidget, cpuloadwidget_icon, 
        memoryusedwidget, memoryusedwidget_icon,
        netupwidget, netupwidget_icon,
        netdownwidget, netdownwidget_icon,
        ipwidget, ipwidget_icon,
				ratewidget,
				essidwidget,
        mytasklist[s],
        s == 1 and mysystray or nil,
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}
-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
