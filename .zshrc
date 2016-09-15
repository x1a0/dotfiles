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

has() {
  command -v "$1" >/dev/null 2>&1
}

if has nvim; then
  alias vim='nvim'
fi

bindkey "^R" history-incremental-pattern-search-backward

# Meta-u to chdir to the parent directory
bindkey -s '\eu' '^Ucd ..; ls^M'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if [[ $(uname) == 'Darwin' ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi
