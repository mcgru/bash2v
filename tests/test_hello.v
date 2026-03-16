// Test: Hello world with variable
module main

import os
import vscriptish

// Variable storage for indirection
mut __vars := map[string]string{}

fn main() {
	name := 'World'
	__vars['name'] = name
	println(name)
}
