if type "sway" >/dev/null 2>&1; then
    if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
        XKB_DEFAULT_LAYOUT=us exec sway -d >$HOME/sway.log 2>&1
    fi
fi
