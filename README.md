## install
```bash
cd ~ # goto home directory
git clone https://github.com/talmobi/dotfiles
ln -s ~/dotfiles/.bashrc .
ln -s ~/dotfiles/.vimrc .
ln -s ~/dotfiles/.vim .
ln -s ~/dotfiles/.tmux .
ln -s ~/dotfiles/.tmux.conf .
```

## install vim plugins
```bash
vim
```

```vim
:PlugInstall
```

## install tmux plugins
```vim
cd ~/dotfiles
./install-tpm.sh
```

## vim tips
double tap `s` key in normal mode to reload your ~/.vimrc

// TODO quickfix fips
// TODO quicfix fips

## tmux tips
