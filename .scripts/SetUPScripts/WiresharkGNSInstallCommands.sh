# Wireshark latest, if you have it already installed it will update.
sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt update
sudo apt install wireshark
# GNS3
sudo add-apt-repository ppa:gns3/ppa
sudo apt install gns3-gui gns3-server
# IOU
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install gns3-iou

