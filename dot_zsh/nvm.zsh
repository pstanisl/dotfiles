# NVM lazy load
#
if [ -s "$HOME/.nvm/nvm.sh" ]; then
	#[ -s "$NVM_DIR/bash_completion" ] $$ . "$NVM_DIR/bash_completion"
    #[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
	alias nvm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
	alias node='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
	alias npm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
fi
