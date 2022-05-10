# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="miloshadzic"
# ZSH_THEME="itchy"
# ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo extract colored-man-pages fzf z.lua zsh-autosuggestions gitfast rsync)

source $ZSH/oh-my-zsh.sh

[ -z "$ZPROFILE_LOADED" ] && source $HOME/.zprofile

# User configuration

#========================
# environment
#========================
export EDITOR='nvim'
export MANPAGER='nvim -R +":set ft=man" -'

export FZF_DEFAULT_COMMAND="fd --exclude={.git,.svn,.idea,.vscode,build} --type f"
export FZF_DEFAULT_OPTS="--height 60% --layout=reverse"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview \"bat --style=numbers --color=always --line-range :500 {}\" --preview-window=right:60%"

#========================
# functions
#========================
function proxy_enable() {
    if [ ${1:-1} -eq 0 ]; then
        unset ALL_PROXY
        unset http_proxy
        unset https_proxy
        unset no_proxy
    else
        export ALL_PROXY=http://$proxy_server:7890
        export http_proxy=$ALL_PROXY
        export https_proxy=$ALL_PROXY
        export no_proxy="localhost,127.0.0.1,193.169.200.80,193.169.200.220,193.169.200.250,$proxy_server"
    fi
}
proxy_enable

function copy()
{
    # if the number of arguments equals 0
    if [ $# -eq 0 ]
    then
        # if there are no arguments, save the folder you are currently in to the clipboard
        pwd | xclip
    else
        # save the number of argument/path to `~/.numToCopy` file.
        echo $# > ~/.numToCopy

        # save all paths to clipboard
        # source: https://stackoverflow.com/a/5265775/9157799
        readlink -f "$@" | xclip
    fi

    # mark that you want to do a copy operation
    echo "copy" > ~/.copyOrCut
}

function paste()
{
    # for every path
    for number in {1..$(cat ~/.numToCopy)}
    do
        # get the nth path
        pathToCopy="$(xclip -o | head -$number | tail -1)"

        if [ -d "$pathToCopy" ] # If it's a directory
        then
            cp -r "$pathToCopy" .
        else
            cp "$pathToCopy" .
        fi

        # if it was marked as a cut operation
        if [ $(cat ~/.copyOrCut) = "cut" ]
        then
            # delete the original file
            rm -rf "$pathToCopy"
        fi
    done
}

function grbf()
{
    if [ $# -eq 0 ]; then
        echo "Usage: grbf [branch]"
        echo "git rebase from branch"
        return 1
    fi
    git stash && git rebase $1 && git stash pop
}

function grbt()
{
    if [ $# -eq 0 ]; then
        echo "Usage: grbt [branch]"
        echo "git rebase to branch"
        return 1
    fi
    now=$(git branch --show-current)
    git stash && git checkout $1 && git rebase $now && git checkout - && git stash pop
}


#========================
# alias
#========================
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias vi=nvim
alias vim=nvim
alias p4=proxychains4
alias xo="xdg-open"
alias ys="yay -Sy"
alias tp="$HOME/scripts/tp/template/install.sh"
alias vimf='vim $(fzf)'
alias ide='cd; ta'
if [ -n "${WSLENV}" ]; then
    alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
else
    alias tmux='env TERM=screen-256color tmux'
fi
alias ta="tmux attach || tmux"
alias zz='z -c' # 严格匹配当前路径的子路径
alias zi='z -i' # 使用交互式选择模式
alias zf='z -I' # 使用 fzf 对多个结果进行选择
alias zb='z -b' # 快速回到父目录
alias zh='z -I -t .' # fzf选择历史路径

alias cmakeg="[ -f CMakeLists.txt ] && ln -sf build/compile_commands.json ./;\
    cmake -S. -Bbuild -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release"
alias cmakegd="[ -f CMakeLists.txt ] && ln -sf build/compile_commands.json ./;\
    cmake -S. -Bbuild -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug"
alias cmakeb="cmake --build build"
alias cmaker="cmake --build build --target run"
alias cmaket="(cmakeb && cd build && env CTEST_OUTPUT_ON_FAILURE=1 ctest && ctest -T memcheck)"
alias leakcheck="valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes"

alias docui="docker run --rm -itv /var/run/docker.sock:/var/run/docker.sock skanehira/docui"
alias dps='docker ps --format="table {{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'

alias ctagg='ctags -R -f .tags'
alias usbip=/usr/lib/linux-tools/5.4.0-77-generic/usbip
alias pip='DISPLAY= pip'
alias pip3='DISPLAY= pip3'

#========================
# keybinding
#========================
bindkey '^ ' autosuggest-accept

#========================
# zsh option
#========================
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
