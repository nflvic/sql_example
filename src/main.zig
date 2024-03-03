
const std = @import("std");
const sql = @import("zconn");

var gpa = @import("std").heap.GeneralPurposeAllocator(.{}){};

pub fn main() !void {
    const allocator = gpa.allocator();
    const conn = try sql.Connection.newConnection(allocator, .{ 
                                                                .username = "vic",
                                                                .databaseName = "events",
                                                                .password = "1234Victor",
                                                                .host = "localhost"
                                                                });


    const res = try conn.executeQuery("select 'hello world' as greeting;", .{});

    if(res.nextResultSet()) |t| {
        if(t.nextRow()) |r| {
            const row = try r.columns.?.toString();
            defer allocator.free(row);

            std.debug.print("{s}\n", .{row});
        } else {
            std.debug.print("Empty set\n", .{});
        }
    } else {
        std.debug.print("Failed to query\n", .{});
    }
 }   