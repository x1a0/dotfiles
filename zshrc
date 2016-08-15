source ~/.zplug/init.zsh

zplug "zplug/zplug"
zplug "sorin-ionescu/prezto", as:plugin, use:init.zsh, hook-build:"ln -s $ZPLUG_ROOT/repos/sorin-ionescu/prezto $HOME/.zprezto"
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
  'environment' \
  'terminal' \
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

# /prezto config


export LC_ALL='en_US.UTF-8'

# source plugins and add commands to $PATH
zplug load --verbose

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

alias vim='nvim'

bindkey "^R" history-incremental-pattern-search-backward

export NVM_DIR="/Users/x1a0/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
