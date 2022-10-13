#include "libTestProg.h"
#include <stdio.h>

int main() {
    foo();

    printf("read from json: %d\n", parse_json());

    return 0;
}
