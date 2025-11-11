import std.stdio;
import utils;
import header;

void main() {
    writeln("Building ELF file `t`...");
    byte[] elf_file = [];

    elf_file ~= elf_header();

    writeToFile(elf_file);
}
