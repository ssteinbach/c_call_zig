#include "zigJsonReader.h"
#include <stdio.h>

int 
main() 
{
    int32_t result_from_zig = parse_json("test.json");
    printf("read from json: %d\n", result_from_zig);

    return 0;
}
