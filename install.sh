#!/usr/bin/env bash

set -e
set -u
set -o pipefail

REPO_URL="https://github.com/Xitonight/HomeRowMods"
INSTALL_DIR=${1:-"$HOME/.homerowmods"}
CONFIG_DIR="$HOME/.config/kanata/kanata.kbd"
SERVICE_DIR="$HOME/.config/systemd/user/kanata.service"

clone_repo() {
  if [ -d "$INSTALL_DIR" ]; then
    echo "Updating Matuvim..."
    git -C "$INSTALL_DIR" pull
  else
    echo "Cloning Matuvim..."
    git clone "$REPO_URL" "$INSTALL_DIR"
  fi
}

stow_files() {
  if [ -e "$CONFIG_DIR" ]; then
    if [ ! -L "$CONFIG_DIR" ] || [ "$(readlink -f "$CONFIG_DIR")" != "$INSTALL_DIR/dots/.config/kanata/kanata.kbd" ]; then
      backup="$CONFIG_DIR".bak
      if [ ! -e "$backup" ]; then
        cp "$CONFIG_DIR" "$backup"
      fi
      rm -rf "$CONFIG_DIR"
    fi
  fi
  if [ -e "$SERVICE_DIR" ]; then
    if [ ! -L "$SERVICE_DIR" ] || [ "$(readlink -f "$SERVICE_DIR")" != "$INSTALL_DIR/dots/.config/kanata/kanata.kbd" ]; then
      backup="$SERVICE_DIR".bak
      if [ ! -e "$backup" ]; then
        cp "$SERVICE_DIR" "$backup"
      fi
      rm -rf "$SERVICE_DIR"
    fi
  fi
  stow --target="$HOME" --dir="$INSTALL_DIR" dots
}

setup_kanata() {
  if [[ -z "$(getent group uinput)" ]]; then
    sudo groupadd uinput
  fi

  sudo usermod -aG input "$USER"
  sudo usermod -aG uinput "$USER"

  if [ ! -e /etc/udev/rules.d/99-input.rules ]; then
    sudo touch /etc/udev/rules.d/99-input.rules
    echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/99-input.rules
  fi

  sudo udevadm control --reload-rules && sudo udevadm trigger

  sudo modprobe uinput

  systemctl --user daemon-reload
  systemctl enable --now --user kanata.service
}

clone_repo
stow_files
setup_kanata
