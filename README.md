Pwnpeii
-------

This is a docker meant to ease deployment of pwnable binaries in a safe and secure way (modulo kernel and zero-day issues).

You can simply build the docker once, and serve any number of binaries easily, each in a separate docker container.

## Building
```
./docker_build.sh             # Really
```

## Running
```
mkdir mount
cp ${MYBINARY} mount/binary
cp ${MYFLAG.txt} mount/flag.txt
PORT=9998 ./docker_run.sh     # Really <again>
```

## Notes
The docker uses the following packages:
* firejail
* cgroups
* xinetd
* docker :)

The complete thing is implemented using simple bash scripts, and you can easily use and modify it for your use.

## Statement
I shall not take any responsibility for any behavior of the docker, although it should pass security concerns.

Keeping your kernel up-to-date is of importance, since dockers cannot prevent kernel based exploits like dirty cow.

Have fun! And do point out any security issues if you find any, at *saksham@acehack.org*

P.S. @[rawcoder](http://github.com/rawcoder) deserves a shout-out for his considerable help.
