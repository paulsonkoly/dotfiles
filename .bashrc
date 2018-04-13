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

# multi select fzf for package names
# use $ pacman **<Tab> to trigger
_fzf_complete_pacman() {
  _fzf_complete '-m' "$@" < <(
  command yay -Pc
  )
}
complete -F _fzf_complete_pacman -o default -o bashdefault pacman
complete -F _fzf_complete_pacman -o default -o bashdefault yay

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
