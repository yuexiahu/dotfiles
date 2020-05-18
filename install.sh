#!/bin/bash

cd $(dirname $0)

if [ ! -d ~/.oh-my-zsh ]; then
    echo "Install oh-my-zsh first!"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

git clone https://github.com/skywind3000/z.lua ~/.oh-my-zsh/custom/plugins/z.lua

ln -sf $PWD/.zshrc ~/
ln -sf $PWD/.tmux.conf ~/

