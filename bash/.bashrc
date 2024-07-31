case $- in
*i*) ;;
*) return ;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000
HISTTIMEFORMAT="%Y%m%d %T "

shopt -s histappend
shopt -s checkwinsize
shopt -s dotglob

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls="ls --color=auto"
	alias grep="grep --color=auto"
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi
if [ -f ~/.kube/completion.bash.inc ]; then
	. ~/.kube/completion.bash.inc
fi

git_branch() {
	if [ -d .git ]; then
		echo "($(git branch | cut -d " " -f 2)) "
	fi
}

TITLE="\[\e]0;\w\a\]"
GIT='\[\033[01;36m\]$(git_branch)'
MAIN="\[\033[01;34m\][\w]\[\033[00m\] $ "
PS1=$TITLE$GIT$MAIN

alias xterm="xterm -vb"
alias kubectl="kubecolor"
alias ssh="env TERM=xterm-256color ssh"

if $PATH_CONFIGURED; then
	return
fi

export PATH=~/bin:~/.local/bin:~/.cargo/bin:$PATH

[ -f "~/.ghcup/env" ] && . "/.ghcup/env" # ghcup-env
