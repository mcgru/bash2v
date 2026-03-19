module main

import bash2v.bashrt

fn main() {
	mut st := bashrt.new_state()
	if bashrt.eval_program_status(mut st, bashrt.EvalProgram{ stmts: [bashrt.EvalStmt(bashrt.EvalExec{ assignments: [], argv: [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'test' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '5' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '-gt' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '3' })] }] })] })! == 0 {
		bashrt.run_exec(mut st, [bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] })!, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'yes' })] })!])!
	} else {
		bashrt.run_exec(mut st, [bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] })!, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'no' })] })!])!
	}
	if bashrt.eval_program_status(mut st, bashrt.EvalProgram{ stmts: [bashrt.EvalStmt(bashrt.EvalExec{ assignments: [], argv: [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '[' }), bashrt.WordFragment(bashrt.LiteralFragment{ text: '[' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '-z' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'bar' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: ']' }), bashrt.WordFragment(bashrt.LiteralFragment{ text: ']' })] }] })] })! == 0 {
		bashrt.run_exec(mut st, [bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] })!, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'no' })] })!])!
	} else {
		bashrt.run_exec(mut st, [bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] })!, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'ok' })] })!])!
	}
}
