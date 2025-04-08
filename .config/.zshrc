export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git)
alias k="kubectl"
alias g="git"
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"