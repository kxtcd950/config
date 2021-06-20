# config
A repo containing (most) things necessary to bootsrap a new user home directory with useful enough "stuff".
Assumes python3 is installed, and that a suitably "huge" and current vim is present.
A new vim is best, compiled from the latest github sources.

Requires some python modules:

```
sudo apt install python3-pip
python3 -m pip install powerline-status powerline-gitstatus
```

Issue the commands:
```
CONFIGROOT=~/.config/user
mkdir -p ${CONFIGROOT}
git clone https://github.com/kxtcd950/config ${CONFIGROOT}/config
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
ln -s ${CONFIGROOT}/config/.vim/coc-settings.json .
cd ~
ln -s ${CONFIGROOT}/config/.vimrc .
ln -s ${CONFIGROOT}/config/.tmux.conf .
ln -s ${CONFIGROOT}/.dircolors .
ln -s ${CONFIGROOT}/.cvsignore .

```
Note that the supplied .cvsignore is suitable for use as a user .gitignore, this can be achieved by running the command:
```
git config --user core.excludesfile ~/.cvsignore
```

If you wish to add custom startup supplied (fzf, powerline, ssh agent support) to
your bash configuration, then issue:

```
echo 'source ${CONFIGROOT}/config/.bashrc-custom' >> ~/.bashrc
```

To add a git-aware powerline configuration:
```
mkdir -p ~/.config
cd ~/.config
ln -s ${CONFIGROOT}/config/powerline .
```

Also, worth noting for powerline use: you'll need a terminal which is using a font that has the powerline symbols available.  These are available on the internet, I recommend using "DejaVu Sans Mono for Powerline" on both Linux and Windows.  Instructions for installation are available with the fonts themselves.
