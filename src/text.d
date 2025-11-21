import std.algorithm;

/+
NOTE: This shows the bytes in big-endian order. We need to convert it to little endian
objdump -S hello
  4000b0:       d2800020        mov     x0, #0x1                        // #1
  4000b4:       580000e1        ldr     x1, 0x4000d0
  4000b8:       58000102        ldr     x2, 0x4000d8
  4000bc:       52800808        mov     w8, #0x40                       // #64
  4000c0:       d4000001        svc     #0x0
  4000c4:       d2800000        mov     x0, #0x0                        // #0
  4000c8:       52800ba8        mov     w8, #0x5d                       // #93
  4000cc:       d4000001        svc     #0x0
+/

// Array already reversed here
ubyte[4] make_syscall() { return [0x1, 0, 0, 0xd4]; }

byte[] write_syscall() {
    byte[] bytes = [];

    // mov x0 #0x1
    // Set the file descriptor to 1 (STDOUT)
    bytes ~= reverse(cast(ubyte[])[0xd2, 0x80, 0, 0x20]);

    // ldr     x1, =msg
    // buf to print (in data section)
    bytes ~= reverse(cast(ubyte[])[0xd8, 0, 0, 0xe1]);

    // ldr     x2, =len
    // Count of chars to print
    bytes ~= reverse(cast(ubyte[])[0xd8, 0, 0x1, 0x02]);

    // mov     w8, #64
    // set syscall num to make (write is 64)
    bytes ~= reverse(cast(ubyte[])[0xd2, 0x80, 0, 0]);

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
    bytes ~= reverse(cast(ubyte[])[0xd2, 0x80, 0x0b, 0xa8]);

    bytes ~= make_syscall();
    return bytes;
}

byte[] gen_text_segment() {
    byte[] bytes = [];
    bytes ~= write_syscall();
    bytes ~= exit_syscall();
    return bytes;
}
