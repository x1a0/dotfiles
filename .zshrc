zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'

# Install zplugin if need
if [ ! -d "${ZDOTDIR:-$HOME}/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

source "${ZDOTDIR:-$HOME}/.zplugin/bin/zplugin.zsh"
# two lines below are only needed if `compinit` is before sourcing
#autoload -Uz _zplugin
#(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Z-Plugins
zplugin light zplugin/z-a-rust

# Utils
zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting

zplugin ice svn
zplugin snippet PZT::modules/environment
zplugin ice svn
zplugin snippet PZT::modules/editor
zplugin ice svn
zplugin snippet PZT::modules/history
zplugin ice svn
zplugin snippet PZT::modules/directory
zplugin ice svn
zplugin snippet PZT::modules/spectrum
zplugin ice svn
zplugin snippet PZT::modules/utility
zplugin ice svn
zplugin snippet PZT::modules/completion

# Pyenv
zplugin ice as"program" pick"bin/pyenv" src"zpyenv.zsh" nocompile"!" \
    atclone"PYENV_ROOT=\"\$PWD\" ./libexec/pyenv init - > zpyenv.zsh" \
    atinit"export PYENV_ROOT=\"\$PWD\"" \
    atpull"%atclone"
zplugin light pyenv/pyenv

# Starship prompt https://starship.rs/
zplugin ice from"gh-r" as"program" pick"**/starship" \
    atload"!eval \$(starship init zsh)"
zplugin light starship/starship

# A command-line fuzzy finder
zplugin ice from"gh-r" as"program"
zplugin load junegunn/fzf-bin

zplugin ice as"program" pick"kubectl" atload'!source <(kubectl completion zsh)'
zplugin snippet https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

# Theme
zplugin ice pick"scripts/base16-tomorrow-night.sh"
zplugin light chriskempson/base16-shell

# Completions
# https://github.com/zdharma/zplugin#calling-compinit-without-turbo-mode
autoload -Uz compinit
compinit
zplugin cdreplay -q

#
# }}}
#

#
# misc
#
bindkey "^R" history-incremental-pattern-search-backward
bindkey -s '\eu' '^Ucd ..; ls^M' # meta-u to chdir to the parent directory

export PATH="$HOME/.local/bin:$PATH"

LOCAL_ZSHRC="$HOME/.dotfiles/local.zshrc"
[ -s "$LOCAL_ZSHRC" ] && source "$LOCAL_ZSHRC"
