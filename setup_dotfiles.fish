#!/bin/fish
# Pre-requesite programs:
#   git, curl, nvim, bash, python-dev, python3-dev, python3-pip
# Other useful apps:
#   apt install:
#       htop tmux cargo nfs-common python3-pynvim libssl-dev
#   rustup install:
#
#   cargo install:
#       fd-find rigprep cargo-msrv cargo-update cargo-binutils clippy hexyl cargo-xbuild cargo-generate

# Global list of config files to symlink
set dot_files '.bashrc' '.bash_aliases' '.git-prompt.sh' '.config/nvim/init.lua' '.tmux.conf' '.config/fish/functions/c.fish' '.config/fish/functions/deb_update.fish' '.config/fish/functions/fish_prompt.fish' '.config/fish/functions/gb.fish' '.config/fish/functions/gl.fish' '.config/fish/functions/glo.fish' '.config/fish/functions/ll.fish' '.config/fish/functions/rust_check_all.fish' '.config/fish/functions/rust_check_clean.fish' '.config/fish/functions/rust_check.fish'

function set_dot_files
	# An example of how to download this repo...
	#echo git clone https://github.com/Egod3/.dotFiles.git .dotFiles

	# Check if the nvim config path exists if it does not create it
	set NVIM_CONF_DIR "$HOME/.config/nvim"
	if test ! -d "$NVIM_CONF_DIR"
		mkdir -vp "$NVIM_CONF_DIR"
	end

	for file in $dot_files
		# If there is a .bashrc file locally in ~/ then move it to ~/.bashrc.bak
		# and add a symlink to ~/.dotFiles/.bashrc
		if test $file = ".bashrc"
			if test ! -L "$HOME/.bashrc"
				if test -f "$HOME/.bashrc"
					mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
					echo "mv $HOME/.bashrc $HOME/.bashrc.bak"
				end
				ln -s $HOME/.dotFiles/$file $HOME/$file
				echo ln -s $HOME/.dotFiles/$file $HOME/$file
			end
		else if test ! -f $file
			ln -s $HOME/.dotFiles/$file $HOME/$file
			echo ln -s $HOME/.dotFiles/$file $HOME/$file
		end
	end

	#for i in "${dot_files[@]}"
	#d	## If there is a .bashrc file locally in ~/ then move it to ~/.bashrc.bak
	## and add a symlink to ~/.dotFiles/.bashrc
	#if [[ $i == ".bashrc" ]]; then
	#  if [[ ! -L "$HOME/.bashrc" ]]; then
	#    if [[ -f "$HOME/.bashrc" ]]; then
	#      mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
	#      echo "mv $HOME/.bashrc $HOME/.bashrc.bak"
	#    fi
	#    ln -s $HOME/.dotFiles/$i $HOME/$i
	#    echo ln -s $HOME/.dotFiles/$i $HOME/$i
	#  fi
	#elif [[ ! -f $i ]]; then
	#  if [[ $i == ".config/nvim/init.lua" ]]; then
	#    ln -s $HOME/.dotFiles/$i $HOME/.config/nvim/init.lua
	#    echo ln -s $HOME/.dotFiles/$i $HOME/.config/nvim/init.lua
	#  else
	#    ln -s $HOME/.dotFiles/$i $HOME/$i
	#    echo ln -s $HOME/.dotFiles/$i $HOME/$i
	#  fi
	#fi
	#done
end

# Check if the config files in dot_files array above
# are symlinks if so remove them so when we run set_dot_files
# above it will test it
function rm_dot_files
	for i in $dot_files
		if test -L "$HOME/$i"
			echo "rm -v $HOME/$i"
			#rm -v $HOME/$i
		end
	end
end

if test "$argv" = "test"
	echo "Test flag detected, removing config files to test set_dot_files()"
	pushd $HOME/
	rm_dot_files
	popd
	echo
end

pushd $HOME/
set_dot_files
popd
