source ~/.zplug/init.zsh

zplug "zplug/zplug"
zplug "x1a0/prezto", as:plugin, use:init.zsh, hook-build:"ln -s $ZPLUG_ROOT/repos/x1a0/prezto ${ZDOTDIR:-$HOME}/.zprezto"
zplug "chriskempson/base16-shell", use:"scripts/base16-tomorrow-night.sh"
zplug "felixr/docker-zsh-completion"

# install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi


# prezto config

zstyle ':prezto:*:*' color 'yes'

zstyle ':prezto:load' pmodule \
  'tmux' \
  'environment' \
  'editor' \
  'history' \
  'directory' \
  'spectrum' \
  'utility' \
  'completion' \
  'fasd' \
  'prompt' \
  'git'

zstyle ':prezto:module:editor' key-bindings 'vi'

zstyle ':prezto:module:prompt' theme 'coolblue'

zstyle ':prezto:module:tmux:auto-start' remote 'yes'

# /prezto config


# source plugins and add commands to $PATH
zplug load --verbose

bindkey "^R" history-incremental-pattern-search-backward

# Meta-u to chdir to the parent directory
bindkey -s '\eu' '^Ucd ..; ls^M'

LOCAL_ZSHRC="$HOME/.dotfiles/local.zshrc"
[ -s "$LOCAL_ZSHRC" ] && source "$LOCAL_ZSHRC"
