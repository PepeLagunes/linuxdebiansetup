#!/bin/bash

sudo apt install -y gpg

if  test -f "/etc/apt/keyrings/gierens.gpg"; then
    echo "gpg is installed"
else
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list 
fi
sudo apt update 
sudo apt upgrade -y

if ! command -v git &> /dev/null  ##Aqui verificamos si git se encuentra instalado, si no lo instala.
then
    sudo apt install git
fi

sudo apt install zsh curl ripgrep eza bat -y
sudo chsh pplagarto -s /bin/zsh 

curl -sS https://starship.rs/install.sh > $HOME/starship-install.sh
if [ $? -eq 0 ]; then
  # Make the script executable
  chmod +x $HOME/starship-install.sh
  # Run the installation script
  $HOME/starship-install.sh -y
  # Cleanup (optional, removes downloaded script)
  rm $HOME/starship-install.sh
  echo "Starship installation complete!"
else
  echo "Error downloading Starship installation script."
fi

cp .zshconfig $HOME/.zshrc

echo "Final step of the installation"

if test -d "/home/pplagarto/.oh-my-zsh"; then
    echo "ohmyzsh is already installed"
    zsh 
else
    curl -sS https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh > $HOME/ohmyzsh-install.sh
    if [ $? -eq 0 ]; then
        chmod +x $HOME/ohmyzsh-install.sh
        $HOME/ohmyzsh-install.sh 
        rm $HOME/ohmyzsh-install.sh
        echo "Ohmyzsh was succesfully installed"
    else
        echo "Ohmyzsh was not succesfully installed on the scrip"
        exit
    fi
fi