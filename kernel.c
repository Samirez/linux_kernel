#define VGA_ADDRESS 0xB8000   /* video memory begins here. */

/* VGA provides support for 16 colors */
#define BLACK 0
#define GREEN 2
#define RED 4
#define YELLOW 14
#define WHITE_COLOR 15

unsigned short *terminal_buffer;
unsigned int vga_index;

struct dirent {
    char   d_name[];
};

void clear_screen(void)
{
    int index = 0;
    /* there are 25 lines each of 80 columns;
       each element is an unsigned short combining character and attribute */
    while (index < 80 * 25) {
            terminal_buffer[index] = (unsigned short)((BLACK << 8) | ' ');
            index++;
    }
}

void print_string(char *str, unsigned char color)
{
    int index = 0;
    while (str[index]) {
            terminal_buffer[vga_index] = (unsigned short)str[index]|(unsigned short)color << 8;
            index++;
            vga_index++;
    }
}

void _ls(const char *dir, int op_a, int op_l)
{
    
    char* dir = opendir(dir);
    print("Directory: %s\n", dir);
}

void main(void)
{
    terminal_buffer = (unsigned short *)VGA_ADDRESS;
    vga_index = 0;

    clear_screen();
    _ls("/", 0, 0);
    print_string("Hello from Linux Journal!", YELLOW);
    vga_index = 80;    /* next line */ 
    print_string("Goodbye from Linux Journal!", RED);
    return;
}
