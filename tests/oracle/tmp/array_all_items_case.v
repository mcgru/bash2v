module main

import bash2v.bashrt

fn main() {
	mut st := bashrt.new_state()
	bashrt.set_indexed_values(mut st, 'arr', [])
	bashrt.append_indexed_values(mut st, 'arr', [bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'item1' })] })!, bashrt.eval_word(mut st, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.DoubleQuotedFragment{ parts: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'it5' }), bashrt.WordFragment(bashrt.LiteralFragment{ text: ' ' }), bashrt.WordFragment(bashrt.LiteralFragment{ text: 'ooo' })] })] })!])
	bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'printf' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.DoubleQuotedFragment{ parts: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '<%s>\\n' })] })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.DoubleQuotedFragment{ parts: [bashrt.WordFragment(bashrt.ParamExpansion{ name: 'arr', index: none, indirection: false, enumerate_keys: false, count_items: false, array_mode: bashrt.ParamArrayMode.all_star, op: bashrt.ParamOp(bashrt.ParamOpNone{}) })] })] }])!
	bashrt.run_exec_words(mut st, [bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.LiteralFragment{ text: 'printf' })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.DoubleQuotedFragment{ parts: [bashrt.WordFragment(bashrt.LiteralFragment{ text: '<%s>\\n' })] })] }, bashrt.Word{ fragments: [bashrt.WordFragment(bashrt.DoubleQuotedFragment{ parts: [bashrt.WordFragment(bashrt.ParamExpansion{ name: 'arr', index: none, indirection: false, enumerate_keys: false, count_items: false, array_mode: bashrt.ParamArrayMode.all_at, op: bashrt.ParamOp(bashrt.ParamOpNone{}) })] })] }])!
}
