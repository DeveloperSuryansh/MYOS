#define VIDMEM 0xB8000
enum colors{
    BLACK=0x00,
    BLUE=0x01,
    GREEN=0x02,
    AQUA=0x03,
    RED=0x04,
    PURPLE=0x05,
    YELLOW=0x06,
    WHITE=0x07,
    GRAY=0x08,
    LIGHTBLUE=0x09,
    LIGHTGREEN=0x0a,
    LIGHTCYAN=0x0b,
    LIGHTRED=0x0c,
    LIGHTPURPLE=0x0d,
    LIGHTYELLOW=0x0e,
    LIGHTWHITE=0x0f
};
enum bcolors{
    BBLACK=0x00,
    BBLUE=0x10,
    BGREEN=0x20,
    BAQUA=0x30,
    BRED=0x40,
    BPURPLE=0x50,
    BYELLOW=0x60,
    BWHITE=0x70,
    BGRAY=0x80,
    BLIGHTBLUE=0x90,
    BLIGHTGREEN=0xa0,
    BLIGHTCYAN=0xb0,
    BLIGHTRED=0xc0,
    BLIGHTPURPLE=0xd0,
    BLIGHTYELLOW=0xe0,
    BLIGHTWHITE=0xf0
};
#define COLOR 0x10+WHITE
#define COLOR2 0x02
typedef unsigned int uint;
typedef unsigned char uchar;

uchar port_byte_in(unsigned short port);
void port_byte_out(unsigned short port,unsigned char data);
void clear_screen();
uint print(char *msg,int l,uint col,uint b_col);
uint l=0;



void main(){
    int l =0;
    uchar i = port_byte_in(0x3d4);
    print("hello",l,WHITE,BBLACK);
}



uchar port_byte_in(unsigned short port) {
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" ((char*)port));
    return result;
}

void port_byte_out(unsigned short port, unsigned char data) {
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}


void clear_screen(){
    char *vidmem = (char*)VIDMEM;
    uint i = 0;
    while(i<(80*25*2)){
        vidmem[i] = ' ';
        i++;
        vidmem[i] = COLOR;
        i++;
    }
}

uint print(char *msg,int l,uint col,uint b_col){
    char *vidmem = (char*)VIDMEM;
    uint i = (l*80*2);
    while(*msg!=0){
        if(*msg=='\n'){
            l++;
            i = (l*80*2);
            *msg++;
        }
        else{
            vidmem[i] = *msg;
            *msg++;
            i++;
            vidmem[i] = 0x00+col+b_col;
            i++;
        }
    }
    l++;
    return (-1);
}