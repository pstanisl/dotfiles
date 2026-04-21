# NVM lazy load
#
export NVM_DIR="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  _nvm_lazy_load() {
    unset -f nvm node npm pi _nvm_lazy_load _nvm_lazy_load_dispatch
    . "$NVM_DIR/nvm.sh"
    hash -r
  }

  _nvm_lazy_load_dispatch() {
    local cmd="$1"
    shift
    _nvm_lazy_load
    command "$cmd" "$@"
  }

  nvm() {
    _nvm_lazy_load_dispatch nvm "$@"
  }

  node() {
    _nvm_lazy_load_dispatch node "$@"
  }

  npm() {
    _nvm_lazy_load_dispatch npm "$@"
  }

  pi() {
    _nvm_lazy_load_dispatch pi "$@"
  }
fi
