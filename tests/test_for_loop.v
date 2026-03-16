// Test: For loop with values
module main

import os
import vscriptish

// Variable storage for indirection
mut __vars := map[string]string{}

fn main() {
	for i in [1, 2, 3] {
		println('Number: ${i}')
	}
}
