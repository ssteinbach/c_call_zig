#include <stdint.h>

struct single_int {
    int32_t val;
};

struct array_float {
    float values[4];
    struct single_int child;
};
