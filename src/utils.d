import std.file;
import std.system;
import std.stdio;
import std.conv;

ushort getCurrArch() {
    switch (instructionSetArchitecture) {
        case ISA.aarch64:
            return 0xB7;
        case ISA.x86_64:
            return 0x3E;
        default:
            return 0;
    }
}

void writeToFile(byte[] bytes) {
    toFile(bytes, "t");

    // Make `t` executable
    auto file = "./t";
    file.setAttributes(octal!777);
}

ubyte[8] padding() { return [0, 0, 0, 0, 0, 0, 0, 0]; } 
