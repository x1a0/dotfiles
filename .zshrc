# Prerequisites
# - tar
# - unzip

HARDWARE=$(uname -m)
OP_SYS=$(uname -s)

zstyle ":prezto:*:*" color "yes"
zstyle ":prezto:module:editor" key-bindings "vi"

# Install zplugin if need
if [ ! -d "${ZDOTDIR:-$HOME}/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

source "${ZDOTDIR:-$HOME}/.zplugin/bin/zplugin.zsh"
# two lines below are only needed if `compinit` is before sourcing
#autoload -Uz _zplugin
#(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Z-Plugins
zplugin load zplugin/z-a-rust

# Utils
zplugin ice wait silent atload'_zsh_autosuggest_start'
zplugin load zsh-users/zsh-autosuggestions

zplugin ice wait silent
zplugin load zdharma/fast-syntax-highlighting

# Prezto(PZT) modules
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

# NVM for NodeJS
zplugin load "lukechilds/zsh-nvm"

# Pyenv
zplugin ice wait silent as"program" pick"bin/pyenv" src"zpyenv.zsh" nocompile"!" \
    atclone"PYENV_ROOT=\"\$PWD\" ./libexec/pyenv init - > zpyenv.zsh" \
    atinit"export PYENV_ROOT=\"\$PWD\"" \
    atpull"%atclone"
zplugin load pyenv/pyenv

# Starship prompt https://starship.rs/
zplugin ice from"gh-r" as"program" pick"**/starship" \
    atload"!eval \$(starship init zsh)"
zplugin load starship/starship

# A command-line fuzzy finder
zplugin ice from"gh-r" as"program"
zplugin load junegunn/fzf-bin

# Terraform
TERRAFORM_VERSION=0.12.16
[[ "${HARDWARE}" = "x86_64" ]] && TERRAFORM_ARCH="amd64" || TERRAFORM_ARCH="386"
zplugin ice as"program" pick"terraform" atclone"unzip *.zip && rm -f *.zip" atpull"%atclone"
zplugin snippet "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OP_SYS:l}_${TERRAFORM_ARCH}.zip"

# Kubernetes
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
zplugin ice id-as"kubectl" as"program" pick"kubectl" atload"!source <(kubectl completion zsh); alias k=kubectl"
zplugin snippet "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

# ShellCheck
SHELLCHECK_VERSION="stable"
zplugin ice as"program" pick"**/shellcheck" \
    atclone"tar -xf *.tar.xz" atpull"%atclone"
zplugin snippet "https://storage.googleapis.com/shellcheck/shellcheck-${SHELLCHECK_VERSION}.${OP_SYS:l}.${HARDWARE}.tar.xz"

# Circle CI cli
zplugin ice from"gh-r" as"program" pick"**/circleci"
zplugin load CircleCI-Public/circleci-cli

# Theme
zplugin ice pick"scripts/base16-tomorrow-night.sh"
zplugin load chriskempson/base16-shell

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
bindkey -s "\\eu" "^Ucd ..; ls^M" # meta-u to chdir to the parent directory

export PATH="$HOME/.local/bin:$PATH"

LOCAL_ZSHRC="$HOME/.dotfiles/local.zshrc"
[ -s "$LOCAL_ZSHRC" ] && source "$LOCAL_ZSHRC"
