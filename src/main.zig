
const std = @import("std");
const sql = @import("zconn");

var gpa = @import("std").heap.GeneralPurposeAllocator(.{}){};

pub fn main() !void {
    //var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const pool = try sql.Pool.init(allocator,.{ 
        .databaseName = "events",
         .host = "localhost",
          .password = "1234Victor",
           .username = "vic" 
           },
           4);
    defer pool.deInit();

    const conn = pool.getConnection();
    defer pool.dropConnection(conn);

    const res = try conn.executeQuery("select ? as Greeting", .{"hello world"});
    defer res.deinit();

 }   