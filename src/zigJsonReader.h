#include "struct_def.h"
#include <stdio.h>

// c-header for zig functions in zigJsonReader
// struct wrappers are illustrative and not required

void parse_json_into_ptr(
        const char* fpath,
        struct single_int* result
);

struct single_int parse_json_int(
    const char* fpath
);
struct array_float parse_json_array_float(
    const char* fpath
);

// example of printing to a string in zig
void print_to_string(
    char* buf,
    size_t bufsize
);
