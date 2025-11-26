# ELF notes

### Structure of an ELF file. 
* An ELF file is made up of both Sections and Segments (also called programs) that overlap in the actual binary
* The sizes and space are defined by sequential headers 
* The start of the ELF file has a single ELF header that defines things like the binary size and entry point
    * More notably, the ELF header also specifies the number of program headers and section headers
* A program header will point to where the program starts in memory. These are your assembly blocks
    * EX `.text`, `.data` -- these are the only two we used in this program
    * A segment called `.shstrtab` stores the names of the other segments for tools like readelf to show
* You don't have to have any sections -- we didn't need for our hello world program


### Unix commands
* During development, I found the following unix commands helpful:
    * `file` - the values shown here are pulled from the ELF header, useful for showing if the ELF header is right
    * `readelf -a` - will show the ELF header values and a bunch of other useful info
    * `hexdump -C` - shows the bytes in hex from a file, as well as the "artwork", which is really useful
    * `objdump -S` - see the assembly instructions and accompanying binary commands 
        * This mostly helped when comparing to an actual compiled assembly file

### Resources
If you want to try a project like this yourself, these 
are the main resources I used online that helped me out here.

* `man elf`
* [Wikipedia article](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format)
    * See also the diagram at the top of the page as well
* [Crafting executables from raw bytes - Key Lack](https://youtu.be/cX5tQJhuNeY?si=Bts2AUpoAQggI-1e)
* [Handmade Linux x86 executables - David Smith](https://youtu.be/XH6jDiKxod8?si=SVqEmONCLaxDhygU)
* [In-depth ELF - stacksmashing](https://youtu.be/nC1U1LJQL8o?si=vOPRXt6PCat9aI9F)
