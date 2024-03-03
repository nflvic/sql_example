const std = @import("std");

pub fn build(b: *std.Build) void {

    const target = b.standardTargetOptions(.{});


    const optimize = b.standardOptimizeOption(.{});

    const pkg = b.dependency("zconn", .{
        .target = target,
        .optimize = optimize
    });

    //_= pkg;


    const example = pkg.builder.addExecutable(.{
        .target = target,
        .name = "example",
        .root_source_file = .{ .path = "src/main.zig" },
        .optimize = optimize,
        .link_libc = true
    });

    example.root_module.addImport("zconn", pkg.module("zconn"));
    //_= example;
    //_ = pkg;
    const libs_to_link = [_][]const u8{"mysqlclient","zstd","ssl", "crypto" ,"resolv" ,"m"};

    example.linkLibC();
	
    for(libs_to_link) |l| {
        example.linkSystemLibrary(l);
    }

    b.installArtifact(example);

}
