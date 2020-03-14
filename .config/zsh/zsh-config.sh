#SHORT_HOST=${HOST/.*/}

# Save the location of the current completion dump file.
#if [ -z "$ZSH_COMPDUMP" ]; then
#  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
#fi

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS
  local -a FLAGS
  FLAGS=('--porcelain')
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
#   case "$GIT_STATUS_IGNORE_SUBMODULES" in
#     git)
#       # let git decide (this respects per-repo config in .gitmodules)
#       ;;
#     *)
#       # if unset: ignore dirty submodules
#       # other values are passed to --ignore-submodules
#       FLAGS+="--ignore-submodules=${GIT_STATUS_IGNORE_SUBMODULES:-dirty}"
#       ;;
#   esac
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

autoload -U colors && colors
setopt prompt_subst

PROMPT=' %{$fg_bold[blue]%}%c $(git_prompt_info)'
PROMPT+='%(?:%{$fg_bold[green]%}}%{$reset_color%} :%{$fg_bold[red]%}}%{$reset_color%} )'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}git:[%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}] %{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}]"
