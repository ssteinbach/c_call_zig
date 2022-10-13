#include "zigJsonReader.h"
#include <stdio.h>

int 
main() 
{
    struct single_int result;
    parse_json_ptr("test.json", &result);
    printf("read from json: %d\n", result.val);

    return 0;
}
