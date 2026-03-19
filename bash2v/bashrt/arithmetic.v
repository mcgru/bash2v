module bashrt

struct ArithmeticParser {
    input string
mut:
    pos int
}

pub fn eval_arithmetic(mut state State, expr string) !string {
    mut parser := ArithmeticParser{
        input: expr
    }
    value := parser.parse_expr(mut state)!
    parser.skip_ws()
    if parser.pos != parser.input.len {
        return error('invalid arithmetic expression: ${expr}')
    }
    return value.str()
}

fn (mut parser ArithmeticParser) parse_expr(mut state State) !int {
    mut value := parser.parse_term(mut state)!
    for {
        parser.skip_ws()
        if parser.match_char(`+`) {
            value += parser.parse_term(mut state)!
            continue
        }
        if parser.match_char(`-`) {
            value -= parser.parse_term(mut state)!
            continue
        }
        break
    }
    return value
}

fn (mut parser ArithmeticParser) parse_term(mut state State) !int {
    mut value := parser.parse_factor(mut state)!
    for {
        parser.skip_ws()
        if parser.match_char(`*`) {
            value *= parser.parse_factor(mut state)!
            continue
        }
        if parser.match_char(`/`) {
            rhs := parser.parse_factor(mut state)!
            if rhs == 0 {
                return error('division by zero')
            }
            value /= rhs
            continue
        }
        if parser.match_char(`%`) {
            rhs := parser.parse_factor(mut state)!
            if rhs == 0 {
                return error('division by zero')
            }
            value %= rhs
            continue
        }
        break
    }
    return value
}

fn (mut parser ArithmeticParser) parse_factor(mut state State) !int {
    parser.skip_ws()
    if parser.match_char(`+`) {
        return parser.parse_factor(mut state)
    }
    if parser.match_char(`-`) {
        return -parser.parse_factor(mut state)!
    }
    if parser.match_char(`(`) {
        value := parser.parse_expr(mut state)!
        parser.skip_ws()
        if !parser.match_char(`)`) {
            return error('missing closing parenthesis')
        }
        return value
    }
    if parser.peek() >= `0` && parser.peek() <= `9` {
        return parser.parse_number()
    }
    if is_arith_name_start(parser.peek()) {
        name := parser.parse_ident()
        return get_scalar(state, name).int()
    }
    return error('unexpected token in arithmetic expression')
}

fn (mut parser ArithmeticParser) parse_number() !int {
    start := parser.pos
    for parser.peek() >= `0` && parser.peek() <= `9` {
        parser.pos++
    }
    return parser.input[start..parser.pos].int()
}

fn (mut parser ArithmeticParser) parse_ident() string {
    start := parser.pos
    parser.pos++
    for is_arith_name_continue(parser.peek()) {
        parser.pos++
    }
    return parser.input[start..parser.pos]
}

fn (mut parser ArithmeticParser) skip_ws() {
    for parser.peek() == ` ` || parser.peek() == `\t` || parser.peek() == `\n` || parser.peek() == `\r` {
        parser.pos++
    }
}

fn (mut parser ArithmeticParser) match_char(ch u8) bool {
    if parser.peek() != ch {
        return false
    }
    parser.pos++
    return true
}

fn (parser ArithmeticParser) peek() u8 {
    if parser.pos >= parser.input.len {
        return 0
    }
    return parser.input[parser.pos]
}

fn is_arith_name_start(ch u8) bool {
    return ch == `_` || (ch >= `a` && ch <= `z`) || (ch >= `A` && ch <= `Z`)
}

fn is_arith_name_continue(ch u8) bool {
    return is_arith_name_start(ch) || (ch >= `0` && ch <= `9`)
}
