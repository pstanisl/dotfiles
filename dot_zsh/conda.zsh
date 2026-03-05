# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$(brew --caskroom)/Caskroom/miniforge/base/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
	if [ -f "$(brew --caskroom)/miniforge/base/etc/profile.d/conda.sh" ]; then
		. "$(brew --caskroom)/miniforge/base/etc/profile.d/conda.sh"
    else
	    export PATH="$(brew --caskroom)/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# NOTE: To deactivate conda environment before a promt, e.g., (env) > my prompt, call `conda config --set changeps1     False`

