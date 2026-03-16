// Test: Case statement
module main

import os
import vscriptish

// Variable storage for indirection
mut __vars := map[string]string{}

fn main() {
	cmd := 'start'
	__vars['cmd'] = cmd
	match cmd {
		'start' {
			println('Starting...')
		}
		'stop' {
			println('Stopping...')
		}
		else {
			println('Unknown command')
		}
	}
}
