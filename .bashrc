#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

source /usr/share/fzf/completion.bash
(cat ~/.cache/wal/sequences &)
complete -F _fzf_path_completion -o default -o bashdefault vlc
