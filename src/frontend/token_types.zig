// shoutout to https://github.com/INDA23PlusPlus/vm/blob/main/src/compiler/types.zig
const std = @import("std");

// enum of all lang symbols
// specified in src/docs/syntax.bnf
pub const Symbol = enum {
    STATEMENTS,
    END_OF_STATEMENTS,
    STATEMENT,

    VARIABLE_DECLARATION,
    VARIABLE_MUTATION,
    FUNCTION_DECLARATION,
    WHILE_LOOP,
    FOR_LOOP,
    IF_STATEMENT,
    ELIF_STATEMENT,
    ELSE_STATEMENT,
    SCOPE,
    FUNCTION_CALL,
    RET_STATEMENT,

    EXPRESSION,
    FUNCTION_PARAMETERS,
    NO_PARAM,
    FOR_HEADER,
    FUNCTION_ARGUMENTS,
    CALL_CONTINUATION,
    NO_ARGUMENTS,

    TERM,
    EXPRESSION_CONTINUATION,
    END_OF_EXPRESSION,
    OPERATOR,

    TYPE_DEFINITION,
    TYPE,

    EQUALS,
    EQUAL,
    NOT_EQUAL,
    PLUS,
    MINUS,
    TIMES,
    DIVIDE,
    MOD,
    AND,
    OR,
    GT,
    LT,
    GEQ,
    LEQ,
    OPEN_PARENTHESIS,
    CLOSED_PARENTHESIS,
    OPEN_CURLY,
    CLOSED_CURLY,
    SEMICOLON,
    COMMA,
    RET,
    INT_TYPE,
    FN_TYPE,
    ANY_TYPE,
    WHILE,
    FOR,
    IF,
    ELSE,
    ELIF,
    BREAK,

    IDENTIFIER,
};

pub const Token = struct {
    token_type: Symbol, // from above enum
    content: []const u8,
    cc_start: u32, // content character
    cc_end: u32,
    cln_start: u32, // content line
    cln_end: u32,
};
