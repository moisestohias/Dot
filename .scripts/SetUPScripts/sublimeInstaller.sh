#!/bin/bash
# https://github.com/prosoitos/sublime-installer/blob/master/sublime_installer.sh


# check if user is root
echo "Sublime Installer..."
if [ $(whoami) == "root" ] ; then
  echo -e "\nThis script must be run as a normal user with sudo privileges\n"
  exit 1
fi


# Make sure it's Ubuntu distro
# Make sure it's Linux system
if [[ $MACHTYPE = *linux* ]] ; then
  distro=$(cat /etc/issue | grep '\s' | head -n 1 | awk '{print $1}')
  echo -e "\nDetected distro: $distro\n"
  if [[ $distro != 'Ubuntu'  ]] ; then
    echo -e "\nThis Sublime Installer works only Ubuntu\n"
    exit 1
  fi
fi

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
echo "Downloading setting & key bindings..." 

# If this fails ensure apt is set up to work with https sources:
# sudo apt-get install apt-transport-https

git clone https://github.com/moisestohias/SublimeSettings.git
rm SublimeSettings/.git -rf
mv SublimeSettings/* ~/.config/sublime-text/Packages/User/
rm SublimeSettings/ -rf
