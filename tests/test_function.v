// Test: Function definition and call
module main

import os
import vscriptish

// Variable storage for indirection
mut __vars := map[string]string{}

fn main() {
	greet('World')
}

fn greet() {
	// Positional parameters available via os.args
	println('Hello, ${os.args[1]}!')
}
