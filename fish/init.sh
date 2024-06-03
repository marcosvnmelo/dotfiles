#!/usr/bin/bash

echo '*****************************************'
echo '*         Installing fish shell         *'
echo '*****************************************'

# Install fish shell

sudo apt-add-repository ppa:fish-shell/release-3 -y

sudo apt update -y && sudo apt upgrade -y

sudo apt install fish -y

sudo chsh -s /usr/bin/fish "$USER"

# Create symbolic link for fish configuration file

mkdir -p "$HOME"/.config/fish

ln -s "$HOME"/.dotfiles/fish/config.fish "$HOME"/.config/fish/config.fish

# Install starship prompt

curl -sS https://starship.rs/install.sh | sh -s -- -y

ln -s "$HOME"/.dotfiles/fish/starship.toml "$HOME"/.config/starship.toml

# Install fisher

fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# Install fish plugins

while read -r plugin <"$PWD"/fish/plugins; do
	if [[ $plugin == \#* ]]; then
		continue
	fi

	fish -c "fisher install $plugin"
done

fish -c "nvm install lts"
