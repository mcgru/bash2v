module main

import bash2v.bashrt

fn main() {
	mut st := bashrt.new_state()
	bashrt.set_scalar(mut st, 'name', bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'foo.txt' })] })!)
	{
		bash2v_case_subject := bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.DoubleQuotedFragment{ parts: [bashrt.WordFragment(bashrt.ParamExpansion{ name: 'name', index: none, indirection: false, enumerate_keys: false, count_items: false, array_mode: bashrt.ParamArrayMode.none, op: bashrt.ParamOp(bashrt.ParamOpNone{}) })] })] })!
		mut bash2v_case_matched := false
		if !bash2v_case_matched && (bashrt.case_match(bash2v_case_subject, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '*.log' })] })!)) {
			bash2v_case_matched = true
			bashrt.set_last_status(mut st, 0)
			bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'log' })] }])!
		}
		else if !bash2v_case_matched && (bashrt.case_match(bash2v_case_subject, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'foo.txt' })] })!) || bashrt.case_match(bash2v_case_subject, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'bar.txt' })] })!)) {
			bash2v_case_matched = true
			bashrt.set_last_status(mut st, 0)
			bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'hit' })] }])!
		}
		else if !bash2v_case_matched && (bashrt.case_match(bash2v_case_subject, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '*' })] })!)) {
			bash2v_case_matched = true
			bashrt.set_last_status(mut st, 0)
			bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'other' })] }])!
		}
		if !bash2v_case_matched {
			bashrt.set_last_status(mut st, 0)
		}
	}
	{
		bash2v_case_subject := bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'z' })] })!
		mut bash2v_case_matched := false
		if !bash2v_case_matched && (bashrt.case_match(bash2v_case_subject, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'foo' })] })!)) {
			bash2v_case_matched = true
			bashrt.set_last_status(mut st, 0)
			bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'no' })] }])!
		}
		if !bash2v_case_matched {
			bashrt.set_last_status(mut st, 0)
		}
	}
	bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'echo' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'after' })] }])!
	bashrt.exit_with_last_status(st)
}
