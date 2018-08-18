export TERM="screen-256color"
export PATH="$HOME/.local/bin:$HOME/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

autoload -U colors && colors

##
# Antigen
##

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  source $HOME/antigen.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  source $(brew --prefix)/share/antigen/antigen.zsh
fi

# Geneal Plugins
antigen bundle git
antigen bundle jsontools
antigen bundle autojump
antigen bundle compleat
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-autosuggestions

# Node Plugins
antigen bundle npm

# Docker Plugins
antigen bundle docker
antigen bundle docker-compose

# Theme
antigen bundle mafredri/zsh-async
antigen bundle achannarasappa/pure

antigen apply

##
# Language
##

# Go
export GOROOT="/usr/local/go"
export GOPATH="$HOME/repositories/go"
export PATH="$PATH:$GOROOT/bin"
 
##
# Keybindings
##
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

##
# Completion
##
autoload -U compinit
compinit
zmodload -i zsh/complist
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt correct                  # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
zstyle ':completion:*' menu select=2                        # menu if nb items > 2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

##
# Integration
##

##
# Aliases
##

# General
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias copy='xclip -sel clip'
  alias paste='xclip -o -sel clip'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias copy='pbcopy'
  alias paste='pbpaste'
fi
alias dir='echo "${PWD##*/}"'
alias e='code'

# jq
jq_flatten_json_files(){
  find . -name '*.json' -exec cat '{}' + | jq -s '. | flatten' "$@"
}

# Code
alias code="code --user-data-dir $HOME/.config/Code/"

# Docker
alias d='docker'
alias dc='docker-compose'
alias db='docker build -t "${PWD##*/}" $@ .'
alias dr='docker run --rm -p 8080:80 -P -it --name "${PWD##*/}" $@ "${PWD##*/}"'

# Git
alias gi='git update-index --assume-unchanged $1'

# Productivity
alias watch='git ls-files | entr $@'

# Network
alias process_port='netstat -tulpn | grep $1'

# Applications
alias chrome=/opt/google/chrome/google-chrome --enable-plugins

##
# Tools
##

# elixir version manager
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"