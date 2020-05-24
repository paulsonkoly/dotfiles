# Non shell specific setup
# vim:set ft=zsh:

# haskell stuff
PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

export PATH

export TERMINAL=termite
export EDITOR=nvim

export POLYBAR_RAMP_0="%{F${color8}}━━━━━━━%{F-}"
export POLYBAR_RAMP_1="━%{F${color8}}━━━━━━%{F-}"
export POLYBAR_RAMP_2="━━%{F${color8}}━━━━━%{F-}"
export POLYBAR_RAMP_3="━━━%{F${color8}}━━━━%{F-}"
export POLYBAR_RAMP_4="━━━━%{F${color8}}━━━%{F-}"
export POLYBAR_RAMP_5="━━━━━%{F${color8}}━━%{F-}"
export POLYBAR_RAMP_6="━━━━━━%{F${color8}}━%{F-}"
export POLYBAR_RAMP_7="━━━━━━━"

export NNN_COPIER=$HOME/bin/nnn_copier.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim=nvim

# colour man pages (https://wiki.archlinux.org/index.php/Color_output_in_console)
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;03;33m' \
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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
