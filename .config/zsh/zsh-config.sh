#SHORT_HOST=${HOST/.*/}

# Save the location of the current completion dump file.
#if [ -z "$ZSH_COMPDUMP" ]; then
#  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
#fi

# Outputs current branch info in prompt format
git_prompt_info() {
  local ref
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
parse_git_dirty() {
  local STATUS
  local -a FLAGS
  FLAGS=(--porcelain)
    if [ "$DISABLE_UNTRACKED_FILES_DIRTY" = "true" ]; then
      FLAGS+=(--untracked-files=no)
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
  STATUS=$(command git status "${FLAGS[@]}" 2> /dev/null | tail -n1)
  if [ -n "$STATUS" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

autoload -U colors && colors
setopt prompt_subst

PROMPT=' %B%F{blue}%c $(git_prompt_info)'
PROMPT+='%(?:%F{green}}%f%b :%F{red}}%f%b )'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{white}on %F{magenta} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}[!]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
