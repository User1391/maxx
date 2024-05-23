// lots of insight from https://mitchellh.com/zig/tokenizer
const std = @import("std");
const types = @import("token_types.zig");

// set up errors
const TokenizerError = error{
    InvalidCharacter,
};

const Symbol = types.Symbol;
const Token = types.Token;

const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

const Self = @This();

allocator: Allocator,
tokens: ArrayList(Token),

pub fn init(allocator: Allocator) Self {
    return .{ .allocator = allocator, .tokens = ArrayList(Token.init(allocator)) };
}

pub fn deinit(self: *Self) void {
    for (self.tokens.items) |i| {
        self.allocator.free(i.content);
    }
    self.tokens.deinit();
}

pub fn tokenize(self: *Self, text: []const u8) !void {
    var ln: u32 = 1;
    var cn: u32 = 1;

    for (text) |char| {
        
    }
}




test "Tokenize Example Code" {
    var lexer = Self.init(std.heap.GeneralPurposeAllocator);
    defer lexer.deinit();

    try lexer.tokenize("varName[int] = 24;");

    try std.testing.expectEqual(lexer.tokens.items.len, 5);




}
