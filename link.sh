#!/bin/bash

cd ~ # goto home directory

rm -i .bashrc
rm -i .bash_profile
rm -i .vimrc
rm -i .vim
rm -i .tmux
rm -i .tmux.conf
rm -i .ctags

ln -s ~/dotfiles/.bashrc .
ln -s ~/dotfiles/.bash_profile .
ln -s ~/dotfiles/.vimrc .
ln -s ~/dotfiles/.vim .
ln -s ~/dotfiles/.tmux .
ln -s ~/dotfiles/.tmux.conf .
ln -s ~/dotfiles/.ctags .
