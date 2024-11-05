###############
### Plugins ###
###############

autoload -Uz compinit && compinit # line 133

ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# get zsh_unplugged and store it with your other plugins
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# make list of the Zsh plugins you use
repos=(
  zsh-users/zsh-completions

  ohmyzsh/git # manual: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git/git.plugin.zsh
  zsh-users/zsh-autosuggestions
  #Aloxaf/fzf-tab
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  archwiki/zsh-window-title # manual: https://wiki.archlinux.org/title/Zsh#xterm_title
)

# now load your plugins
plugin-load $repos


###################
### Environment ###
###################

export PATH=$PATH:$HOME/.local/bin:$HOME/.spicetify

## Default apps
#export TERM=kitty
export EDITOR=nvim
export VISUAL=$EDITOR

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

export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:'

export BAT_THEME=base16

##############
### PROMPT ###
##############

printf "\e[H\ec\e[${LINES}B"

autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' formats ' %F{green}%b%f)'

precmd () { print }

PS1='%F{9}%n%f@%F{3}%m%f %F{4}%B%1~%b%f > '
RPROMPT="%(?..%F{1}[%?]%f)%(1j.%F{4} [%j]%f.) %F{8}%T%f"


###############
### HISTORY ###
###############

HISTSIZE=1000
HISTFILE=$XDG_STATE_HOME/zsh-history
SAVEHIST=$HISTSIZE
HISTDUP=erase
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


###################
### Keybindings ###
###################

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


##################
### Completion ###
##################

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

###

###############
### Aliases ###
###############

# zoxide
eval "$(zoxide init --cmd "cd" zsh)"

upd() {
  function plugin_update {
    ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
    for d in $ZPLUGINDIR/*/.git(/); do
      #echo -e "\033[3mUpdating ${d:h:t}...\033[0m"
      echo -e "\033[3mAtualizando ${d:h:t}...\033[0m"
      command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
    done
  }

  #echo -e '\033[1m\033[34m::\033[0m\033[1m Updating ZSH plugins...\033[0m'
  echo -e '\033[1m\033[34m::\033[0m\033[1m Atualizando plugins ZSH...\033[0m'
  plugin_update

  #echo -e '\033[1m\033[34m::\033[0m\033[1m Updating pacman/AUR packages...\033[0m'
  echo -e '\033[1m\033[34m::\033[0m\033[1m Atualizando pacotes pacman/AUR...\033[0m'
  yay -Syu --noconfirm
  }

alias n="nvim"

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

#export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

mkcd() {
  mkdir $@
  cd $@
}

## files
alias mkdir="mkdir -pv"
alias md="mkdir"
alias mcl="mkcd && ls"
alias cdls="cd && ls"
alias cdl="cdls"

alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias mv="mv -v"

alias cp="cp -vr"

alias rm="tr"
#alias rm="rm -vI"
alias rmr="rm -rf"

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

# trash
alias tr="trash"
alias tl="trash-list"
alias trm="trash-remove"
alias tre="trash-restore"
alias te="trash-empty"

## Colors
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'

## xdg
alias adb='HOME="$XDG_DATA_HOME"/android adb'

## Others

#unset ZSH_AUTOSUGGEST_USE_ASYNC
#DISABLE_AUTO_TITLE="false"
