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
ln -s ${CONFIGROOT}/config/.vim/bundle/all/* .
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
ln -s ${CONFIGROOT}/config/clangd .config/clangd

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

To use the pre-canned diff and merge tool integration for meld and git, add:
```
[include]
   path = ${CONFIGROOT}/config/.gitconfig-include
```
to your ~/.gitconfig file; this will use the fragment in the repo for git's configuration.  This sets up the meld tool as the
mergetool, difftool and uses the $LOCAL $BASE $REMOTE three window split.  Note that the path to the file must be the expansion
of ${CONFIGROOT}, rather than the literal text ${CONFIGROOT}.
This gitconfig fragment also makes the git lg2 command available, which is a highly customised variant of "git log" as well as
making the .cvsignore file present in the repository a user-global .gitignore file.  .cvsignore was chosen as the filename
because other tools will use this file name for the same purpose as git would use .gitignore, but git can be configured to use
this filename too.
