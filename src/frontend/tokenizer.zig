// lots of insight from https://mitchellh.com/zig/tokenizer
const std = @import("std");
const types = @import("token_types.zig");
const cm = @import("../structs/CharMap.zig");

// set up errors
const TokenizerError = error{
    InvalidCharacter,
};

const ascii = std.ascii;

const Symbol = types.Symbol;
const Token = types.Token;

const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

const Self = @This();

allocator: Allocator,
tokens: ArrayList(Token),
token_associator: cm.CharMap(Symbol),

pub fn init(allocator: Allocator) Self {
    var token_associator = cm.CharMap(Symbol){};

    const single_char_tokens = [_]Symbol{ Symbol.EQUALS, Symbol.PLUS, Symbol.MINUS, Symbol.TIMES, Symbol.DIVIDE, Symbol.MOD, Symbol.GT, Symbol.LT, Symbol.OPEN_PARENTHESIS, Symbol.CLOSED_PARENTHESIS, Symbol.OPEN_CURLY, Symbol.CLOSED_CURLY, Symbol.SEMICOLON, Symbol.COMMA };

    const single_char_chars = [_]u7{ '=', '+', '-', '*', '/', '%', '>', '<', '(', ')', '{', '}', ';', ',' };

    for (single_char_chars, single_char_tokens) |char, sym| {
        token_associator.put(char, sym);
    }

    return .{ .allocator = allocator, .tokens = ArrayList(Token.init(allocator)), .token_associator = token_associator };
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

pub fn tokenize(self: *Self, text: []const u8) !void {
    var ln: u32 = 1;
    var cn: u32 = 1;

    var space_state: State = State.NONE;

    var curToken: Token = undefined;

    for (text, 0..) |char, curIdx| {
        _ = curIdx;
        ln = 1;

        switch (space_state) {
            State.NONE => {
                switch (char) {
                    // just remember that if strings are added this no longer works
                    // kind of, there may be other workarounds
                    ' ' => {
                        cn += 1;
                        continue;
                    },
                    else => {
                        // all other cases

                        // make sure to do check for identifier before this
                        // as there can be digits in variable names (just not first char)
                        if (ascii.isDigit(char)) {
                            // if it's a number, keep going until there's a space
                            space_state = State.INT;
                            curToken = Token{ .token_type = Symbol.INT, .content = char, .cc_start = cn, .cc_end = undefined, .cln_start = ln, .cln_end = undefined };
                        }
                    },
                }
            },
            State.INT => {
                // TODO Add newline check
                if (!ascii.isDigit(char)) {
                    // we have reached the end of our number
                    curToken.cc_end = cn - 1;
                    curToken.cln_end = ln;
                    self.tokens.append(curToken);

                    curToken = undefined;
                    space_state = State.NONE;
                } else {
                    // just add the number to the content
                    curToken.content = curToken.content + char;
                }
                cn += 1;
            },
        }
    }
}
