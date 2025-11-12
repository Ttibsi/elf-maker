import utils;
import std.bitmanip;

byte[16] e_ident() {
    byte[16] eident = new byte[16];

    // first 4 bytes are a magic number, default
    eident[0] = 0x7f;
    eident[1] = 0x45; // 'e'
    eident[2] = 0x4c; // 'l'
    eident[3] = 0x46; // 'f'

    // 32 or 64 bit file
    eident[4] = 0x02;

    // LSB or MSB
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
byte[] e_type() pure { return [2, 0]; }

// Wikipedia: This is the memory address of the entry point from where the 
// process starts executing. If the file doesn't have an associated entry 
// point, then this holds zero.
// NOTE: This is the same as the p_vaddr field in the program header
ubyte[8] e_entry() { return [0x54, 0x80, 0x4, 0x8, 0x0, 0x0, 0x0, 0x0]; }

byte[] elf_header() {
    byte[] header = [];
    header ~= e_ident();

    // file type 
    header ~= e_type();

    // architecture
    header ~= nativeToLittleEndian(getCurrArch());

    // Version -- always 1
    header ~= [1,0,0,0];

    // Entry point
    header ~= e_entry();

    // program header - hardcoding here as it's usually the next part of the binary
    // which is where I'm going to put it
    header ~= [0x40,0,0,0,0,0,0,0];

    // start of the section header table
    // We don't have any sections as this is an executable, only segments
    header ~= [0,0,0,0,0,0,0,0];

    // flags - just set to 0
    header ~= [0,0,0,0];

    // e_ehsize - elf header size
    header ~= [0x40, 0];

    // Program header size
    header ~= [0x38, 0];

    // program header count -- we _should_ only need 1?
    header ~= [0x1, 0];

    // Section header size - even with 0 sections, this still needs to be defined
    header ~= [0x40, 0];

    // section header count
    header ~= [0, 0];

    // Contains index of the section header table entry that contains the section names.
    header ~= [0, 0];

    return header;
}
