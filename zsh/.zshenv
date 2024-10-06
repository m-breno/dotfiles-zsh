###################
### Environment ###
###################

export PATH=$PATH:$HOME/.local/bin

## Default apps
#export TERM=kitty
export EDITOR=nvim
export VISUAL=$EDITOR

export MANPAGER='nvim +Man!'

# Bitwarden session
export BW_SESSION="3tZkGCUyEeAeA44iLFUYPgVT31rMHa59u53xb1A1pQniOeaU9m3ZNtVz+BPlaLbx8N1akCfeded8S2UV/Bv3KA=="

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

# Android
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android

# Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Python
export PYTHONSTARTUP="$HOME"/python/pythonrc

export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority

