# Starts dunst with wal colours

. $HOME/.cache/wal/colors.sh

pkill dunst

exec dunst \
  -lb "${color0:-#FFFFFF}" \
  -nb "${color0:-#FFFFFF}" \
  -cb "${color0:-#FFFFFF}" \
  -lf "${color8:-#000000}" \
  -nf "${color8:-#000000}" \
  -cf "#e27878" \
  -lfr "${color0:-#800000}" \
  -nfr "${color0:-#800000}" \
  -cfr "${color0:-#800000}"
