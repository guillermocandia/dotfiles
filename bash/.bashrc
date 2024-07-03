[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
HISTSIZE=5000
HISTFILESIZE=5000
HISTTIMEFORMAT="%F %T " # TODO: format

shopt -s histappend
shopt -s checkwinsize

# TODO: make this work with alacritty
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

PS1='\[\033[01;31m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' # TODO: add git info

# xmonad + java TODO: maybe its not necesary anymore
AWT_TOOLKIT=MToolkit
export AWT_TOOLKIT=MToolkit
_JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING

alias xterm='xterm -vb'
alias kubectl="kubecolor"
alias ssh="env TERM=xterm-256color ssh"

export PATH=$HOME/bin:$PATH
. "$HOME/.cargo/env"
