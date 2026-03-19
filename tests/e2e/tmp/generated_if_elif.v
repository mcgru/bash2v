module main

import bash2v.bashrt

fn main() {
	mut st := bashrt.new_state()
	bashrt.set_scalar(mut st, 'x', bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '2' })] })!)
	if bashrt.eval_program_status(mut st, bashrt.EvalProgram{ stmts: [bashrt.EvalStmt(bashrt.EvalExec{ assignments: [], argv: [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '[' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.DoubleQuotedFragment{ parts: [bashrt.WordFragment(bashrt.ParamExpansion{ name: 'x', index: none, indirection: false, enumerate_keys: false, count_items: false, array_mode: bashrt.ParamArrayMode.none, op: bashrt.ParamOp(bashrt.ParamOpNone{}) })] })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '-eq' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '1' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: ']' })] }] })] })! == 0 {
		bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'one' })] }])!
	} else {
		if bashrt.eval_program_status(mut st, bashrt.EvalProgram{ stmts: [bashrt.EvalStmt(bashrt.EvalExec{ assignments: [], argv: [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '[' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.DoubleQuotedFragment{ parts: [bashrt.WordFragment(bashrt.ParamExpansion{ name: 'x', index: none, indirection: false, enumerate_keys: false, count_items: false, array_mode: bashrt.ParamArrayMode.none, op: bashrt.ParamOp(bashrt.ParamOpNone{}) })] })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '-eq' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '2' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: ']' })] }] })] })! == 0 {
			bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'two' })] }])!
		} else {
			bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'other' })] }])!
		}
	}
}
