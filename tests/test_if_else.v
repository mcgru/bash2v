// Test: Simple if-else condition
module main

import os
import vscriptish

// Variable storage for indirection
mut __vars := map[string]string{}

fn main() {
	age := '25'
	__vars['age'] = age
	if age < 18 {
		println('Minor')
	} else {
		println('Adult')
	}
}
