# Compiling GVR-700

**DISCLAIMER:** I am not responsible for any actions you perform. You, by compiling this program,
are agreeing that, any damage performed to your/other devices is entirely your fault.

To begin, choose your operating system.

## Linux
Install the `x86_64-w64-mingw32-*` toolchain. It's typically in repositories, if
not, compile yourself. Then, just run these in a terminal
```sh
mkdir -p out/
x86_64-w64-mingw32-gcc src/gvr-700.c -o ./out/GVR700.exe
```

Alternatively, you can run `make`.

## Windows

Firstly, make sure that:
1. [NASM](https://www.nasm.us/)
2. [VS2022](https://visualstudio.microsoft.com/)

are both installed properly. Create a project, and make sure that
> Properties > C/C++ > Code Generation > Runtime Library

is set to "Multithreaded". This prevents end users from needing to install
VCRedist on their machines (which also doesn't work for Win 7 x64, even if installed
properly).

Next, copy the C code into any source file. To compile, use F7.

# Changing the ASM code
The bootsector code is written in 16-bit Assembly. Using C would take up too much
space (not to mention IA16 C is buggy and very broken). Compile with
```
nasm gvr700-asm.asm -o gvr700
```

Next, go to [this website](http://tomeko.net/online_tools/file_to_hex.php) and upload
the `gvr700`. Then, replace the contents of the `Data_mbr` array like such:

```c
// ...
unsigned char Data_mbr[512] = {
  // Content from the website above 
  // ...
};
```

Then compile as usual.