# /etc/skel/.bash_profile
#eval $(keychain --eval id_rsa 36C8AAA9)
eval $(keychain --eval id_rsa)

if [[ -n "$DISPLAY" ]] && [[ $(tty) != /dev/tty1 ]]; then
  [[ -f ~/.bashrc ]] && . ~/.bashrc
	synergys &
  alias starcraft='sudo umount /mnt/cdrom > /dev/null & sudo mount -o loop .wine/drive_c/Starcraft/isos/starcraft.iso /mnt/cdrom && wine .wine/drive_c/Starcraft/StarCraft.exe'
  alias broodwar='sudo umount /mnt/cdrom > /dev/null & sudo mount -o loop .wine/drive_c/Starcraft/isos/broodwar.iso /mnt/cdrom && wine .wine/drive_c/Starcraft/StarCraft.exe'
  alias fallout='cd ~/.wine/drive_c/Program\ Files/Interplay/Fallout/ && wine ./falloutw.exe'
  alias doom='lsdldoom -width 1280 -height 800 -iwad doom'
  alias todo='~/scripts/todo.sh'
  alias pw="gpg --decrypt ~/.pw.gpg"
  alias lslogin="sh ~/scripts/lslogin.sh"
  alias twitter="sh ~/scripts/bashtc.sh"
  alias pywifi="python ~/scripts/pywifi.py"
	alias workbw="ssh root@31.3.3.1 sh /jffs/updatebwlog.sh"
  export XDG_DATA_HOME=~/.local/share/
  xbindkeys
fi
