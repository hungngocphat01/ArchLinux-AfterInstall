#!/usr/bin/bash
set +x

echo WARNING: YAY must be installed prior to executing this file!

echo ============= DISABLE SUDO TIMEOUT =============
echo 'Defaults passwd_timeout=0' | sudo tee -a /etc/sudoers


# Install all pacman packages
echo ============= INSTALL PACMAN PACKAGES =============
pacman_pkgs=(
	zsh
	base-devel
	vim
	pandoc
	git
	docker
)

sudo pacman --noconfirm -Sy ${pacman_pkgs[@]}

echo ============= CONFIGURE GIT =============
# Configure git 
git config --global user.name hungngocphat01
git config --global user.email hungngocphat01@gmail.com
git config credential.helper store

# Configure vim
echo ============= CONFIGURE VIM =============
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cat > ~/.vimrc <<EOF
set number 
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
call plug#end()

" Config for lightline
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
set noshowmode
EOF

echo ============= INSTALL YAY PACKAGES =============
sudo chown -R $LOGNAME ~/.gnupg/
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg

echo keyserver hkp://keyserver.ubuntu.com | sudo tee -a /etc/pacman.d/gnupg/gpg.conf

# Install neccessary yay packages
yay_pkgs=(
	chrome-gnome-shell-git
	gnome-shell-extension-dash-to-dock-gnome40-git
	heroku-cli-bin
	ibus-bamboo
	microsoft-edge-dev-bin
	miniconda3
	obsidian-appimage
	ocs-url
	onlyoffice-bin
	spotify
	visual-studio-code-bin
	vmware-workstation
	ibus-mozc-ut2
)
yay --noconfirm -S ${yay_pkgs[@]}

echo ============= VMWARE =============
# Setup vmware
sudo modprobe -a vmw_vmci vmmon
sudo systemctl enable --now vmware.service vmware-networks.service

echo ============= ZSH =============
# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i "s/ZSH_THEME=.*/ZSH_THEME='af-magic'/g" ~/.zshrc

# Configure aliases
cat >> ~/.zshrc <<EOF
export TERM=xterm-256color
alias rm='rm -i'
alias open='xdg-open'
export LANG=en_US.UTF-8
EOF

# Configure docker 
echo ============= DOCKER =============
groups
sudo systemctl enable --now docker
sudo usermod -aG docker $LOGNAME
newgrp docker

echo ============= UPDATE SYSTEM =============
sudo pacman --noconfirm -Syu

echo ============= !!!PLEASE ENABLE SUDO TIMEOUT!!! =============
echo ============= YOU SHOULD REBOOT NOW =============
set -x
