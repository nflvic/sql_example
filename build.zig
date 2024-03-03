const std = @import("std");

pub fn build(b: *std.Build) void {

    const target = b.standardTargetOptions(.{});


    const optimize = b.standardOptimizeOption(.{});

    const pkg = b.dependency("zconn", .{
        .target = target,
        .optimize = optimize
    });

    const example = b.addExecutable(.{
        .target = target,
        .name = "example",
        .root_source_file = .{ .path = "src/main.zig" },
        .optimize = optimize
    });

    b.installArtifact(example);

    const libs_to_link = [_][]const u8{"mysqlclient","zstd","ssl", "crypto" ,"resolv" ,"m"};
	

    for(libs_to_link) |l| {
        example.linkSystemLibrary(l);
    }
    

    example.addModule("zconn", pkg.module("zconn"));

}
