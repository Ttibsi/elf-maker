import utils;
import std.bitmanip;

// Elf header
byte[16] e_ident() {
    byte[16] eident = new byte[16];

    // first 4 bytes are a magic number, default
    eident[0] = 0x7f;
    eident[1] = 0x45; // 'e'
    eident[2] = 0x4c; // 'l'
    eident[3] = 0x46; // 'f'

    // 32 or 64 bit file
    eident[4] = 0x02;

    // Endian-ness: LSB or MSB
    eident[5] = 0x01;

    // Version (alway 1)
    eident[6] = 0x01;

    // OS ABI
    // usually 0/System V even on linux, but some static libs set this to 3/linux
    // for now, we will keep this at 0
    eident[7] = 0x00;

    // ABI version (almost never used)
    eident[8] = 0x00;

    // the rest of the bytes are for padding

    return eident;
}

// NOTE: 2 is for executables that don't support position-independant code
// use 3 (for SO) for an executable that uses PIE
byte[2] e_type() { return [2, 0]; }

// Architecture we use
ubyte[2] e_machine() { return nativeToLittleEndian(getCurrArch()); }

// For some reason, we specify the version again
byte[4] e_version() { return [1,0,0,0]; }

// Wikipedia: This is the memory address of the entry point from where the 
// process starts executing. If the file doesn't have an associated entry 
// point, then this holds zero.
// NOTE: This is the same as the p_vaddr field in the program header
//ubyte[8] e_entry() { return [0x54, 0x80, 0x4, 0x8, 0x0, 0x0, 0x0, 0x0]; }
ubyte[8] e_entry() { return [0xb0, 0x00, 0x40, 0x0, 0x0, 0x0, 0x0, 0x0]; }

// The offset of the first program header
ubyte[8] e_phoff() { return [0x40, 0x00, 0x00, 0x0, 0x0, 0x0, 0x0, 0x0]; }

// The offset of the first section header
// We don't have any sections, so this is all 0s
byte[8] e_shoff() { return [0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0]; }

// We have no flags to set
byte[4] e_flags() { return [0,0,0,0]; }

// ELF header size - always 0x40 for 64 bit
byte[2] e_ehsize() { return [0x40, 0]; }

// program header entry size - always 0x38 for 64 bit
byte[2] e_phentsize() { return [0x38, 0]; }

// Program header count
byte[2] e_phnum() { return [0x2, 0]; }

// section header entry size 
byte[2] e_shentsize() { return [0, 0]; }

// Section header count
byte[2] e_shnum() { return [0, 0]; }

// Section header string names 
// if we don't have any sections, we don't need to store any names
byte[2] e_shstrndx() { return [0, 0]; }

byte[] gen_elf_header() {
    byte[] header = [];

    header ~= e_ident();
    header ~= e_type();
    header ~= e_machine();
    header ~= e_version();
    header ~= e_entry();
    header ~= e_phoff();
    header ~= e_shoff();
    header ~= e_flags();
    header ~= e_ehsize();
    header ~= e_phentsize();
    header ~= e_phnum();
    header ~= e_shentsize();
    header ~= e_shnum();
    header ~= e_shstrndx();

    return header;
}
