#!/bin/bash

#yay installation
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# List of packages to install
packages=(
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
    oh-my-posh
    feh
)

#enable services
sudo systemctl enable sddm
sudo systemctl start sddm
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Prompt user for confirmation
echo "The following packages will be installed:"
for package in "${packages[@]}"; do
    echo "- $package"
done

read -p "Do you want to proceed with the installation? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    # Update package list and install packages using yay
    yay -S --needed "${packages[@]}"
    
    # Print completion message
    echo "All packages have been installed successfully."
else
    echo "Installation aborted by the user."
fi

#wallpaper download
wget -O ~/Downloads/walp.jpg "https://raw.githubusercontent.com/TeenAgeTechBD/wallpapers/99657ef17ef47e189e8dcbcc0c3608f7fcc17718/wallpapers/walp.jpg"

#rofi configuration dump
rofi -dump-config > ~/.config/rofi/config.rasi

#hyprland configuration copy
sudo cp "$(dirname "$0")/hyprland.conf" ~/.config/hypr/

#waybar configuration copy
sudo cp -r "$(dirname "$0")/waybar/"* ~/.config/waybar/

#rofi configuration copy
sudo cp "$(dirname "$0")/rofi/"* ~/.config/rofi/

#alacritty configuration copy
sudo cp "$(dirname "$0")/alacritty.toml" ~/.config/alacritty/

#cursor theme copy
sudo cp "$(dirname "$0")/.Xresources" ~/

#font installation
sudo cp "$(dirname "$0")/fonts/"* ~/.fonts/

#bashrc copy
sudo cp "$(dirname "$0")/.bashrc" ~/

#copy poshthemes
sudo cp -r "$(dirname "$0")/poshthemes/"* ~/.poshthemes/

#hyprlock configuration copy
sudo cp "$(dirname "$0")/hyprlock/"* ~/.config/hypr/

#sddm configuration copy
git clone https://github.com/PROxZIMA/boo-sddm.git
cd boo-sddm
sudo cp -r boo /usr/share/sddm/themes
cd ..
sudo cp "$(dirname "$0")/sddm.conf" /etc/

echo "All configurations have been copied successfully."
echo "Restarting"
echo "3"
echo "2"
echo "1"
sudo reboot