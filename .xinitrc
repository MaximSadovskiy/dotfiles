#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

feh --bg-scale ~/Wallpapers/26-\(evfsqjpqdfantikrsurddkmltalhorkg\).png
xset led 3

dwmblocks &
xcompmgr &
#picom &
exec dwm
