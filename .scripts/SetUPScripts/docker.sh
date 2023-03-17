# Docker
# start by deleting existing version
sudo apt remove docker docker-engine docker.io
# Following packages are required:
sudo apt-get install apt-transport-https ca-certificates curl  software-properties-common
# Import the official Docker GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add the appropriate repo:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Install Docker
sudo apt update
sudo apt install docker-ce
# Add Your username to the following groups
ubridge libvirt kvm wireshark docker
# use “sudo usermod -aG group user_name” one group at a time, to add your user to each of those groups) Restart your user session by logging out and back in, or restarting the system.
