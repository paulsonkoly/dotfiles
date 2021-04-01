# Non shell specific setup
# vim:set ft=zsh:

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
#binstubs for rubocop etc
PATH="$HOME/api/bin:$PATH"

# export RUBYOPT='-W:no-deprecated -W:no-experimental'

source $HOME/secrets.zsh
source $HOME/ateam-smart/init.sh code-knights

gitgif() {
  if [[ $# == 1 ]]; then
    filename=`basename $1 .mov`
    ffmpeg -i $1 -vf "scale=min(iw\,600):-1" -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=7 --colors 128 > "$filename.gif"
  else
    echo "No file specified"
  fi
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
