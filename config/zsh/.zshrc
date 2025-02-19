# Z-Shell Setopt

setopt no_beep                            # Disable the shell from triggering the bell
setopt hist_reduce_blanks                 # Reduce whitespace from commands
setopt complete_aliases                   # Expand aliases before completion has finished
setopt autopushd pushdminus pushdsilent   # Use pushd when cd-ing around
setopt hist_ignore_all_dups               # Filter non-contiguous duplicates from history
setopt no_flow_control                    # disable start (C-s) and stop (C-q) characters
setopt rematch_pcre                       # Match regular expressions using PCRE if available
setopt pushd_ignore_dups                  # don't push multiple copies of same dir onto stack
setopt auto_param_slash                   # tab completing directory appends a slash
setopt share_history                      # share history between shell processes

# - { ZStyle } ----------------------------------------------------------------------------- #
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':zsh-utils:plugins:completion' use-xdg-basedirs "true"

# - { Helper Functions } ------------------------------------------------------------------- #
_exists() { (( $+commands[$1] )) }

autoload -Uz compinit && compinit

# - { Antidote } --------------------------------------------------------------------------- #
antidote_dir=${ZDOTDIR:-~}/antidote
plugins_txt=${ZDOTDIR:-~}/zsh_plugins.txt
static_file=${ZDOTDIR:-~}/zsh_plugins.zsh

# Clone antidote if necessary and generate a static plugin file.
if [[ ! $static_file -nt $plugins_txt ]]; then
  [[ -e $antidote_dir ]] ||
    git clone --depth=1 https://github.com/mattmc3/antidote.git $antidote_dir
  (
    source $antidote_dir/antidote.zsh
    [[ -e $plugins_txt ]] || touch $plugins_txt
    antidote bundle <$plugins_txt >$static_file
  )
fi

# Allow Antidote commands
autoload -Uz $antidote_dir/functions/antidote

# source the static plugins file
source $static_file

# cleanup
unset antidote_dir plugins_txt static_file

# -- { Shell Completions } ----------------------------------------------------------------- #

if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
if [ $commands[flux] ]; then source <(flux completion zsh); fi
if [ $commands[helm] ]; then source <(helm completion zsh); fi

# -- { Shell Hooks } ----------------------------------------------------------------------- #

if [ x$ZSH_SELF_EXAPWD = xtrue ]; then
  # Define a function to list directories with exa and add it as a hook
  function -auto-ls-after-cd() {
    emulate -L zsh
    # Only in response to a user-initiated `cd`, not indirectly (eg. via another function).
    if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
      if $SHELL_NERD_FONT_AVAILABLE; then command -v exa > /dev/null && exa --icons --only-dirs || ls; fi
      if ! $SHELL_NERD_FONT_AVAILABLE; then command -v exa > /dev/null && exa --only-dirs || ls; fi
    fi
  }
  add-zsh-hook chpwd -auto-ls-after-cd
fi

# Initialize Starship Prompt if available
if [[ $TERM != "dumb" && (-z $INSIDE_EMACS || $INSIDE_EMACS == "vterm") ]]; then
  _exists starship && eval "$(starship init zsh)"
fi

# Hook direnv if available
_exists direnv && eval "$(direnv hook zsh)"

# - { Aliases } ---------------------------------------------------------------------------- #
alias ip='ip --color=auto'
alias mtr='mtr -n -o '\''LSRDNBAW'\'''

if _exists nvim; then
  export EDITOR='nvim'
  export VISUAL='nvim'
  alias vi='nvim'
  alias vim='nvim'
fi 

### Replace ls with exa if available
if _exists exa; then
  if $SHELL_NERD_FONT_AVAILABLE; then
    alias ls='exa --icons'
    alias ll='exa -l --icons'
    alias la='exa -a --icons'
    alias lla='exa -la --icons'
    alias lt='exa --tree --icons'
  else
    alias ls='exa'
    alias ll='exa -l'
    alias la='exa -a'
    alias lla='exa -la'
    alias lt='exa --tree'
  fi
fi

### Replace cat(1) with bat if available
if _exists bat; then
  alias cat='bat --plain --paging=never'
  batf() { tail -f "$1" | bat --plain --paging=never; }
  batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
  }
  help() {
    "$@" --help 2>&1 | bat --plain --language=help --paging=never
  }
fi

skpreview() {
  sk --ansi -i --preview "tui_preview.sh {}" "$@"
}

### Typoing sudo will still call sudo, preserving the user's path
alias sudo='sudo env PATH=$PATH '
alias sudu='sudo env PATH=$PATH '
alias sodo='sudo env PATH=$PATH '
alias sodu='sudo env PATH=$PATH '
alias sdoo='sudo env PATH=$PATH '
alias sduo='sudo env PATH=$PATH '

# - { Keybinds } ---------------------------------------------------------------------------- #
bindkey -e
#if [[ "${terminfo[khome]}" != "" ]]; then
#  bindkey "${terminfo[khome]}" beginning-of-line
#else
#  bindkey '^[[7~' beginning-of-line
#  bindkey '^[[H' beginning-of-line
#fi

#if [[ "${terminfo[kend]}" != "" ]]; then
#  bindkey "${terminfo[kend]}" end-of-line
#else
#  bindkey '^[[8~' end-of-line
#  bindkey '^[[F' end-of-line
#fi

# TEMPORARY
bindkey '^[[F' end-of-line
bindkey '^[[H' beginning-of-line

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

# Use "cbt" capability ("back_tab", as per `man terminfo`), if we have it:
if tput cbt &> /dev/null; then
  bindkey "$(tput cbt)" reverse-menu-complete # make Shift-tab go to previous completion
fi

# ctrl+<- | ctrl+->
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
# alt+<- | alt+->
bindkey "^[[1;3C" forward-word 
bindkey "^[[1;3D" backward-word