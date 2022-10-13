const std = @import("std");
const expectEqual = std.testing.expectEqual;

var raw = std.heap.GeneralPurposeAllocator(.{}){};
const ALLOCATOR:std.mem.Allocator = raw.allocator();

const testthing = struct {
    val: i32,
};

pub fn parse_json_err() !i32 {
    const file_path = "test.json";
    const fi = try std.fs.cwd().openFile(file_path, .{});
    defer fi.close();

    const source = try fi.readToEndAlloc(ALLOCATOR, std.math.maxInt(u32));
    var stream = std.json.TokenStream.init(source);

    const result:testthing = try std.json.parse(testthing, &stream, .{});

    return result.val;
}

pub export fn parse_json() i32 {
    return parse_json_err() catch unreachable;
}

test "test_parse" {
    try expectEqual(parse_json(), 14);
}

pub export fn foo() i32 {
    std.debug.print("hello, c\n", .{});
    return 12;
}
