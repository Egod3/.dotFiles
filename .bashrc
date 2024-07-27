# $HOME/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# My full config can be found here: https://github.com/Egod3/.dotFiles

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# Save up to 1000 characeters per command
HISTSIZE=1000
# Save up to 200,000 commands in the history
HISTFILESIZE=2000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=no

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [[ -f $HOME/.git-prompt.sh ]]; then
  source $HOME/.git-prompt.sh
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  export GIT_PS1_SHOWCOLORHINTS=true
fi

export PS1="\[$(tput setaf 2)\]\u@\h:\W\$(__git_ps1)\$ \[$(tput sgr0)\]"
unset color_prompt force_color_prompt

# Export standardized VISUAL and EDITOR env vars
export VISUAL=nvim
export EDITOR="$VISUAL"

# Export GIT_EDITOR env var just to be thorough
export GIT_EDITOR=nvim
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [[ -f $HOME/.bash_aliases ]]; then
    source $HOME/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi
# Source $HOME/.cargo/env to enable cargo
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# This was added when installing the tockloader, the boot loader used to load apps on the tock
# Embedded rust OS.
# Update path to add these packages to the PATH variable, installed as part of this command:
#   pip3 install --upgrade tockloader --user # Installing collected packages: tqdm, pytoml, pyserial, crcmod, argcomplete, tockloader
# This is also needed for some python libs, so making it generic for all machines.
if [ -d $HOME/.local/bin ]; then
    PATH="$PATH:$HOME/.local/bin"
fi

username=$(whoami)
# Only override the ZEPHYR_TOOLCHAIN_VARIANT install location if on my personal host
  # source /mnt/NAS/data/git/rust_embd/oses/zephyrproject/.venv/bin/activate
if [ "$HOSTNAME" = "ezra-lnx" ] && [ "$username" = "ezra" ]; then
    unset ZEPHYR_TOOLCHAIN_VARIANT
    export ZEPHYR_SDK_INSTALL_DIR=/mnt/NAS/data/git/rust_embd/oses/zephyr-sdk-0.16.5
elif [ "$HOSTNAME" = "eg-linux" ] && [ "$username" = "eg" ]; then
    # Only source ~/.work_conf if on my work host
    if [ -f ~/.work_conf ]; then
        source ~/.work_conf
    fi
    ## Add Matt's devtools scripts to the path:
    if [ -d $HOME/bin/devtools ]; then
        PATH="$PATH:$HOME/bin/devtools"
    fi
    ## Add default go app install to path
    if [ -d $HOME/go/bin ]; then
        PATH="$PATH:$HOME/go/bin"
    fi
    # Source bash functions
    if [ -f $HOME/.fli_funcs ]; then
        source $HOME/.fli_funcs
    fi
    # Add Intel Quartus Prime bin folder to path
    if [ -d $HOME/intelFPGA_pro/21.2/qprogrammer/quartus/bin ]; then
        PATH="$PATH:$HOME/intelFPGA_pro/21.2/qprogrammer/quartus/bin"
    fi
    # Add Quantum Leaps (QP state machine framework) bin folder to path
    if [ -d /workspace/tools/qp/qm/bin ]; then
        PATH="$PATH:/workspace/tools/qp/qm/bin"
    fi
fi

