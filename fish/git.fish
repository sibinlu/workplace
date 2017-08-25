alias gs='git status '
alias gch='git checkout '
alias gc='git commit -a -m '
alias gb='git branch '
alias gp='git push origin '
alias gt='git tag '

function gta 
	echo $argv
	git tag -a $argv -m "$argv"
	git push origin $argv 
end

