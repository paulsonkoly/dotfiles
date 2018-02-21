#
# ~/.bash_profile
#

# bundle is before gem, so it has priority
export PATH=$PATH:$HOME/.gem/ruby/2.5.0/bin/:$HOME/bin
export TERMINAL=termite
export POLYBAR_RAMP_0="%{F`xgetres color3`}━━━━━━━%{F-}"
export POLYBAR_RAMP_1="━%{F`xgetres color3`}━━━━━━%{F-}"
export POLYBAR_RAMP_2="━━%{F`xgetres color3`}━━━━━%{F-}"
export POLYBAR_RAMP_3="━━━%{F`xgetres color3`}━━━━%{F-}"
export POLYBAR_RAMP_4="━━━━%{F`xgetres color3`}━━━%{F-}"
export POLYBAR_RAMP_5="━━━━━%{F`xgetres color3`}━━%{F-}"
export POLYBAR_RAMP_6="━━━━━━%{F`xgetres color3`}━%{F-}"
export POLYBAR_RAMP_7="━━━━━━━"
[[ -f ~/.bashrc ]] && . ~/.bashrc
