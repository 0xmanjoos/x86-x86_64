#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
int main(int argc, char* argv[]) {

    char l = 1;
    unsigned char buff; // buffer?
    int fd;             // file descriptor
    fd = open(argv[1], 0, S_IRUSR);
    while(read(fd, &buff, 1)) {
        if(buff==0 && l==1) {
            printf(" \n");
            l = 0;
        } else if(buff) {
            printf("\\x%02x", buff);
            l = 1;
        }
    }
    close(fd); // close file descriptor
}
