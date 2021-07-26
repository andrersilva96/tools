# Gnome Tweaks
sudo apt-get install -y gnome-tweak-tool

# Flat Remix Theme
sudo add-apt-repository ppa:daniruiz/flat-remix
sudo apt update
sudo apt install -y flat-remix flat-remix-gnome flat-remix-gtk

# Nerd Fonts
curl -sS https://webinstall.dev/nerdfont | bash

# lsd
curl -sS https://webinstall.dev/lsd | bash
alias ls="lsd"

echo "-------------------------------"
echo "If your ubuntu witch output try https://askubuntu.com/questions/1181896/wrong-default-audio-device"
echo "-------------------------------"

echo "# Show git branch name
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi" >> ~/.bashrc
