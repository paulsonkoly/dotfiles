# Non shell specific setup
# vim:set ft=zsh:

source $HOME/.cache/wal/colors.sh
unset FZF_DEFAULT_OPTS # I like original don't need to alter fzf colours

PATH=$HOME/bin:$HOME/.local/bin:$HOME/.npm-packages/bin:$PATH

#ruby stuff
PATH=`ruby -e 'puts File.join(Gem.user_dir, "bin")'`:$PATH

# haskell stuff
PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

export PATH

export TERMINAL=termite

export POLYBAR_RAMP_0="%{F${color8}}━━━━━━━%{F-}"
export POLYBAR_RAMP_1="━%{F${color8}}━━━━━━%{F-}"
export POLYBAR_RAMP_2="━━%{F${color8}}━━━━━%{F-}"
export POLYBAR_RAMP_3="━━━%{F${color8}}━━━━%{F-}"
export POLYBAR_RAMP_4="━━━━%{F${color8}}━━━%{F-}"
export POLYBAR_RAMP_5="━━━━━%{F${color8}}━━%{F-}"
export POLYBAR_RAMP_6="━━━━━━%{F${color8}}━%{F-}"
export POLYBAR_RAMP_7="━━━━━━━"

export NNN_COPIER=$HOME/bin/nnn_copier.sh

source /usr/share/chruby/chruby.sh
export RUBIES=($HOME/.rubies/*)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# colour man pages (https://wiki.archlinux.org/index.php/Color_output_in_console)
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# multi select fzf for package names
# use $ pacman **<Tab> to trigger
_fzf_complete_yay() {
  _fzf_complete '-m' "$@" < <(
  command yay -Pc | cut -f1 -d' '
  )
}

_fzf_complete_yay_post() {
  awk '{print $1}'
}

