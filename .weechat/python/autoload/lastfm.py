#!/usr/bin/python
"""
  lastfm.py

  :What it does: 
    This script informs the active window of your last
    submitted song at last.fm

  :Usage:
    /np - Displays your last submitted song.

  :Configuration Variables:
    ============= ==========================================
    Variable name Meaning
    ============= ==========================================
    lastfmuser    Your username at last.fm
 
  :Credits:
    Rewrite of Tim Schumacher's plugin to work with weechat 0.3
    By Lance Vick (lance@lrvick.net) and Titus Soporan (tsopor@gmail.com)

  :License:
    Released under GPL licence.
"""

lastfmuser = "lrvick"

import urllib
import weechat

weechat.register('lastfmp', 'lrvick and tsoporan', '1.0', 'GPL3', 'now playing for last.fm', '', '')

def getLastSong(*args, **kwargs):
    """ 
    Provides your last submitted song in last.fm to the actual context
    """
    user = lastfmuser
    url = "http://ws.audioscrobbler.com/1.0/user/" + user + "/recenttracks.txt"
    url_handle = urllib.urlopen(url)
    lines = url_handle.readlines()
    song = lines[0].split(",")[1].replace("\n","").replace('\xe2\x80\x93', '-')
    if song == '':
        song = 'nothing :-)';
    weechat.command(args[1], "/me is listening to \"%s\"" % (song,))
    return weechat.WEECHAT_RC_OK


weechat.hook_command("np", "", "", "", "", "getLastSong", "")

