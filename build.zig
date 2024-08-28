const std = @import("std");

pub fn build(
    b: *std.Build,
) void 
{
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(
        .{
            .name = "zigJsonReader",
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/json_reader.zig"),
        },
    );
    lib.addIncludePath(b.path("src"));

    const lib_install = &b.addInstallArtifact(
        lib,
        .{}
    ).step;
    const install = b.step(
        "install_zig_lib",
        "install the zigJsonReader library",
    );
    install.dependOn(lib_install);
    b.getInstallStep().dependOn(install);

    // to ensure that its statically linkable to c
    lib.bundle_compiler_rt = true;

    const lib_tests = b.addTest(
        .{
            .name = "test_zigJsonReader",
            .root_source_file = b.path("src/json_reader.zig"),
            .target = target,
        }
    );
    lib_tests.addIncludePath(b.path("src"));

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&lib_tests.step);
}
