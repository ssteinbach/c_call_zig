const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("zigJsonReader", "src/json_reader.zig");
    lib.addIncludePath("src");

    // to ensure that its statically linkable to c
    lib.bundle_compiler_rt = true;

    lib.setTarget(target);
    lib.setBuildMode(mode);
    lib.install();

    const lib_tests = b.addTest("src/json_reader.zig");
    lib_tests.setBuildMode(mode);
    lib_tests.addIncludePath("src");

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&lib_tests.step);
}
