# This script renames your Facebook buddies to a readable format when 
# using Facebook's XMPP gateway with Bitlbee or Minbif.
#
# Based on the Irssi script at http://browsingtheinternet.com/temp/bitlbee_rename.txt 
# Ported for Weechat 0.3.0 or later by Jaakko Lintula (crwl@iki.fi)
# Minbif support added by David Pflug (dtpflug@gmail.com)
# Bitlbee support temporarily broken by same. ;)
#
# This script is in the public domain.


gatewayService = "bitlbee"
gatewayChannel = "&bitlbee"
gatewayServer = "im"


gatewayBuffer = "%s.%s" % (gatewayServer, gatewayChannel)
facebookhostname = "chat.facebook.com"
nicksToRename = set()

import weechat
import re
import time

weechat.register("facebook_rename", "crwl, dtpflug", "1.2", "Public Domain", "Renames Facebook usernames when using Bitlbee", "", "")

def message_join(data, signal, signal_data):
  signal_data = signal_data.split()
  hostmask = signal_data[0]
  nick = hostmask[1:hostmask.index('!')]
  username = hostmask[hostmask.index('!')+1:hostmask.index('@')]
  if gatewayService == "bitlbee":
    channel = signal_data[2][1:]
    server = hostmask[hostmask.index('@')+1:]
  elif gatewayService == "minbif":
    channel = signal_data[2]
    server = hostmask[hostmask.index('@')+1:hostmask.find(':', 1)]

  if channel == gatewayChannel and nick == username and nick[0] == '-' and server == facebookhostname:
    nicksToRename.add(nick)
    if gatewayService == "bitlbee":
       weechat.command(weechat.buffer_search("irc", gatewayBuffer), "/whois " + nick)
    elif gatewayService == "minbif":
      weechat.command(weechat.buffer_search("irc", gatewayBuffer), "/wii " + nick)

  return weechat.WEECHAT_RC_OK

def whois_data(data, signal, signal_data):
  realname = signal_data[signal_data.rindex(':')+1:]

  nick_update(realname, signal_data)

  return weechat.WEECHAT_RC_OK

def wii_data(data, signal, signal_data):
  if signal_data.find('Full Name: ') > 0:
    realname = signal_data[signal_data.find('Full Name: ')+11:]

    nick_update(realname, signal_data)

  return weechat.WEECHAT_RC_OK

def nick_update(realname, signal_data):
  nick = signal_data.split()[3]
  bufferPointer = weechat.buffer_search("irc", gatewayBuffer)

  if nick in nicksToRename:
    nicksToRename.remove(nick)

  ircname = re.sub("[^A-Za-z0-9]", "", realname)[:24]
  if ircname != nick:
    while weechat.nicklist_search_nick(bufferPointer, "", ircname):
      if ircname.count("_") > 15:
        weechat.prnt("", "ERROR: You'll have to rename " + nick + "by hand.")
        return weechat.WEECHAT_RC_ERROR
      else:
        if len(ircname) < 24:
          ircname += "_"
        else:
          if ircname.find("_") >= 0:
            ircname = ircname[:ircname.index("_")-1] + "_" * (len(ircname) - ircname.index("_") + 1)
          else:
            ircname = ircname[:len(ircname)-1] + "_"

    if gatewayService == "bitlbee":
      weechat.command(bufferPointer, "/msg %s rename %s %s" % (gatewayChannel, nick, ircname))
      weechat.command(bufferPointer, "/msg %s save" % (gatewayChannel))
    elif gatewayService == "minbif":
      weechat.command(bufferPointer, "/quote svsnick %s %s" % (nick, ircname))

weechat.hook_signal("*,irc_in_join", "message_join", "")
if gatewayService == "bitlbee":
  weechat.hook_signal("*,irc_in_311", "whois_data", "")
elif gatewayService == "minbif":
  weechat.hook_signal("*,irc_in_320", "wii_data", "")
