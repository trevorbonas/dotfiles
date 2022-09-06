export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

export CLICOLOR=1

export LSCOLORS=ExFxBxDxCxegedabagacad

alias ls='ls -GFh'

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
# export PATH

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
# PATH="/usr/local/Cellar/python@3.9/3.9.13_1/bin:${PATH}"
# export PATH

# export PATH="$(brew --prefix bison)/bin:$PATH"

export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

bind '"\e[5C": forward-word'
bind '"\e[5D": backward-word'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'
