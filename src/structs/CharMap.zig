// credit to Jonathan Hallstrom for this <3
const std = @import("std");
const builtin = @import("builtin");

fn CharMap(comptime T: type) type {
    return struct {
        pub const Iterator = struct {
            pub const Entry = struct {
                const key_ptr = @compileError("can't get a pointer to keys since keys are implicity");
                key: u8,
                value_ptr: *T,
            };

            const Parent = CharMap(T);

            parent: *CharMap(T),
            idx: usize = 0,

            fn update(self: *Iterator) void {
                while (self.idx < 256 and self.parent.data[self.idx] == null) {
                    self.idx += 1;
                }
            }

            pub fn next(self: *Iterator) ?Entry {
                self.update();
                if (self.idx == 256) {
                    return null;
                }

                const res = if (self.parent.data[self.idx]) |*v| v else unreachable;
                defer self.idx += 1;
                return .{ .key = @truncate(self.idx), .value_ptr = res };
            }
        };

        const Self = @This();

        data: [256]?T = .{null} ** 256,

        pub fn get(self: *const Self, char: u8) ?T {
            return self.data[char];
        }

        pub fn put(self: *Self, char: u8, value: T) void {
            self.data[char] = value;
        }

        pub fn iterator(self: *Self) Iterator {
            return .{
                .parent = self,
            };
        }
    };
}
