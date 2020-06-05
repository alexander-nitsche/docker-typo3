# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# {user}@{host}:{working dir}
PS1='\u@\h:\w \$ '

# enable color support of ls
alias ls='ls --color=auto'
