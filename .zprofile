if [ -n "$ZPROFILE_LOADED" ]; then
    return
fi

export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/toolkit/qtcreator/bin:$PATH"
export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"

if [ -z "$WSL_DISTRO_NAME" ]; then
    export proxy_server="127.0.0.1"
else
    if cat /proc/version | grep microsoft &>/dev/null; then
        export wsl_version=2
        export proxy_server="$(cat /etc/resolv.conf | grep nameserver | cut -d' ' -f2)"
    else
        export wsl_version=1
        export proxy_server="127.0.0.1"
    fi
    # X11 TCP Server
    # export DISPLAY=$proxy_server:0
    # hyperV VSOCK
    export DISPLAY=:0.0
    #export LIBGL_ALWAYS_INDIRECT=1
    # hidpi
    # export GDK_SCALE=2
    # export QT_SCALE_FACTOR=2
    # export XCURSOR_SIZE=64

    # im
    export QT_IM_MODULE=fcitx
    export GTK_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMModule=fcitx
fi

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
source $HOME/.cargo/env

# export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin"
# export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
# export HOMEBREW_CELLAR=/home/linuxbrew/.linuxbrew/Cellar
# export HOMEBREW_REPOSITORY=/home/linuxbrew/.linuxbrew/Homebrew

export GOPROXY=https://goproxy.cn
export ALL_PROXY=http://$proxy_server:7890
export http_proxy=$ALL_PROXY
export https_proxy=$ALL_PROXY
export no_proxy="localhost,127.0.0.1,192.168.129.220,193.169.200.200,$proxy_server"
export ZPROFILE_LOADED=1
