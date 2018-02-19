#
# ~/.bash_profile
#

# bundle is before gem, so it has priority
export PATH=$PATH:$HOME/.gem/ruby/2.5.0/bin/:$HOME/bin
export TERMINAL=termite
[[ -f ~/.bashrc ]] && . ~/.bashrc
