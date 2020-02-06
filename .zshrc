# Prerequisites
# - tar
# - unzip

HARDWARE=$(uname -m)
OP_SYS=$(uname -s)

zstyle ":prezto:*:*" color "yes"
zstyle ":prezto:module:editor" key-bindings "vi"

# Install zinit if need
if [ ! -f "${ZDOTDIR:-$HOME}/.zinit/bin/zinit.zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi

source "${ZDOTDIR:-$HOME}/.zinit/bin/zinit.zsh"
# two lines below are only needed if `compinit` is before sourcing
#autoload -Uz _zinit
#(( ${+_comps} )) && _comps[zinit]=_zinit

# zinit annexes
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-bin-gem-node

# Utils
zinit ice wait silent atload'_zsh_autosuggest_start'
zinit load zsh-users/zsh-autosuggestions

zinit ice wait silent
zinit load zdharma/fast-syntax-highlighting

# Prezto(PZT) modules
zinit ice svn
zinit snippet PZT::modules/environment
zinit ice svn
zinit snippet PZT::modules/editor
zinit ice svn
zinit snippet PZT::modules/history
zinit ice svn
zinit snippet PZT::modules/directory
zinit ice svn
zinit snippet PZT::modules/spectrum
zinit ice svn
zinit snippet PZT::modules/utility
zinit ice svn
zinit snippet PZT::modules/completion

zinit as"null" wait lucid from"gh-r" for \
    mv"exa* -> exa" sbin atload'alias ls="exa -bh --color=auto --git"' ogham/exa \
    sbin"fzf" junegunn/fzf-bin \
    sbin"tfswitch" warrensbox/terraform-switcher

# NVM for NodeJS
zinit load "lukechilds/zsh-nvm"

# Pyenv
zinit ice silent as"program" pick"bin/pyenv" src"zpyenv.zsh" nocompile"!" \
    atclone"PYENV_ROOT=\"\$PWD\" ./libexec/pyenv init - > zpyenv.zsh" \
    atinit"export PYENV_ROOT=\"\$PWD\"" \
    atpull"%atclone"
zinit load pyenv/pyenv

# Starship prompt https://starship.rs/
zinit ice from"gh-r" as"program" pick"**/starship" \
    atload"!eval \$(starship init zsh)"
zinit load starship/starship

# Kubernetes
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
zinit ice id-as"kubectl" as"program" pick"kubectl" atload"!source <(kubectl completion zsh); alias k=kubectl"
zinit snippet "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${OP_SYS:l}/amd64/kubectl"

# ShellCheck
SHELLCHECK_VERSION="stable"
zinit ice as"program" pick"**/shellcheck" \
    atclone"tar -xf *.tar.xz" atpull"%atclone"
zinit snippet "https://storage.googleapis.com/shellcheck/shellcheck-${SHELLCHECK_VERSION}.${OP_SYS:l}.${HARDWARE}.tar.xz"

# Circle CI cli
zinit ice from"gh-r" as"program" pick"**/circleci"
zinit load CircleCI-Public/circleci-cli

# Theme
zinit ice pick"scripts/base16-tomorrow-night.sh"
zinit load chriskempson/base16-shell

# Completions
# https://github.com/zdharma/zinit#calling-compinit-without-turbo-mode
autoload -Uz compinit
compinit
zinit cdreplay -q

#
# }}}
#

#
# misc
#
bindkey "^R" history-incremental-pattern-search-backward
bindkey -s "\\eu" "^Ucd ..; ls^M" # meta-u to chdir to the parent directory

export PATH="$HOME/.local/bin:$PATH"

LOCAL_ZSHRC="$HOME/.dotfiles/local.zshrc"
[ -s "$LOCAL_ZSHRC" ] && source "$LOCAL_ZSHRC"
