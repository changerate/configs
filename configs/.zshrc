# Vi-style centric for user input
# Carlos Vargas <carlosfvargas526@gmail.com>
# Heavily inspired by John G. <JohnnyGOX17>



###########################################################
# Alias's
###########################################################
alias cls='clear && ls' # clear screen and ls with one command
alias python=python3
alias pip=pip3
lport() {
  lsof -i :"$1" || true
}


###########################################################
# Some section
###########################################################
export QT_LOGGING_RULES="qt.qml.connections=true"
export QML_DISABLE_DISK_CACHE=1
export QT_FATAL_WARNINGS=1
# Autocorrect for `cd`
setopt correct


###########################################################
# Terminal & Path additions/edits/exports
###########################################################
# COLORS -- currently overwritten
export PS1='%F{green}%n@%m%f:%F{cyan}%~%f$ '
export CLICOLOR=1

# Prompt: SSH uses red; local uses blue. Current directory is yellow.
if [[ -n $SSH_CLIENT ]]; then
  PROMPT='%B%F{red}[SSH]%n@%m %F{yellow}%1~ %#%f%b '
else
  PROMPT='%B%F{blue}%n@%m %F{yellow}%1~ %#%f%b '
fi






###########################################################
# Vim keybindings
###########################################################
bindkey -v





###########################################################
# User specefici aliases and functions
###########################################################


function git-status-recursive-curr-dir {
  emulate -L zsh
  setopt null_glob

  local d git_stat git_push
  # Colors for printing
  local BLU=$'\033[1;34m'
  local NC=$'\033[0m'

  # Iterate through directories in src/ and check git status
  for d in */; do
    pushd "$d" >/dev/null || continue

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      git_stat=$(git status --short)
      git_push=$(git status --short --branch | grep -F '[ahead ' || true)

      if [[ -n $git_stat ]]; then
        print -r -- "\n${BLU}[${d}]${NC}"
        print -r -- "$git_stat"
      elif [[ -n $git_push ]]; then
        print -r -- "\n${BLU}[${d}]${NC}"
        print -r -- "$git_push"
      fi
    fi

    popd >/dev/null || return
  done
}
