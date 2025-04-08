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

    const test_step = b.step("test", "Run tests");

    // zig library
    const lib = b.addStaticLibrary(
        .{
            .name = "c_call_zig_json",
            .target = target,
            .optimize = optimize,
            .root_source_file = b.path("src/root.zig"),
        },
    );
    lib.addIncludePath(b.path("src"));

    const lib_install = &b.addInstallArtifact(
        lib,
        .{}
    ).step;
    const install = b.step(
        "install_zig_lib",
        "install the c_call_zig_json library",
    );
    install.dependOn(lib_install);
    b.getInstallStep().dependOn(install);

    // to ensure that its statically linkable to c
    lib.bundle_compiler_rt = true;

    const lib_tests = b.addTest(
        .{
            .name = "test_c_call_zig_json",
            .root_source_file = b.path("src/root.zig"),
            .target = target,
            .optimize = optimize,
        }
    );
    lib_tests.addIncludePath(b.path("src"));

    const run_lib_tests = b.addRunArtifact(lib_tests);

    test_step.dependOn(&run_lib_tests.step);

    // c tests
    const c_exe = b.addExecutable(
        .{
            .name = "c_call_zig",
            .target = target,
            .optimize = optimize,
        }
    );
    c_exe.addCSourceFile(
        .{
            .file = b.path("src/main.c"),
        }
    );
    c_exe.addIncludePath(b.path("src"));
    c_exe.linkLibC();
    c_exe.linkLibrary(lib);

    b.installArtifact(c_exe);

    const c_run = b.addRunArtifact(c_exe);
    test_step.dependOn(&c_run.step);
}
