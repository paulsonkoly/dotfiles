# Starts dunst with wal colours

. $HOME/.cache/wal/colors.sh

pkill dunst

exec dunst \
  -lb "${color0:-#FFFFFF}" \
  -nb "${color0:-#FFFFFF}" \
  -cb "${color0:-#FFFFFF}" \
  -lf "${color8:-#000000}" \
  -nf "${color8:-#000000}" \
  -cf "${color3:-#000000}" \
  -lfr "${color2:-#800000}" \
  -nfr "${color2:-#800000}" \
  -cfr "${color2:-#800000}"
