#!/bin/bash

# Array of all dependencies to install

dependencies=("git" "wget" "curl" "yarn" "python3" "zsh" "terminator" "p7zip-full" "p7zip-rar" "qtermina")



# Function to install dependencies

function install_dependencies() {
	for package in "${dependencies[@]}"; do
  if ! command -v "$package" >/dev/null 2>&1 && ! dpkg -s "$package" >/dev/null 2>&1; then
    echo "$package instalado"
    # Install the package here
    sudo apt -y install "$package"
    sleep 1
  else
    echo "$package ya está instalado"
    sleep 1
  fi
done
}

# Function to install oh-my-zsh

function install_oh_my_zsh() {
  if [ ! -d ~/.oh-my-zsh ]; then
    echo "Instalando oh-my-zsh"
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" > /dev/null 2>&1
    echo "Oh my zsh instalado correctamente"
  else
    echo "Oh my zsh ya está instalado"
  fi
}

function install_node() {
  if ! command -v "node" >/dev/null 2>&1; then
    echo "Instalando node"
    curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\
    sudo apt-get install -y nodejs
    echo "Node instalado correctamente"
  else
    echo "Node ya está instalado"
  fi
}

function install_vimplug() {
  if [ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    echo "Instalando vimplug"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > /dev/null 2>&1
    echo "Vimplug instalado correctamente"
    sleep 1
  else
    echo "Vimplug ya está instalado"
    sleep 1
  fi
}

function install_nvim() {
  if ! command -v "nvim" >dev/null 2>&1; then
    echo "Actualizando Neovim"
    sudo apt-add-repository ppa:neovim-ppa/stable &&\
    sudo apt update &&\
    sudo apt install neovim
    echo "Neovim instalado correctamente"
    sleep 1
  else
    echo "Neovim ya está instalado"
    sleep 1
  fi
}

function install_fzf() {
  if [ ! -d ~/.fzf ]; then
    echo "Instalando fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
    echo "Fzf instalado correctamente"
    sleep 1
  else
    echo "Fzf ya está instalado"
    sleep 1
  fi
}

function install_fastsyntaxhighlighting() {
  if [ ! -d $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting ]; then
    echo "Instalando fastsyntaxhighlighting"
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    echo "Fastsyntaxhighlighting instalado correctamente"
    sleep 1
  else
    echo "Fastsyntaxhighlighting ya está instalado"
    sleep 1
  fi
}

function install_autosuggestions() {
  if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    echo "Instalando autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "Autosuggestions instalado correctamente"
    sleep 1
  else
    echo "Autosuggestions ya está instalado"
    sleep 1
  fi
}

function install_caskaydia_font() {
  if ! ls /usr/share/fonts/Caskaydia* > /dev/null 2>&1; then
    echo "Instalando Caskaydia Font"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/CascadiaCode.zip
    7z x CascadiaCode.zip
    sudo mv *.otf /usr/share/fonts
    sudo fc-cache -fv
    echo "Caskaydia Font instalado correctamente"
    rm CascadiaCode.zip
    sleep 1
  else
    echo "Caskaydia Font ya está instalado"
    sleep 1
  fi
} 

function install_zshrc() {
  if [ ! -f $HOME/.zshrc ]; then
    echo "Instalando zshrc"
    wget "AQUITENGOQUEPONERELWGETPARAMIARCHIVODEZSHRC" -O $HOME/.zshrc
  else
    echo "Zshrc ya está instalado"
  fi
}

function install_powerlevel10k() {
  if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    echo "Instalando powerlevel10k"
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  else
    echo "Powerlevel10k ya está instalado"
  fi

install_dependencies
install_oh_my_zsh
install_node
install_vimplug
install_fzf
#install_nvim
install_fastsyntaxhighlighting
install_autosuggestions 
install_caskaydia_font
install_zshrc
install_powerlevel10k
