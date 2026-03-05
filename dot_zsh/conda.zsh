# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# Hardcoded path to avoid slow `brew --caskroom` subprocess
__conda_setup="$(/opt/homebrew/Caskroom/miniforge/base/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
	if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
		. "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
	    export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# NOTE: To deactivate conda environment before a prompt, e.g., (env) > my prompt, call `conda config --set changeps1 False`
