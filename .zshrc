source '/home/x1a0/.dotfiles/.zplugin/bin/zplugin.zsh'

# Z-Plugins
zplugin light zplugin/z-a-rust

# Utils
zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting

# pyenv
zplugin ice \
    atclone"PYENV_ROOT=\"\$PWD\" ./libexec/pyenv init - > zpyenv.zsh" \
    atinit"export PYENV_ROOT=\"\$PWD\"" \
    atpull"%atclone" \
    as"command" pick"bin/pyenv" src"zpyenv.zsh" nocompile"!"
zplugin light pyenv/pyenv

# Starship prompt https://starship.rs/
zplugin ice from"gh-r" as"program" atload"!eval $(starship init zsh)" pick"**/starship"
zplugin light starship/starship

# A command-line fuzzy finder
zplugin ice from"gh-r" as"program"
zplugin load junegunn/fzf-bin

# Theme
zplugin ice pick"scripts/base16-tomorrow-night.sh"
zplugin light chriskempson/base16-shell


#
# }}}
#

#
# misc
#
bindkey "^R" history-incremental-pattern-search-backward
bindkey -s '\eu' '^Ucd ..; ls^M' # meta-u to chdir to the parent directory

LOCAL_ZSHRC="$HOME/.dotfiles/local.zshrc"
[ -s "$LOCAL_ZSHRC" ] && source "$LOCAL_ZSHRC"
