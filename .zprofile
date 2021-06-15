export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

if [ -z "$WSL_DISTRO_NAME" ]; then
    export proxy_server="127.0.0.1"
else
    if cat /proc/version | grep microsoft &>/dev/null; then
        export wsl_version=2
        proxy_server="$(cat /etc/resolv.conf | grep nameserver | cut -d' ' -f2)"
    else
        export wsl_version=1
        export proxy_server="127.0.0.1"
    fi
    export DISPLAY=$proxy_server:0
    #export LIBGL_ALWAYS_INDIRECT=1
    # hidpi
    export GDK_SCALE=2
    export QT_SCALE_FACTOR=2
    export XCURSOR_SIZE=64

    # im
    export QT_IM_MODULE=fcitx
    export GTK_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMModule=fcitx
fi
