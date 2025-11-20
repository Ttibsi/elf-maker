/// The documentation for the functions in this file are left in `prog_header_text.d`

byte[4] p_type() { return [0x1, 0, 0, 0]; }
byte[4] p_flags() { return [0x4, 0, 0, 0]; }
byte[8] p_offset() { return [0, 0, 0, 0, 0, 0, 0, 0]; }
byte[8] p_vaddr() { return [0, 0, 0x60, 0, 0, 0, 0, 0]; }
byte[8] p_paddr() { return [0, 0, 0, 0, 0, 0, 0, 0]; }
ubyte[8] p_filesz() { return [0, 0x1, 0, 0, 0, 0, 0, 0]; }
ubyte[8] p_memsz() { return [0, 0x1, 0, 0, 0, 0, 0, 0]; }
byte[8] p_align() { return [0, 0x10, 0, 0, 0, 0, 0, 0]; }

byte[] gen_prog_header_data() {
    byte[] header = [];

    header ~= p_type();
    header ~= p_flags();
    header ~= p_offset();
    header ~= p_vaddr();
    header ~= p_paddr();
    header ~= p_filesz();
    header ~= p_memsz();
    header ~= p_align();

    return header;
}
