// Test: While loop
module main

import os
import vscriptish

// Variable storage for indirection
mut __vars := map[string]string{}

fn main() {
	count := '0'
	__vars['count'] = count
	for count < 3 {
		println('Count: ${count}')
		count++
	}
}
