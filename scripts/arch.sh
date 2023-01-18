#!/bin/sh

# Configure Pacman to the way I like it
sudo sed -i "/UseSyslog/,/Color/"'s/^#//' /etc/pacman.conf
sudo sed -i "/VerbosePkgLists/,/ParallelDownloads/"'s/^#//' /etc/pacman.conf
sudo sed -i "/ParallelDownloads/"'a ILoveCandy' /etc/pacman.conf
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Update First
sudo pacman -Syu

# Install Packages
sudo pacman -S nodejs lazygit p7zip pipewire lib32-pipewire pipewire-pulse pipewire-alsa pipewire-jack base-devel zsh feh xclip unzip tar git curl xdelta3 cabextract libnotify gamemode glow qbittorrent wine winetricks openssh ssh-tools noto-fonts-cjk noto-fonts-emoji giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox alacritty vivaldi obsidian discord mpv keepassxc htop neofetch neovim sxiv steam zathura-pdf-poppler zathura nvidia nvidia-utils

# Install AUR Helper && Packages
sudo pacman -S rustup
rustup default stable
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd .. && rm -rf paru

paru -S tuir raindrop lf-bin xdg-ninja ani-cli an-anime-game-launcher-bin heroic-games-launcher-bin spotify grapejuice-git
 
# User Scripts
## Zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
## Packer (NVim package manager)
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
## PNPM
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Configure AUR helper
sudo sed -i "/AurOnly/"'s/^#//' /etc/paru.conf
sudo sed -i "/RemoveMake/,/SudoLoop/"'s/^#//' /etc/paru.conf
sudo sed -i "/CleanAfter/,/UpgradeMenu/"'' /etc/paru.conf
sudo sed -i "/NewsOnUpgrade/"'a BatchInstall' /etc/paru.conf
sudo sed -i "/BatchInstall/"'a SkipReview' /etc/paru.conf

# Post Configuration
## Set Variables in ZSH
sudo touch /etc/zsh/zshenv
sudo sed -i '$ a export XDG_DATA_HOME="$HOME"/.local/share' /etc/zsh/zshenv
sudo sed -i '$ a export XDG_CONFIG_HOME="$HOME"/.config' /etc/zsh/zshenv
sudo sed -i '$ a export XDG_STATE_HOME="$HOME"/.local/state' /etc/zsh/zshenv
sudo sed -i '$ a export XDG_CACHE_HOME="$HOME"/.cache' /etc/zsh/zshenv
sudo sed -i '$ a export ZDOTDIR="$HOME"/.config/zsh' /etc/zsh/zshenv

## Change Shell
chsh $USER -s /bin/zsh
