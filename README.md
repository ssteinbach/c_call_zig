# Calling Zig from C

## Overview

Example repository for calling zig functions from C.  Zig has some nice
reflection based JSON parsing ability, this exposes a c function that uses that
to parse a C-struct out of JSON and return it.

## Requirements

* Zig (built against 0.10.0-dev.4217+9d8cdb855)
* C toolchain (clang)

## Building

```bash
> make
> ./c_to_zig_json_reader
```

## Testing

There is a (small) unit test in `src/json_reader.zig`.

```bash
> make test
```

## Build.zig Note

When building the static library to wrap in C, make sure the build.zig
includes:

```zig
const lib = b.addStaticLibrary("zigJsonReader", "json_reader.zig");
lib.bundle_compiler_rt = true;
```

Additionally, the header file is written by hand.
