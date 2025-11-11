import std.system;
import std.stdio;

byte getCurrArch() {
    switch (instructionSetArchitecture) {
        case ISA.aarch64:
            return 1;
        case ISA.x86_64:
            return 2;
        default:
            return 127;
    }
}

void writeToFile(byte[] bytes) {
    toFile(bytes, "t");
}

void hello() { writeln("Hello world"); }
