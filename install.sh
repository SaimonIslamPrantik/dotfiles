#!/bin/bash

# Ask user if they want to install yay
read -p "Do you want to install yay? (y/n): " install_yay

if [[ "$install_yay" == "y" || "$install_yay" == "Y" ]]; then
    # yay installation
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

# List of packages to install
packages=(
    nano
    sddm
    curl
    wget
    git
    bauh
    base-devel
    hyprland
    alacritty
    rofi
    nautilus
    copyq
    slurp
    grim
    hyprlock
    mako
    waterfox-bin
    gnome-system-monitor
    pavucontrol
    blueman
    waybar
    dunst
    swww
    bibata-cursor-theme
    neofetch
    oh-my-posh
    feh
    mpv
    vlc
)

# Prompt user for confirmation
echo "The following packages will be installed:"
for package in "${packages[@]}"; do
    echo "- $package"
done

read -p "Do you want to proceed with the installation? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    # Update package list and install packages using yay
    yay -S --needed --y "${packages[@]}"
    
    # Print completion message
    echo "All packages have been installed successfully."
else
    echo "Installation aborted by the user."
fi

#essential dependencies
sudo pacman -Syu sddm qt5-graphicaleffects qt5-svg qt5-quickcontrols2

#mkdir
mkdir  ~/.config/hypr/
mkdir  ~/.config/waybar/
mkdir  ~/.config/rofi/
mkdir  ~/.config/alacritty/
mkdir  ~/.config/neofetch/
mkdir  ~/.config/hyprlock/
mkdir ~/Downloads/
mkdir ~/.fonts/

#wallpaper download
wget -O ~/Downloads/walp.jpg "https://raw.githubusercontent.com/TeenAgeTechBD/wallpapers/99657ef17ef47e189e8dcbcc0c3608f7fcc17718/wallpapers/walp.jpg"

#rofi configuration dump
rofi -dump-config > ~/.config/rofi/config.rasi

#hyprland configuration copy
sudo cp hyprland.conf ~/.config/hypr/

#waybar configuration copy
sudo cp -r waybar/* ~/.config/waybar/

#rofi configuration copy
sudo cp -r rofi/* ~/.config/rofi/

#alacritty configuration copy
sudo cp alacritty.toml ~/.config/alacritty/

#cursor theme copy
sudo cp .Xresources ~/

#font installation
sudo cp -r fonts/* ~/.fonts/

#bashrc copy
sudo cp .bashrc ~/

#copy poshthemes
sudo cp -r poshthemes ~/

#hyprlock configuration copy
sudo cp hyprlock/* ~/.config/hypr/

#sddm configuration copy
git clone https://github.com/PROxZIMA/boo-sddm.git
cd boo-sddm
sudo cp -r boo /usr/share/sddm/themes
cd ..
sudo cp sddm.conf /etc/

#neofetch configuration copy
sudo cp -r neofetch/* ~/.config/neofetch/

#enable services
sudo systemctl enable sddm
sudo systemctl start sddm
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

echo "All configurations have been copied successfully."
echo "Restarting"
echo "3"
echo "2"
echo "1"
sudo reboot