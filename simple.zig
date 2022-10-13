const std = @import("std");

pub export fn foo() i32 {
    std.debug.print("hello, c\n", .{});
    return 12;
}
