#!/bin/bash

cd ~ # goto home directory

rm -i .bashrc
rm -i .vimrc
rm -i .vim
rm -i .tmux
rm -i .tmux.conf

ln -s ~/dotfiles/.bashrc .
ln -s ~/dotfiles/.vimrc .
ln -s ~/dotfiles/.vim .
ln -s ~/dotfiles/.tmux .
ln -s ~/dotfiles/.tmux.conf .
