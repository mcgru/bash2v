module bashrt

pub struct Word {
pub:
    fragments []WordFragment
}

pub struct LiteralFragment {
pub:
    text string
}

pub struct DoubleQuotedFragment {
pub:
    parts []WordFragment
}

pub struct ParamOpNone {}

pub struct ParamOpLowerAll {}

pub struct ParamOpUpperAll {}

pub struct ParamOpReplaceOne {
pub:
    pattern     Word
    replacement Word
}

pub struct ParamOpReplaceAll {
pub:
    pattern     Word
    replacement Word
}

pub struct ParamOpLength {}

pub struct ParamOpDefaultValue {
pub:
    fallback Word
    assign   bool
}

pub struct ParamOpAlternativeValue {
pub:
    alternate Word
}

pub struct ParamOpRequiredValue {
pub:
    message Word
}

pub type ParamOp = ParamOpNone | ParamOpLowerAll | ParamOpUpperAll | ParamOpReplaceOne | ParamOpReplaceAll | ParamOpLength | ParamOpDefaultValue | ParamOpAlternativeValue | ParamOpRequiredValue

pub enum ParamArrayMode {
    none
    all_star
    all_at
}

pub struct ParamExpansion {
pub:
    name           string
    index          ?Word
    indirection    bool
    enumerate_keys bool
    count_items    bool
    array_mode     ParamArrayMode = .none
    op             ParamOp = ParamOpNone{}
}

pub struct CommandSubstFragment {
pub:
    source  string
    program EvalProgram
}

pub struct ArithmeticFragment {
pub:
    expr string
}

pub type WordFragment = LiteralFragment | DoubleQuotedFragment | ParamExpansion | CommandSubstFragment | ArithmeticFragment

pub struct WordValue {
pub:
    text   string
    quoted bool
}

pub fn eval_word(mut state State, word Word) !string {
    return eval_word_values(mut state, word)!.join(' ')
}

pub fn eval_word_values(mut state State, word Word) ![]string {
    return eval_fragments_values(mut state, word.fragments, false)
}

fn eval_fragments_values(mut state State, fragments []WordFragment, quoted bool) ![]string {
    if fragments.len == 0 {
        return ['']
    }
    mut acc := ['']
    for fragment in fragments {
        values := eval_fragment_values(mut state, fragment, quoted)!
        if values.len == 0 {
            return []string{}
        }
        mut next := []string{}
        for prefix in acc {
            for value in values {
                next << prefix + value
            }
        }
        acc = next.clone()
    }
    return acc
}

fn eval_fragment_values(mut state State, fragment WordFragment, quoted bool) ![]string {
    return match fragment {
        LiteralFragment {
            [fragment.text]
        }
        DoubleQuotedFragment {
            eval_fragments_values(mut state, fragment.parts, true)!
        }
        ParamExpansion {
            expand_param_values(mut state, fragment, quoted)!
        }
        CommandSubstFragment {
            [eval_command_subst(mut state, fragment)!]
        }
        ArithmeticFragment {
            [eval_arithmetic(mut state, fragment.expr)!]
        }
    }
}
