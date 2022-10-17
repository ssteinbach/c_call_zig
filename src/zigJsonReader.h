#include "struct_def.h"

void parse_json_ptr(const char* fpath, struct single_int* result);
struct single_int parse_json_value(const char* fpath);
struct array_float parse_json_array(const char* fpath);
