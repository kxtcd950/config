# config
A repo containing (most) things necessary to bootsrap a new user home directory with useful enough "stuff".
Assumes python3 is installed, and that a suitably "huge" and current vim is present.
Requires some python modules:

```
sudo apt install python3-pip
python3 -m pip install powerline-status powerline-gitstatus
```

Issue the commands:
```
CONFIGROOT=~/.config/user
mkdir -p ${CONFIGROOT}
cd ${CONFIGROOT}/config

git submodule init
git submodule update
```

This will initialise then update the contents of the various submodules which are used to manage vim plugins, etc.

You'll then need to link the submodules and config files into the correct places:

```
mkdir -p ~/.vim/pack/bundle/all
cd ~/.vim/pack/bundle/all
ln -s $(CONFIGROOT)/config/.vim/bundle/all/* .
mkdir ../start
cd ../start
ln -s ../all/* .
cd ~/.vim
ln -s ${CONFIGROOT}/config/coc-settings.json .
cd ~
ln -s ${CONFIGROOT}/config/.vimrc .
ln -s ${CONFIGROOT}/config/.tmux.conf .
ln -s ${CONFIGROOT}/.dircolors .
```
If you wish to replace your bashrc, (this bashrc contains a standard Ubuntu contents) then also issue:

```
rm ~/.bashrc
ln -s ${CONFIGROOT}/config/.bashrc .
```