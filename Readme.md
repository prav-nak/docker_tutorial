# Tutorial on commonly used features in docker

# Table of Contents
1. [chroot](#chroot)
2. [Docker](#docker)

chroot
======
A chroot on Unix operating systems is an operation that changes the apparent root directory for the current running process and its children. A program that is run in such a modified environment cannot name (and therefore normally cannot access) files outside the designated directory tree. The modified environment is called a chroot jail.

docker
======


Finally through the use of dockerfiles we will 
1. set up ubuntu based linux dev environment
2. add a user with sudo permissions
3. install vim, git etc.
4. install ohmyzsh
5. mount a volume for ephimeral data storage


## Usage
0. Ensure you have docker installed and running
1. Clone this repo
2. Open terminal and run, `chmod +x build.sh`
3. And run `chmod +x run.sh`
4. Run `./build.sh`
5. Run `./run.sh`

Easy! This should give you a linux prompt for a user called "devuser" with password "p@ssword1". This user is a sudoer.

# If you wish to change the zsh theme, 

1. cd ~
2. sudo chmod +x installthemes.sh
3. ./installthemes.sh
4. Edit your .zshrc, and change the theme (I like agnoster)
5. Optionally capture it using docker commit (see https://winsmarts.com/snapshot-a-docker-container-20df59bbd473)

Rock on!