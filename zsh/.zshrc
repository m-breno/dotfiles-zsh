source $ZDOTDIR/.zshenv

###############
### Plugins ###
###############

# where do you want to store your plugins?
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# get zsh_unplugged and store it with your other plugins
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# make list of the Zsh plugins you use
repos=(
  # plugins that you want loaded first
  #sindresorhus/pure

  # other plugins
  zsh-users/zsh-completions
  #rupa/z
  # ...

  # plugins you want loaded last
  zsh-users/zsh-autosuggestions
  Aloxaf/fzf-tab
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
)

# now load your plugins
plugin-load $repos

##############
### Prompt ###
##############

## Enable bottom prompt
printf "\e[H\ec\e[${LINES}B"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

###############
### History ###
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

autoload -Uz compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
#zstyle ':completion:*' fzf-completion-opts --layout=reverse

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
#zstyle ':fzf-tab:*' fzf-flags --layout=default

#########################
### Other Connections ###
#########################

# fzf
source <(fzf --zsh)

# zoxide
eval "$(zoxide init --cmd "cd" zsh)"

upd() {
    function plugin_update {
    ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
    for d in $ZPLUGINDIR/*/.git(/); do
        echo -e "\033[1mUpdating ${d:h:t}...\033[0m"
        command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
    done
    }

    echo -e '\033[1m:: Updating zsh plugins...\033[0m\n'
    plugin_update

    echo -e '\n\033[1m:: Updating pacman/AUR packages...\033[0m\n'
    yay -Syu
}

###############
### Aliases ###
###############

alias n="nvim"

## files
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

#
alias mv="mv -vi"
alias mvr="mv -r"

alias cp="cp -vi"
alias cpr="cp -r"

alias rm="tr"
#alias rm="rm -vI"
alias rmr="rm -rf"

## Others
#
#
unset ZSH_AUTOSUGGEST_USE_ASYNC
