###############################################
####               FUNCTIONS               ####
###############################################
ps_n(){
    echo ps -t pts/$1 -o pid,ppid,tty,stat,args,wchan
    ps -t pts/$1 -o pid,ppid,tty,stat,args,wchan
}

deb_update(){
    echo
    echo "sudo apt update"
    echo "sudo apt upgrade -y"
    echo "sudo apt autoremove -y"
    echo "sudo update-manager"
    echo
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo update-manager
}

transcode(){
   echo "/mnt/NAS/data/git/scripts/transcode.py -i /mnt/NAS/video/tv\ shows/ -v -t"
   /mnt/NAS/data/git/scripts/transcode.py -i /mnt/NAS/video/tv\ shows/ -v -t
}

rename(){
  echo "/mnt/NAS/data/git/scripts/rename_media.py -i /mnt/NAS/video/ -v -r"
  /mnt/NAS/data/git/scripts/rename_media.py -i /mnt/NAS/video/ -v -r
}

# Check if any files need to be renamed.
# Basically don't pass in the -r (rename) flag
check_rename(){
  echo "/mnt/NAS/data/git/scripts/rename_media.py -i /mnt/NAS/video/ -v"
  /mnt/NAS/data/git/scripts/rename_media.py -i /mnt/NAS/video/ -v
}

###############################################
####                ALIASES                ####
###############################################
alias update='deb_update'
alias work_rdp='rdesktop_work'

alias psn='ps_n'

alias c=clear
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CFh'
alias psg='ps aux | grep'
alias gl='git log --decorate --graph'
alias glo='git log --decorate --graph --oneline'
alias gb='git branch -va'
alias gd='git diff'
alias f='find -iname '

alias fts='find /mnt/NAS/video/  -iname *.ts'
alias trans=transcode
