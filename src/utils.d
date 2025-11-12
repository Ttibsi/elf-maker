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
}
