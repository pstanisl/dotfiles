. "$HOME/.cargo/env"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# NVM direcory
export NVM_DIR="$HOME/.nvm"

# Poetry
export PATH="$HOME/.local/bin:$PATH"

