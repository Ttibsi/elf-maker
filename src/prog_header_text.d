
// Type of segment this is. 01 is a segment to loaded into memory
byte[4] p_type() { return [0x1, 0, 0, 0]; }

// Permission flags -- same as Unix. 
// Setting to `101` ( r+e)
byte[4] p_flags() { return [0x5, 0, 0, 0]; }

// offset in the file to start loading from
// Because this code is so small, we start from 0 to ensure we align with page boundaries
// We could shift everything over to the next page boundary at 0x1000, but that
// would inflate the size of the file unneccesarily
byte[8] p_offset() { return [0, 0, 0, 0, 0, 0, 0, 0]; }

// What virtual memory address should the loader load this memory into
// customarily in this location 
byte[8] p_vaddr() { return [0, 0, 0x40, 0, 0, 0, 0, 0]; }

// If we need to specify any physical location, do so here
// This isn't neccesary for this program
byte[8] p_paddr() { return [0, 0, 0, 0, 0, 0, 0, 0]; }

// The size of the data we want to load
// e8 is the end of the instructions -- based on Kay Lack
ubyte[8] p_filesz() { return [0xe8, 0, 0, 0, 0, 0, 0, 0]; }

// Size of the segment, may be larger than the size of the data
// For our case, not relevant
ubyte[8] p_memsz() { return [0xe8, 0, 0, 0, 0, 0, 0, 0]; }

// Addresses should be a multiple of the alignment value
// x86 it should be this value, the arm docs (PDF download) just say P_ALIGN=4?
// https://documentation-service.arm.com/static/5ed0fcb4ca06a95ce53f841e
byte[8] p_align() { return [0, 0x10, 0, 0, 0, 0, 0, 0]; }

byte[] gen_prog_header_text() {
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
