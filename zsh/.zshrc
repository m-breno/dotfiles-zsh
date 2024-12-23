#  _______ _  _ 
# |_  / __| || |
#  / /\__ \ __ |
# /___|___/_||_|
# config by m-breno

autoload -Uz compinit && compinit # line 164

#          __          _        
#    ___  / /_ _____ _(_)__  ___
#   / _ \/ / // / _ `/ / _ \(_-<
#  / .__/_/\_,_/\_, /_/_//_/___/
# /_/          /___/            

ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# get zsh_unplugged and store it with other plugins
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

repos=(
	romkatv/zsh-defer
  zsh-users/zsh-completions

  zsh-users/zsh-autosuggestions
  #Aloxaf/fzf-tab
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search

  ohmyzsh/git # manual: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git/git.plugin.zsh
  archwiki/zsh-window-title # manual: https://wiki.archlinux.org/title/Zsh#xterm_title
	archwiki/zsh-rehash-pacman-hook # manual: https://wiki.archlinux.org/title/Zsh#On-demand_rehash
	archwiki/zsh-pacman-cnf-handler # manual: https://wiki.archlinux.org/title/Zsh#pacman_-F_%22command_not_found%22_handler
)

# now load your plugins
plugin-load $repos
              
#  ___ ___ _  __
# / -_) _ \ |/ /
# \__/_//_/___/ 

## Default apps
#export TERM=kitty
export PAGER=bat
export EDITOR=nvim
export VISUAL=$EDITOR

# bat theme
export BAT_THEME=base16

## XDG default dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

## XDG-compliant home
# GTK-2
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# Terminfo
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo

# adb
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android

# Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Python
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc

# GnuPG
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# Cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# Go
export GOPATH="$XDG_DATA_HOME"/go

# ICEautorithy
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority

# MyPy
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy

# ZCompDump
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc 

# adb
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# PATH
export PATH=$PATH:$HOME/.local/bin:$GOPATH/bin

#                              __ 
#    ___  _______  __ _  ___  / /_
#   / _ \/ __/ _ \/  ' \/ _ \/ __/
#  / .__/_/  \___/_/_/_/ .__/\__/ 
# /_/                 /_/         

printf "\e[H\ec\e[${LINES}B"

autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' formats ' %F{green}%b%f)'

precmd () { print }

PS1='%F{1}%n%f@%F{3}%m%f %F{4}%B%1~%b%f > '
RPROMPT="%(?..%F{1}[%?]%f)%(1j.%F{4} [%j]%f.) %F{8}%T%f"

#    __   _     __               
#   / /  (_)__ / /____  ______ __
#  / _ \/ (_-</ __/ _ \/ __/ // /
# /_//_/_/___/\__/\___/_/  \_, / 
#                         /___/  

HISTSIZE=1000
HISTFILE=$XDG_CACHE_HOME/zsh/history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extendedglob
setopt auto_cd

autoload -U select-word-style
select-word-style bash

#    __              
#   / /_____ __ _____
#  /  '_/ -_) // (_-<
# /_/\_\\__/\_, /___/
#          /___/     

bindkey -e

bindkey "^[[1;5C"   forward-word
bindkey "^[[1;5D"   backward-word
bindkey "^H"        backward-kill-word
bindkey "^[[3;5~"   kill-word
bindkey "^[[H"      beginning-of-line
bindkey "^[[F"      end-of-line
bindkey "^[[3~"     delete-char
bindkey '^[[A'      history-substring-search-up
bindkey '^[[B'      history-substring-search-down

cl() { printf "\e[H\ec\e[${LINES}B"; zle .reset-prompt }
zle -N cl
bindkey '^L' cl

#                       __    __  _         
#  _______  __ _  ___  / /__ / /_(_)__  ___ 
# / __/ _ \/  ' \/ _ \/ / -_) __/ / _ \/ _ \
# \__/\___/_/_/_/ .__/_/\__/\__/_/\___/_//_/
#              /_/                          

#autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
#zstyle ':completion::complete:*' gain-privileges 1
zmodload zsh/complist

bindkey -M menuselect '^[[Z' reverse-menu-complete
###
# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*'       insert-unambiguous true
zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:correct:*'       original true

# activate color-completion
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

# format on completion
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

# match uppercase from lowercase
zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

# separate matches into groups
zstyle ':completion:*:matches'         group 'yes'
zstyle ':completion:*'                 group-name ''

if [[ "$NOMENU" -eq 0 ]] ; then
  # if there are more than 5 options allow selecting from a menu
  zstyle ':completion:*'               menu select=5
else
  # don't use any menus at all
  setopt no_auto_menu
fi

zstyle ':completion:*:messages'        format '%d'
zstyle ':completion:*:options'         auto-description '%d'

# describe options in full
zstyle ':completion:*:options'         description 'yes'

# on processes completion complete all user processes
zstyle ':completion:*:processes'       command 'ps -au$USER'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# provide verbose completion information
zstyle ':completion:*'                 verbose true

# recent (as of Dec 2007) zsh versions are able to provide descriptions
# for commands (read: 1st word in the line) that it will list for the user
# to choose from. The following disables that, because it's not exactly fast.
zstyle ':completion:*:-command-:*:'    verbose false

# set format for warnings
zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'          prompt 'correct to: %e'

# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
#zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

#        ___                
#  ___ _/ (_)__ ____ ___ ___
# / _ `/ / / _ `(_-</ -_|_-<
# \_,_/_/_/\_,_/___/\__/___/

alias sudo="sudo "
alias s="sudo"
alias se="sudoedit"
alias sctl="systemctl"
alias q="exit"
alias h="history"

alias n="nvim"
alias p="python"
alias minecraft="java -jar ~/.local/share/tl.jar &> /dev/null"
alias wttr="curl https://wttr.in/Ilhabela"

# Pacman
alias pS="sudo pacman -Syu"
alias pSs="sudo pacman -Ss"
alias pR="sudo pacman -R"
alias pRns="sudo pacman -Rns"
alias pQ="pacman -Q"
# yay
alias yS="yay -S"
alias ySs="yay -Ss"
alias yR="yay -R"
alias yRns="yay -Rns"
alias yQ="yay -Q"

# dotfiles
alias zshrc="n $XDG_CONFIG_HOME/zsh/.zshrc"
alias zshd="n $XDG_CONFIG_HOME/zsh/"
alias nvimd="n $XDG_CONFIG_HOME/nvim/"
alias qtilerc="n $XDG_CONFIG_HOME/qtile/config.py"
alias footrc="n $XDG_CONFIG_HOME/foot/foot.ini"
alias hyprrc="n $XDG_CONFIG_HOME/hypr/hyprland.conf"
alias hyprd="n $XDG_CONFIG_HOME/hypr"

# ls
alias ls="eza --icons --color --group-directories-first"
alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias lla="ll -a"
alias lr="ls -r"
alias lar="la -r"
alias llr="ll -r"
alias llar="lla -r"

# zoxide/cd
eval "$(zoxide init --cmd "cd" zsh)"

cdls() {
  cd $@
	ls
}
alias cdl="cdls"

# mkdir
alias mkdir="mkdir -pv"
alias md="mkdir"

mkcd() {
  mkdir $@
  cd $@
}
alias mcl="mkcd && ls"

alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias mv="mv -v"

alias cp="cp -rv"

# trash/rm
alias tr="trash -v"
alias tl="trash-list"
alias trm="trash-remove"
alias tre="trash-restore"
alias te="trash-empty"

alias rm="tr"
#alias rm="rm -vI"
alias rmr="rm -rfv"

# Clipboard
alias clip="wl-copy"
alias clipp="wl-paste"

# Bat
# Pretty git diff
batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

# Pretty --help
help() {
    "$@" --help 2>&1 | bat --plain --language=help
}
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Use bat as man pager
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#MANROFFOPT="-c"
alias man=batman

# Update
upd() {
  function plugin_update {
    ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
    for d in $ZPLUGINDIR/*/.git(/); do
      #echo -e "\033[3mUpdating ${d:h:t}...\033[0m"
      echo -e "  \033[3mAtualizando ${d:h:t}...\033[0m"
      command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash 2&>/dev/null
    done
  }

  #echo -e '\033[1m\033[34m::\033[0m\033[1m Updating ZSH plugins...\033[0m'
  echo -e '\033[1m\033[34m::\033[0m\033[1m Atualizando plugins ZSH...\033[0m'
  plugin_update

  #echo -e '\033[1m\033[34m::\033[0m\033[1m Updating pacman/AUR packages...\033[0m'
  echo -e '\033[1m\033[34m::\033[0m\033[1m Atualizando pacotes pacman/AUR...\033[0m'
  yay -Syu --noconfirm
}

# Colors
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
