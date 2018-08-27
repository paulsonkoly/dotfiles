#
# ~/.bash_profile
#

source $HOME/.cache/wal/colors.sh
unset FZF_DEFAULT_OPTS # I like original don't need to alter fzf colours

# bundle is before gem, so it has priority
export PATH=$PATH:$HOME/.gem/ruby/2.5.0/bin/:$HOME/bin:$HOME/.local/bin
export TERMINAL=termite
export POLYBAR_RAMP_0="%{F${color8}}━━━━━━━%{F-}"
export POLYBAR_RAMP_1="━%{F${color8}}━━━━━━%{F-}"
export POLYBAR_RAMP_2="━━%{F${color8}}━━━━━%{F-}"
export POLYBAR_RAMP_3="━━━%{F${color8}}━━━━%{F-}"
export POLYBAR_RAMP_4="━━━━%{F${color8}}━━━%{F-}"
export POLYBAR_RAMP_5="━━━━━%{F${color8}}━━%{F-}"
export POLYBAR_RAMP_6="━━━━━━%{F${color8}}━%{F-}"
export POLYBAR_RAMP_7="━━━━━━━"
[[ -f ~/.bashrc ]] && . ~/.bashrc
