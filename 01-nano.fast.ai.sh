#!/bin/bash
# meant to be called as sudo
apt update
apt upgrade -y

# prep swap for extended memory, 4G aint enough
fallocate -l 8G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" | tee --append /etc/fstab > /dev/null

# cleanup stuff we don't need and takes ram
# this will eventually increase, one hopes
systemctl enable multi-user.target
systemctl set-default multi-user.target
apt -y purge whoopsie
apt -y purge unattended-upgrades
apt -y purge modemmanager

# dependencies
apt install -y python3-dev python3-pip
python3.6 -m pip install --upgrade cython
apt install -y scipy
apt install -y libjpeg-dev zlib1g-dev
apt install -y nodejs npm
apt install -y python3-matplotlib
apt install -y libopenblas-dev
pip3 install spacy==2.0.18
pip3 install numpy==1.17.5

# install PyTorch
# Check the nvidia forum for updates, the community is great, get involved
wget https://nvidia.box.com/shared/static/ncgzus5o23uck9i5oth2n8n06k340l6k.whl -O torch-1.4.0-cp36-cp36m-linux_aarch64.whl
pip3 install numpy torch-1.4.0-cp36-cp36m-linux_aarch64.whl
rm torch-1.4.0-cp36-cp36m-linux_aarch64.whl

# install Fast.ai
pip3 install fastai

# install jupyter
pip3 install jupyter jupyterlab

reboot

