#!/bin/bash
# https://github.com/prosoitos/sublime-installer/blob/master/sublime_installer.sh


# check if user is root
echo "Sublime Installer..."
if [ $(whoami) == "root" ] ; then
  echo -e "\nThis script must be run as a normal user with sudo privileges\n"
  exit 1
fi


# Make sure it's Linux system
if [[ $MACHTYPE = *linux* ]] ; then
  distro=$(cat /etc/issue | grep '\s' | head -n 1 | awk '{print $1}')
  echo -e "\nDetected distro: $distro\n"
  if [[ $distro = 'Ubuntu'  ]] ; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime-text
    echo "Downloading setting & key bindings..." 

    # If this fails ensure apt is set up to work with https sources:
    # sudo apt-get install apt-transport-https
  elif [[ $distro -eq "Manjaro" || $distro -eq "Arch" ]] ; then
    # Arch: pacman
    curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
    echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
    sudo pacman -Syu sublime-text
  elif [[ $distro -eq "Fedora" ]] ; then
    # Fedora: DNF
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    sudo dnf install sublime-text
  elif [ $distro -eq "Fedora"  ] ; then
    # CentOS: YUM
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    sudo yum install sublime-text
  else
    echo "\nYou distribution is not supported\n"
    exit 1
  fi
else 
  echo "Only linux systems are supported"
fi


git clone https://github.com/moisestohias/SublimeSettings.git
rm SublimeSettings/.git -rf
mv SublimeSettings/* ~/.config/sublime-text/Packages/User/
rm SublimeSettings/ -rf
