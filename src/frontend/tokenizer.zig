// lots of insight from https://mitchellh.com/zig/tokenizer
const std = @import("std");
const types = @import("token_types.zig");
const cm = @import("structs/CharMap.zig");

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

const State = enum {
    NONE,
    INT,
    KEYWORD,
    IDENTIFIER,
};

const single_char_tokens = [_]Symbol{
    Symbol.EQUALS,
    Symbol.PLUS,
    Symbol.MINUS,
    Symbol.TIMES,
    Symbol.DIVIDE,
    Symbol.MOD,
    Symbol.GT,
    Symbol.LT,
    Symbol.OPEN_PARENTHESIS,
    Symbol.CLOSED_PARENTHESIS,
    Symbol.OPEN_CURLY,
    Symbol.CLOSED_CURLY,
    Symbol.SEMICOLON,
    Symbol.COMMA
};

const single_char_chars = [_]u8{
    '=',
    '+',
    '-',
    '*',
    '/',
    '%',
    '>',
    '<',
    '(',
    ')',
    '{',
    '}',
    ';',
    ','
};

var token_associator = cm.CharMap(Symbol){};

for (single_char_chars, single_char_tokens) |char, sym| {
    token_associator.put(char, sym);
}

pub fn tokenize(self: *Self, text: []const u8) !void {
    var ln: u32 = 1;
    var cn: u32 = 1;
    
    var space_state: State = State.NONE; 

    for (text) |char| {
        
        switch (char) {
            ' ' => { 
                cn += 1;
                continue; 
            },

        } 
    }
}

