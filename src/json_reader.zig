const std = @import("std");
const expectEqual = std.testing.expectEqual;

var raw = std.heap.GeneralPurposeAllocator(.{}){};
const ALLOCATOR:std.mem.Allocator = raw.allocator();

const c = @cImport(
    {
        @cInclude("struct_def.h");
    }
);

pub fn thingy(first: i32, second: f32) !first {
    return first + @floatToInt(i32, second);
}

pub fn parse_json_err(file_path: []const u8, target_obj: anytype) !target_obj {
    const fi = try std.fs.cwd().openFile(file_path, .{});
    defer fi.close();

    const source = try fi.readToEndAlloc(ALLOCATOR, std.math.maxInt(u32));
    var stream = std.json.TokenStream.init(source);

    return try std.json.parse(target_obj, &stream, .{});
}

pub export fn parse_json_ptr(fpath:[*c]u8, result:*c.single_int) void {
    result.* = (
        parse_json_err(std.mem.span(fpath), c.single_int) catch unreachable
    );
}

pub export fn parse_json_value(fpath:[*c]u8) c.single_int {
    return (
        parse_json_err(std.mem.span(fpath), c.single_int) catch unreachable
    );
}

pub export fn parse_json_array(fpath:[*c]u8) c.array_float {
    return (
        parse_json_err(std.mem.span(fpath), c.array_float) catch unreachable
    );
}

test "test_parse" {
    try expectEqual(parse_json_err("test.json"), 14);
    try expectEqual(thingy(1, 2.3), @as(i32, 3));
}

pub export fn foo() i32 {
    std.debug.print("hello, c\n", .{});
    return 12;
}