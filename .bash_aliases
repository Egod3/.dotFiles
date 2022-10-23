###############################################
####               FUNCTIONS               ####
###############################################
ps_n(){
    echo ps -t pts/$1 -o pid,ppid,tty,stat,args,wchan
    ps -t pts/$1 -o pid,ppid,tty,stat,args,wchan
}

deb_update(){
    echo
    echo "sudo snap refresh"
    echo "sudo apt update"
    echo "sudo apt upgrade -y"
    echo "sudo apt autoremove -y"
    echo "sudo fwupdmgr refresh"
    echo "sudo fwupdmgr get-updates"
    echo "sudo fwupdmgr update"
    echo "sudo update-manager"
    echo
    sudo snap refresh
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo fwupdmgr refresh
    sudo fwupdmgr get-updates
    sudo fwupdmgr update
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

# Function to build and test roll_for_initiative and any
# libraries it uses
build_rfi(){
  rfi_path="/mnt/NAS/data/git/tools/roll_for_initiative"
  character_path="/mnt/NAS/data/git/tools/character"
  if [ $PWD=$rfi_path ]
  then
    echo "cd ../character/ && cargo build && cargo test -- --test-threads=2 $1\
      && echo && echo && echo && cd ../roll_for_initiative/ && cargo build && cargo run"
    cd ../character/ && cargo build && cargo test -- --test-threads=2 $1 && \
      echo && echo && echo && cd ../roll_for_initiative/ && cargo build && cargo run
  elif [ $PWD=$character_path ]
  then
    echo "cd ../roll_for_initiative/ && cargo build && cargo run && echo && echo && echo && \
      cd ../character/ && cargo build && cargo test -- --test-threads=2 $1"
    cd ../roll_for_initiative/ && cargo build && cargo run && echo && echo && echo && \
      cd ../character/ && cargo build && cargo test -- --test-threads=2 $1
  fi
}

build_rfi_dbg(){
  build_rfi "--show-output"
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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

alias start_tmux='~/.dotFiles/start-tmux.sh'
alias vim='/usr/local/bin/nvim'
