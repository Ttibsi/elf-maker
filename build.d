import std.stdio;
import std.file;
import std.algorithm.iteration;
import std.array;
import std.path;
import std.process;

string[] listdir() {
    return dirEntries("src", SpanMode.shallow)
        .filter!(a => a.isFile)
        .map!((return a) => a.name)
        .array;
}

int compile(string[] files, string exec_name) {
    string[] cmd = [
        "gdc",
        "-g",
        "-o",
        exec_name
    ];

    cmd ~= files;
    writeln("CMD: ", cmd);
    return wait(spawnProcess(cmd)) == 0;
}

int main() {
    string[] files = listdir();
    compile(files, "elf_maker");
    return 0;
}
