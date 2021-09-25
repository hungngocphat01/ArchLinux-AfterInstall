#!/usr/bin/bash
set +x

echo WARNING: YAY must be installed prior to executing this file!

# Install all pacman packages
echo ============= INSTALL PACMAN PACKAGES =============
pacman_pkgs=(
	zsh
	base-devel
	vim
	pandoc
	git
)

sudo pacman --noconfirm -Sy $(echo $pacman_pkgs)

# Change shell 
chsh -s $(which zsh) $LOGNAME

echo ============= CONFIGURE GIT =============
# Configure git 
git config --global user.name hungngocphat01
git config --global user.email hungngocphat01@gmail.com
git config credential.helper store

# Configure vim
echo ============= CONFIGURE ZSH ALIAS =============
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

# Install neccessary yay packages
yay_pkgs=(
	chrome-gnome-shell-git
	gnome-shell-extension-dash-to-dock-gnome40-git
	heroku-cli-bin
	ibus-bamboo
	kooha
	microsoft-edge-dev-bin
	miniconda3
	obsidian-appimage
	ocs-url
	onlyoffice-bin
	spotify
	visual-studio-code-bin
	vmware-workstation
)
yay --nointeract -S $(echo $yay_pkgs)

# Setup vmware
sudo modprobe -a vmw_vmci vmmon
sudo systemctl enable --now vmware.service vmware-networks.service

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i "s/ZSH_THEME=.*/ZSH_THEME='af-magic'/g"

echo ============= CONFIGURE ZSH ALIAS =============
# Configure aliases
cat >> ~/.zshrc <<EOF
export TERM=xterm-256color
alias rm='rm -i'
alias open='xdg-open'
export LANG=en_US.UTF-8
EOF

set -x
