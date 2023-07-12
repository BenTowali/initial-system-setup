#!/bin/sh

# Configure pacman
doas sed -i "/UseSyslog/,/Color/"'s/^#//' /etc/pacman.conf
doas sed -i "/VerbosePkgLists/,/ParallelDownloads/"'s/^#//' /etc/pacman.conf
doas sed -i "/ParallelDownloads/"'a ILoveCandy' /etc/pacman.conf
doas sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Prerequisites
doas pacman -S stow git zsh rustup autoconf automake binutils bison debugedit fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool m4 make patch pkgconf texinfo which unzip --noconfirm

# Dotfiles
git clone https://github.com/BenTowali/dotfiles.git
cd dotfiles
stow . -t /home/$(whoami)/

# Change Shell
doas touch /etc/zsh/zshenv
doas sed -i '$ a export XDG_DATA_HOME="$HOME"/.local/share' /etc/zsh/zshenv
doas sed -i '$ a export XDG_CONFIG_HOME="$HOME"/.config' /etc/zsh/zshenv
doas sed -i '$ a export XDG_STATE_HOME="$HOME"/.local/state' /etc/zsh/zshenv
doas sed -i '$ a export XDG_CACHE_HOME="$HOME"/.cache' /etc/zsh/zshenv
doas sed -i '$ a export ZDOTDIR="$HOME"/.config/zsh' /etc/zsh/zshenv
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /bin/zsh $USER

# Paru
## Install
rustup default stable
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -si
cd .. && rm -rf paru
## Configure
sudo sed -i "/AurOnly/"'s/^#//' /etc/paru.conf
sudo sed -i "/RemoveMake/"'s/^#//' /etc/paru.conf
sudo sed -i "/CleanAfter/,/UpgradeMenu/"'s/^#//' /etc/paru.conf
sudo sed -i "/NewsOnUpgrade/"'a BatchInstall' /etc/paru.conf
sudo sed -i "/BatchInstall/"'a SkipReview' /etc/paru.conf
sudo sed -i "/[bin]/"'s/^#//' /etc/paru.conf
sudo sed -i "/Sudo = doas/"'s/^#//'

# Wine
doas pacman -S wine-staging winetricks giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox --noconfirm

# Other Stuff
doas pacman -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-noto-nerd noto-fonts-emoji noto-fonts-cjk qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables libguestfs p7zip unrar trash-cli xorg lazygit nodejs gamemode sx glow feh xclip neofetch openssh ssh-tools pipewire pipewire-pulse fcitx fcitx-configtool fcitx-im zathura zathura-pdf-poppler scrcpy rofi redshift picom mpv discord keepassxc obsidian sxiv nitrogen lf steam awesome polybar alacritty --noconfirm

# AUR
paru -S anki-bin an-anime-game-launcher-bin xdg-ninja vieb-bin spotify raindrop brave-bin --noconfirm

# Davinci
# doas pacman -U https://archive.archlinux.org/packages/q/qt5-webkit/qt5-webkit-5.212.0alpha4-18-x86_64.pkg.tar.zst --noconfirm

# After Config
## Libvirt
sudo systemctl enable libvirtd.service --now
sudo sed -i "/unix_sock_group/"'s/^#//' /etc/libvirt/libvirtd.conf
sudo sed -i "/unix_rw_perms/"'s/^#//' /etc/libvirt/libvirtd.conf
sudo usermod -aG audio,kvm,libvirt $(whoami)
sudo systemctl restart libvirtd.service
