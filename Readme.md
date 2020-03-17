# Tutorial on commonly used features in docker

# Table of Contents
1. [chroot](#chroot)
2. [Docker](#docker)

## chroot
=========
Please refer to [Linux / Unix: chroot Command Examples](https://www.cyberciti.biz/faq/unix-linux-chroot-command-examples-usage-syntax/) for more info on this. 

A chroot on Unix operating systems is an operation that changes the apparent root directory for the current running process and its children. A program that is run in such a modified environment cannot name (and therefore normally cannot access) files outside the designated directory tree. The modified environment is called a chroot jail.


chroot command examples
In this example, build a mini-jail for testing purpose with bash and ls command only. First, set jail location using mkdir command:

```console
$ J=$HOME/jail
```
Create directories inside $J:

```console
$ mkdir -p $J
$ mkdir -p $J/{bin,lib64,lib}
$ cd $J
```

Copy /bin/bash and /bin/ls into $J/bin/ location using cp command:
```console
$ cp -v /bin/{bash,ls} $J/bin
```

Copy required libs in $J. Use ldd command to print shared library dependencies for bash:
```console
$ ldd /bin/bash
```

Copy libs in $J correctly from the above output:
```console
$ cp -v /lib64/libtinfo.so.5 /lib64/libdl.so.2 /lib64/libc.so.6 /lib64/ld-linux-x86-64.so.2 $J/lib64/
```

Copy required libs in $J for ls command. Use ldd command to print shared library dependencies for ls command:
```console
$ ldd /bin/ls
```

Finally, chroot into your new jail:
```console
$ sudo chroot $J /bin/bash
```

A chrooted bash and ls application is locked into a particular directory called $HOME/$J and unable to wander around the rest of the directory tree, and sees that directory as its “/” (root) directory. This is a tremendous boost to security if configured properly. 


![Pictorial description](https://media.geeksforgeeks.org/wp-content/uploads/chroot-command.jpg)


## docker
=========


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