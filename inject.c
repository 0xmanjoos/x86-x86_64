int main() {
    char *shellcode = "<shellcode here!!>";

    (*(void(*)()) shellcode)();
}
