
# ==============================================================================
# Oh my zsh and theme:
# ==============================================================================

ZSH_THEME="powerlevel10k/powerlevel10k"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

source ~/.p10k.zsh

# ==============================================================================
# Aliases
# ==============================================================================

# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}

alias gaa='git add --all'

alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# git branch (interactive)
gb() {
  if [[ "$#" -gt 0 ]]; then
    git branch "$@"
    return $?
  fi

  local branches selection branch
  branches=$(git branch --sort=-committerdate -vv) &&
    selection=$(echo "$branches" | fzf --height=20% +m) &&
    branch=$(echo "$selection" | awk '{print $1}' | sed "s/.* //") &&
    if [[ -t 1 ]]; then git checkout "$branch"; else echo $branch; fi
}

gs() {
  if [[ $# != 1 ]]; then
    echo "Usage: start <NAME>" >&2
    exit 64
  fi

  git fetch origin
  git switch -c "jfuchs/$1" origin/main
  git push -u origin "jfuchs/$1"
}