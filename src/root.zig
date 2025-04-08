//! c wrapper around the built in json parser

const std = @import("std");

var raw = std.heap.GeneralPurposeAllocator(.{}){};
const ALLOCATOR:std.mem.Allocator = raw.allocator();

const c = @cImport(
    {
        @cInclude("struct_def.h");
    }
);

/// wraps the built in json parser 
pub fn parse_json_to_type(
    allocator: std.mem.Allocator,
    file_path: []const u8,
    comptime target_type: type,
) !target_type 
{
    const fi = try std.fs.cwd().openFile(
        file_path,
        .{}
    );
    defer fi.close();

    const source = try fi.readToEndAlloc(
        allocator,
        std.math.maxInt(u32)
    );

    const value = try std.json.parseFromSlice(
        target_type,
        allocator,
        source,
        .{},
    );

    return value.value;
}

/// parse the json file at fpath and store the result in result
pub export fn parse_json_into_ptr(
    /// path to the file to parse
    fpath:[*c]u8,
    /// pointer to result object in memory to fill
    result:*c.single_int,
) void 
{
    result.* = (
        parse_json_to_type(
            ALLOCATOR,
            std.mem.span(fpath),
            c.single_int
        ) catch unreachable
    );
}

/// parse a single integer value from a json file and return the result
pub export fn parse_json_int(
    fpath:[*c]u8,
) c.single_int 
{
    return (
        parse_json_to_type(
            ALLOCATOR,
            std.mem.span(fpath),
            c.single_int,
        ) catch unreachable
    );
}

/// parse an array of floats from a json file
pub export fn parse_json_array_float(
    fpath:[*c]u8
) c.array_float 
{
    return (
        parse_json_to_type(
            ALLOCATOR,
            std.mem.span(fpath),
            c.array_float
        ) catch unreachable
    );
}

test "test_parse" {
    try std.testing.expectEqual(
        parse_json_to_type(
            ALLOCATOR,
            "test.json",
            c.single_int,
        ),
        c.single_int{.val=14}
    );
}

pub export fn foo() i32 
{
    std.debug.print("hello, c\n", .{});
    return 12;
}

pub export fn print_to_string(
    buf: [*]u8,
    bufsize: usize,
) void
{
    std.log.debug("zig impl\n", .{});

    const localbuf = buf[0..bufsize];

    _ = std.fmt.bufPrint(
        localbuf,
        "hello, buffer: {d}",
        .{ 12 }
    ) catch {
        std.log.err("something went wrong.\n", .{});
        return;
    };
}
