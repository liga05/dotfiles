autoload -U compaudit compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include hidden files in autocomplete:
_comp_option+=(globdots)

HISTSIZE=2222
SAVEHIST=1111
HISTFILE=~/.cache/histfile/zsh_history

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

source $ZDOTDIR/zsh-config.sh
#source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
