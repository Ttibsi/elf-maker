import std.stdio;

import elf_header;
import prog_header_data;
import prog_header_text;
import text;
import utils;

void main() {
    writeln("Building ELF file `t`...");
    byte[] elf_file = [];

    elf_file ~= gen_elf_header();
    writeln("Elf header: ", gen_elf_header().length, " bytes");

    elf_file ~= gen_prog_header_text();
    writeln("Program header (text): ", gen_prog_header_text().length, " bytes");

    elf_file ~= gen_prog_header_data();
    writeln("Program header (data): ", gen_prog_header_data().length, " bytes");

    // We need to pad out our file by 2x8 bytes to get to the right address
    elf_file ~= padding();
    elf_file ~= padding();

    elf_file ~= gen_text_segment();
    writeln("Text segment: ", gen_text_segment().length, " bytes");

    elf_file ~= gen_data_segment();
    writeln("Data segment: ", gen_data_segment().length, " bytes");

    elf_file ~= cast(ubyte[])[0,0,0]; // padding out to make a full square

    writeToFile(elf_file);
}
