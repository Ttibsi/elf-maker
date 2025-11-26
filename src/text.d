import std.algorithm;

// Array already reversed here
ubyte[4] make_syscall() { return [0x1, 0, 0, 0xd4]; }

byte[] write_syscall() {
    byte[] bytes = [];

    // mov x0 #0x1
    // Set the file descriptor to 1 (STDOUT)
    bytes ~= reverse(cast(ubyte[])[0xd2, 0x80, 0, 0x20]);

    // adr x1, #28
    bytes ~= reverse(cast(ubyte[])[0x10, 0, 0, 0xe1]);

    // mov     x2, #0xd
    // Count of chars to print
    bytes ~= reverse(cast(ubyte[])[0xd2, 0x80, 0x1, 0xa2]);

    // mov     w8, #64
    // set syscall num to make (write is 64)
    bytes ~= reverse(cast(ubyte[])[0x52, 0x80, 0x8, 0x8]);

    bytes ~= make_syscall();

    return bytes;
}

byte[] exit_syscall() {
    byte[] bytes = [];

    // mov     x0, #0
    // Set exit code to 0
    bytes ~= reverse(cast(ubyte[])[0xd2, 0x80, 0, 0]);

    // mov     w8, #93
    // set syscall num to make (exit is 93)
    bytes ~= reverse(cast(ubyte[])[0x52, 0x80, 0x0b, 0xa8]);

    bytes ~= make_syscall();
    return bytes;
}

byte[] gen_text_segment() {
    byte[] bytes = [];
    bytes ~= write_syscall();
    bytes ~= exit_syscall();
    return bytes;
}
