################################################
####                FUNCTIONS              #####
################################################
ps_n(){
    echo ps -t pts/$1 -o pid,ppid,tty,stat,args,wchan
    ps -t pts/$1 -o pid,ppid,tty,stat,args,wchan
}

deb_update(){
    echo
    echo "sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo do-release-upgrade -c"
    echo
    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo do-release-upgrade -c
}

################################################
####                 ALIASES               #####
################################################
alias update='deb_update'

alias psn='ps_n'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias c=clear
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CFh'
alias psg='ps aux | grep'
alias gl='git log --all --decorate --oneline --graph'
