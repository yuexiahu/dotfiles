#!/bin/bash

cd $(dirname $0)

if [ ! -d ~/.oh-my-zsh ]; then
    echo "Install oh-my-zsh first!"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

git clone https://github.com/skywind3000/z.lua ${ZSH_CUSTOM}/plugins/z.lua
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

ln -sf $PWD/.zshrc ~/
ln -sf $PWD/.tmux.conf ~/
ln -sf $PWD/.clang-format ~/

# tmux italic support
tic res/screen-256color.terminfo

# konsole colorscheme
if [ -d ~/.local/share/konsole ];then
    cp -f res/Monokai.colorscheme ~/.local/share/konsole/
fi

# wsl config
if [ ! -z "$WSLENV" ]; then
    sudo cp -f res/wsl.conf /etc/
fi

