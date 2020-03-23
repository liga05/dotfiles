# Outputs current branch info in prompt format
git_prompt_info() {
  local ref
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || return # or \ if below is uncomment
    #ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    print "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
parse_git_dirty() {
  local STATUS
  local -a FLAGS
  DISABLE_UNTRACKED_FILES_DIRTY=false
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
    print "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    print "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# Execution time start
xtime_preexec() {
  xTIME_start=$(date +%s)
}

# Execution time end
xtime_precmd() { 
  [ -n "$xTIME_duration" ] && unset xTIME_duration
  [ -z "$xTIME_start" ] && return
  local xTIME_stop=$(date +%s)
  xTIME_duration=$((xTIME_stop - xTIME_start))
  unset xTIME_start
}

xtime() {
  [ "$xTIME_duration" -lt 2 ] && return
    xTIME_H=$((xTIME_duration / 3600))
    xTIME_M=$((xTIME_duration % 3600 / 60))
    xTIME_S=$((xTIME_duration % 60))
    printf '%%F{259}took %%F{yellow}'
    [ "$xTIME_H" -gt 0 ] && printf '%dh ' $xTIME_H 
    [ "$xTIME_M" -gt 0 ] && printf '%dm ' $xTIME_M
    [ "$xTIME_S" -gt 0 ] && printf '%ds ' $xTIME_S
}

autoload -U add-zsh-hook
add-zsh-hook preexec xtime_preexec
add-zsh-hook precmd xtime_precmd

autoload -U colors && colors
setopt prompt_subst

PROMPT=' %B%F{blue}%c $(git_prompt_info)%b$(xtime)%B'
PROMPT+='%(?:%F{green}}%f%b :%F{red}}%f%b )'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{259}on %F{magenta}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}[!]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
