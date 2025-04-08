#include "zigJsonReader.h"
#include <stdio.h>

int 
main() 
{
    printf("Tests from C code\n");

    struct single_int result;
    parse_json_into_ptr("test.json", &result);
    printf("read from json: %d\n", result.val);

    result.val = -123;
    result = parse_json_int("test.json");

    printf("read from json: %d\n", result.val);

    struct array_float result_arr = parse_json_array_float("test.array.json");
    printf(
            "read from json: [%g %g %g %g] %d\n",
            result_arr.values[0],
            result_arr.values[1],
            result_arr.values[2],
            result_arr.values[3],
            result_arr.child.val
    );

    char buf[1024];
    print_to_string(buf, 1024);
    printf("got string: %s\n", buf);

    printf("C tests are all done\n");

    return 0;
}
