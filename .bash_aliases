###############################################
####               FUNCTIONS               ####
###############################################
rust_check_clean(){
  echo "cargo clean"
  cargo clean
  if [[ $? != 0 ]]; then
    echo "Error running cargo clean, bailing"
    return;
  fi
  echo "cargo build"
  cargo build
  if [[ $? != 0 ]]; then
    echo "Error running cargo build, bailing"
    return;
  fi
  echo "cargo fmt --check"
  cargo fmt --check
  if [[ $? != 0 ]]; then
    echo "Error running cargo fmt --check, bailing"
    return;
  fi
  echo "cargo clippy --verbose -- -D warnings"
  cargo clippy --verbose -- -D warnings
  if [[ $? != 0 ]]; then
    echo "Error running cargo clippy, bailing"
    return;
  fi
}

rust_check(){
  echo "cargo build"
  cargo build
  if [[ $? != 0 ]]; then
    echo "Error running cargo build, bailing"
    return;
  fi
  echo "cargo build -r"
  cargo build -r
  if [[ $? != 0 ]]; then
    echo "Error running cargo build -r, bailing"
    return;
  fi
  echo "cargo build --bins"
  cargo build --bins
  if [[ $? != 0 ]]; then
    echo "Error running cargo build --bins, bailing"
    return;
  fi
  echo "cargo fmt --check"
  cargo fmt --check
  if [[ $? != 0 ]]; then
    echo "Error running cargo fmt --check, bailing"
    return;
  fi
  echo "cargo clippy --verbose -- -D warnings"
  cargo clippy --verbose -- -D warnings
  if [[ $? != 0 ]]; then
    echo "Error running cargo clippy, bailing"
    return;
  fi
  echo "cargo doc"
  cargo doc
  if [[ $? != 0 ]]; then
    echo "Error running cargo doc, bailing"
    return;
  fi
}

rust_check_all(){
  rust_check
  echo "cargo msrv"
  cargo msrv
  if [[ $? != 0 ]]; then
    echo "Error running cargo msrv, bailing"
    return;
  fi
  #echo "cargo test -- --show-output"
  #cargo test -- --show-output
  #if [[ $? != 0 ]]; then
  #  echo "Error running cargo test -- --show-output, bailing"
  #  return;
  #fi
}

alias cargo_check_all=rust_check_all
alias cargo_check=rust_check
alias cargo_check_clean=rust_check_clean

ps_n(){
    echo ps -t pts/$1 -o pid,ppid,tty,stat,args,wchan
    ps -t pts/$1 -o pid,ppid,tty,stat,args,wchan
}

deb_update(){
    echo
    echo "sudo snap refresh"
    echo "rustup update"
    echo "cargo install-update -a"
    echo "sudo apt update"
    echo "sudo apt upgrade -y"
    echo "sudo apt autoremove -y"
    echo "sudo fwupdmgr refresh"
    echo "sudo fwupdmgr get-updates"
    echo "sudo fwupdmgr update"
    echo
    sudo snap refresh
    rustup update
    cargo install-update -a
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo fwupdmgr refresh
    sudo fwupdmgr get-updates
    sudo fwupdmgr update
}

color_test(){
  for C in {0..255}; do
      tput setab $C
      echo -n "$C "
  done
  tput sgr0
  echo
}

git_dev_stats()
{
  git shortlog -sn
}

git_dev_stats_this_year()
{
  git shortlog -sn --after=$(date -I) --after=01-01-$(date +"%Y")
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='rg '
fi

###############################################
####                ALIASES                ####
###############################################
alias update='deb_update'
alias color_test='color_test'

alias bash_update='source ~/.bashrc'

alias psn='ps_n'

alias c=clear
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CFh'
alias psg='ps aux | rg'
alias gl='git log --decorate --graph'
alias glo='git log --decorate --graph --oneline'
alias gb='git branch -vva'
alias gd='git diff'
alias f='fd -i '
alias g='rg -i '

alias nqma_cp='/workspace/fli/fli-utils/scripts/nqma_deploy.sh'
alias find_nqma='sudo nmap -sn 172.16.1.0/24 | grep nqma'

alias start_tmux='~/start-tmux.sh'
alias vim='/usr/bin/nvim'
alias pgrep='pgrep -l'
alias grep='rg '
### To ignore all .gitignore .rgignore and other ignore files use --no-ignore
#alias grep='rg --no-ignore'
### To search for files of a specific type, like *.h, try this:
#alias grep_type='rg -t h'
