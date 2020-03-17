# Table of Contents
1. [introduction](#introduction)
2. [chroot](#chroot)
3. [docker vs chroot](#docker%20vs%20chroot)
4. [docker lingo](docker%20lingo)
5. [mounting a volume](mounting%20%a%20volume)


## introduction
This repo is a collection of information from various resources on the web and stackoverflow that is aimed to better understand the docker utility. We being with the basic linux utility [chroot](https://www.cyberciti.biz/faq/unix-linux-chroot-command-examples-usage-syntax/), discuss how docker does more, define the lingo commonly used in docker and finally go through an example dockerfile to create ubuntu based linux dev environment. The dev env will check out a linux image, create a user with sudo privileges, install git features, install a popular shell (ohmyzsh) and finally we show how to mount a volume for persistent storage that is accessible from the containers. Remember that the default storage from a container is ephimeral.

## chroot
chroot command in Linux/Unix system is used to change the root directory. Every process/command in Linux/Unix like systems has a current working directory called root directory. It changes the root directory for currently running processes as well as its child processes. A process/command that runs in such a modified environment cannot access files outside the root directory. This modified environment is known as “chroot jail” or “jailed directory”.

![Pictorial description](https://media.geeksforgeeks.org/wp-content/uploads/chroot-command.jpg)

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


## docker vs chroot

Docker allows to isolate a process at multiple levels through namespaces:

1. mnt namespace provides a root filesystem (this one can be compared to chroot I guess)
2. pid namespace so the process only sees itself and its children
3. network namespace which allows the container to have its dedicated network stack
4. user namespace (quite new) which allows a non root user on a host to be mapped with the root user within the container
5. uts provides dedicated hostname
6. ipc provides dedicated shared memory

All of this adds more isolation than chroot provides

The extra bells and whistles is called process isolation, a container gets its own [namespace](https://en.wikipedia.org/wiki/Linux_namespaces) from the host kernel, that means the program in the container can't try to read kernel memory or eat more RAM than allowed.

It also isolates network stacks, so two process can listen on port 8080 for exemple, you'll have to handle the routing at host level, there's no magic here, but this allow handling the routing at one place and avoid modifying the process configuration to listen to a free port.

Secondly a chroot is still read/write, any change is permanent, a docker container using aufs will start from a clean filesystem each time you launch the container (changes are kept if you stop/start it IIRC).

So while a container may be thought of as process namespace + chroot, the reality is a little more complex.


## docker lingo

An **image** is a representation of everything you wish to have, but think of it as configuration. You’ve specified what you’d like to be in this image, and now, based on the image, you can create many containers.

A **container** is a running instance of a Docker image. Containers run the actual applications. A container includes an application and all of its dependencies. It shares the kernel with other containers and runs as an isolated process in user space on the host OS.

A **Docker daemon** is a background service running on the host that manages the building, running and distributing Docker containers.

**Docker client** is a command-line tool you use to interact with the Docker daemon. You call it by using the command docker on a terminal. You can use Kitematic to get a GUI version of the Docker client. 

A **Docker store** is a registry of Docker images. There is a public registry on Docker.com where you can set up private registries for your team’s use. You can also easily create such a registry in Azure.



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