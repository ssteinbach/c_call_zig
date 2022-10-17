#include "zigJsonReader.h"
#include <stdio.h>

int 
main() 
{
    struct single_int result;
    parse_json_ptr("test.json", &result);
    printf("read from json: %d\n", result.val);

    result.val = -123;
    result = parse_json_value("test.json");

    printf("read from json: %d\n", result.val);

    struct array_float result_arr = parse_json_array("test.array.json");
    printf(
            "read from json: [%g %g %g %g] %d\n",
            result_arr.values[0],
            result_arr.values[1],
            result_arr.values[2],
            result_arr.values[3],
            result_arr.child.val
    );


    return 0;
}
