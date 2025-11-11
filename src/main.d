import utils;

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

byte[] elf_header() {
    byte[] header = [];
    header ~= e_ident();

    return header;
}

void main() {
    byte[] elf_file = [];

    elf_file ~= elf_header();

    writeToFile(elf_file);
}
