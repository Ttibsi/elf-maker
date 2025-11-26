# elf-maker

An attempt at generating an ELF binary from scratch that prints hello world. 
This is so I can learn about how an elf file actually works, and a little about
ARM64 assembly. 

This has only been tested on a raspberry pi 4 with an ARMv8 instruction set

### How to use
This repo is built using D, and is also my first experimentation with D as a 
language. Taking the [nob.h](https://github.com/tsoding/nob.h) approach, you
will first need to compile the `build.d` file with:
```console
$ gdc build.d -o build
```

and then by just running `./build`, the repo will build. `t` is the name of the 
binary file generated, executing that should result in `hello world!\n` displayed
on your screen.
```
$ ./build
$ ./elf_maker
$ ./t
```

#### Why?
Because it really isn't easy to get `dub` and `rdmd`/`dmd` working on aarch64,
with no provided binaries.

See `elf_notes.md` for everything I've learned about ELF files and whatt else I
could recommend
