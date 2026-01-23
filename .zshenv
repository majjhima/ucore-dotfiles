#
# .zshenv is sourced on all invocations of the shell.
# It should contain commands to set the command search path,
# plus other important environment variables.
# .zshenv should not contain commands that produce output
# or assume the shell is attached to a tty.
#

umask 002

export RSYNC_RSH=ssh
export CVS_RSH=ssh
export PAGER='less'
export LESS='-FeRnSX'
export WORDCHARS='*?_-.,[]~&;:!#$%^(){}<>\'
export LANG=en_US.utf8
export TERM=xterm-256color
export NO_AT_BRIDGE=1

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

for zshenv in $HOME/.zshenv-*(N) ; do
    source $zshenv
done

# Cache our active SSH_AUTH_SOCK as a symlink.
# This is particularly useful from a long-running tmux window.
if [[ -S "$SSH_AUTH_SOCK" && ! -L "$SSH_AUTH_SOCK" ]]
then
    ln -sf $SSH_AUTH_SOCK $HOME/.ssh/.ssh-agent-socket
fi
if [[ -S $(readlink $HOME/.ssh/.ssh-agent-socket) ]]
then
    export SSH_AUTH_SOCK=$HOME/.ssh/.ssh-agent-socket
fi
