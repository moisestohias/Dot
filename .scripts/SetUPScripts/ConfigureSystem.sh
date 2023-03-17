#!/usr/bin/env bash

echo "Have you updated your system? Y(Yes)/N(No)"
read answer
if [ "$answer" == "yes" ] || [ "$answer" == "Y" ] || [ "$answer" == "y" ]; then
  echo "System is up to date."
elif [ "$answer" == "No" ] || [ "$answer" == "N" ] || [ "$answer" == "n" ]; then
  echo "Do you want to update your system now?  Y(Yes)/N(No)"
  read answer
  elif [ "$answer" == "Yes" ] || [ "$answer" == "Y" ] || [ "$answer" == "y" ]; then
    sudo apt update -y && sudo apt upgrade -y
else 
  echo "Answer must be Y or N"
fi

if [[ -d ~/.local/bin/ && -d ~/.local/share/applications/ ]] ; then
    echo "Proceeding .."
else
    echo "Creating diretories to store app bins"
    mkidr ~/.local/bin/
    mkidr ~/.local/share/applications/
fi


# qbittorrent latest
# sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt-add-repository ppa:fish-shell/release-3


sudo apt install -y curl wget apt-transport-https ca-certificates software-properties-common
sudo apt install -y fish git bat sxiv cmus xclip zathura yt-dlp ffmpeg mpv  ranger transmission-cli imagemagick ffmpegthumbnailer jq fzf ripgrep fd-find


# NeoVIM
# sudo apt install -y luajit
sudo snap install --edge nvim --classic


# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

wget https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip
mv pup_v0.4.0_linux_amd64.zip ~/.local/bin
unzip ~/.local/bin/pup_v0.4.0_linux_amd64.zip
rm ~/.local/bin/pup_v0.4.0_linux_amd64.zip


# Tweaks, shell-extension
sudo apt install gnome-shell-extensions # gnome-tweaks dconf-editor

# pip
# sudo apt install -y python3-pip
# python3 -m pip install --user --upgrade pip

# # Screen annotation software.
# sudo apt install gromit-mpx

# Qemu/KVM/Virt-Manager
# sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

