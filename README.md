# elf-maker

An attempt at generating an ELF binary from scratch that prints hello world. 
This is so I can learn about how an elf file actually works.

### How to use
This repo is built using D, and is also my first experimentation with D as a 
language. Taking the [nob.h](https://github.com/tsoding/nob.h) approach, you
will first need to compile the `build.d` file with:
```console
$ gdc build.d -o build
```

and then by just running `./build`, the repo will build.

#### Why?
Because it really isn't easy to get `dub` and `rdmd`/`dmd` working on aarch64,
with no provided binaries. A lot of this development happened on a raspberry pi

### Notes on ELF Files

