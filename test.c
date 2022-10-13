#include "zigJsonReader.h"
#include <stdio.h>

int 
main() 
{
    int32_t result_from_zig = parse_json();
    printf("read from json: %d\n", result_from_zig);

    return 0;
}
