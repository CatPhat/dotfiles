#Adjust keyboard typematic delay and rate
xset r rate 270 30

#For macbook keyboards
setxkbmap -option "apple:alupckeys"
#loadkeys mac-us
setxkbmap -layout us,lt
setxkbmap -option 'grp:alt_shift_toggle'# Merge & load configuration from .Xresources

xrdb -merge ~/.Xresources

#start Xorg server at this DPI
#xrandr --setprovideroffloadsink radeon
xrandr --output "eDP" --set "scaling mode" "Full"
xrandr --dpi 227

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=0.5
export QT_SCREEN_SCALE_FACTORS=2

#VA-API AMD
export LIBVA_DRIVER_NAME=radeonsi



xbindkeys
~/.fehbg &
exec dbus-launch i3
#exec i3
