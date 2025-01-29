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
#export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# Cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# Go
export GOPATH="$XDG_DATA_HOME"/go

# ICEautorithy
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority

# MyPy
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy

# NPM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

# adb
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# PATH
export PATH=$PATH:$HOME/.local/bin:$GOPATH/bin

# Wine
export WINEPREFIX="$XDG_DATA_HOME"/wine
