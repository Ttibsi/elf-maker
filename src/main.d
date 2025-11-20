import std.stdio;
import utils;
import elf_header;

void main() {
    writeln("Building ELF file `t`...");
    byte[] elf_file = [];

    elf_file ~= gen_elf_header();
    writeln("Elf header: ", gen_elf_header().length, " bytes");
    
    writeToFile(elf_file);
}
