###############################################
####               FUNCTIONS               ####
###############################################
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

###############################################
####                ALIASES                ####
###############################################
alias update='deb_update'

alias psn='ps_n'

alias c=clear
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CFh'
alias psg='ps aux | grep'
alias gl='git log --decorate --graph'
alias glo='git log --decorate --graph --oneline'
alias f='find -iname '
