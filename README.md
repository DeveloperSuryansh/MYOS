# MYOS
This is Repository to learn and build your own OS

To Understand, How code works, how bootloader works, you need to learn about Assembly Language
then you need to learn about bootloader,bootsector,bios,interrupts,DOS,assembly mnemonics,etc.

Then you are ready to Understand, How the Code Works.

<b>Tools Requirements:</b>
  <ul>
  <li> qemu-system-i386 </li>
  <li> qemu-system-x86_64 </li>
  <li> gcc </li>
  <li> nasm </li>
  <li> git </li>
  <li> Any IDE. Recommends for Visual Studio for easy work.</li>
  
<b>How to run:</b>
  To Run Samples:
  <li> qemu-system-i386 -kernel hello.bin </li>
  
  <b>To Build your Own in C_Kernel folder:</b>
  <li> nasm -f elf32 -o (output_file.o) (input_file.asm) </li>
  <li> gcc -m32 -c (input_file.o) (input_file.c) </li>
  <li> ld -m elf_i386 -Ttext 0x1000 -o kernel.bin (nasm_output_file.o) (gcc_output_file.o) </li>
    
  <b>To Build your Own in asm Folder:</b>
    <li> nasm -f bin -o (output_file.o) (input_file.asm) </li></ul>
