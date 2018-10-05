cat $HOME/.cache/wal/sequences

set -x PATH $PATH $HOME/.gem/ruby/2.5.0/bin/ $HOME/bin $HOME/.local/bin

# starts with color0
set color8 (sed -n '9p' < $HOME/.cache/wal/colors)

set -x TERMINAL termite
set -x POLYBAR_RAMP_0 \%\{F"$color8"\}━━━━━━━\%\{F-\}
set -x POLYBAR_RAMP_1 ━\%\{F"$color8"\}━━━━━━\%\{F-\}
set -x POLYBAR_RAMP_2 ━━\%\{F"$color8"\}━━━━━\%\{F-\}
set -x POLYBAR_RAMP_3 ━━━\%\{F"$color8"\}━━━━\%\{F-\}
set -x POLYBAR_RAMP_4 ━━━━\%\{F"$color8"\}━━━\%\{F-\}
set -x POLYBAR_RAMP_5 ━━━━━\%\{F"$color8"\}━━\%\{F-\}
set -x POLYBAR_RAMP_6 ━━━━━━\%\{F"$color8"\}━\%\{F-\}
set -x POLYBAR_RAMP_7 ━━━━━━━
