#
# prezto config
#
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

#
# zplugin
#
source '/home/x1a0/.dotfiles/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin load x1a0/prezto
zplugin ice pick"scripts/base16-tomorrow-night.sh"
zplugin light chriskempson/base16-shell

#
# misc
#
bindkey "^R" history-incremental-pattern-search-backward
bindkey -s '\eu' '^Ucd ..; ls^M' # meta-u to chdir to the parent directory

LOCAL_ZSHRC="$HOME/.dotfiles/local.zshrc"
[ -s "$LOCAL_ZSHRC" ] && source "$LOCAL_ZSHRC"
