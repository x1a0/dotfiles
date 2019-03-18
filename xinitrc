# setup dual monitor
xrandr \
    --output DP-1 --primary --mode 2560x1440 --rotate normal \
    --output HDMI-0 --mode 1920x1080 --rotate left --left-of DP-1

xrdb -load $HOME/.Xresources

# for IntelliJ-IDEA
export _JAVA_AWT_WM_NONREPARENTING=1

dbus-run-session bspwm
