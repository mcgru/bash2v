module main

import os
import parser
import emitter

struct CliArgs {
mut:
	input_file    string
	output_file   string
	verbose       bool
	check_only    bool
	show_help     bool
	show_version  bool
}

const version = '0.1.0'

fn print_help() {
	println('Bash to Vlang Transpiler v${version}')
	println('')
	println('Usage:')
	println('  bash2v [options] <input.sh>')
	println('  bash2v [options] -o output.v <input.sh>')
	println('')
	println('Options:')
	println('  -o, --output <file>  Output file (default: stdout)')
	println('  -v, --verbose        Verbose output with comments')
	println('  -c, --check          Check compatibility without generating code')
	println('  -h, --help           Show this help message')
	println('  --version            Show version')
}

fn print_version() {
	println('bash2v version ${version}')
}

fn parse_args(args []string) !CliArgs {
	mut cli := CliArgs{
		input_file: ''
		output_file: ''
		verbose: false
		check_only: false
		show_help: false
		show_version: false
	}

	mut i := 1
	for i < args.len {
		match args[i] {
			'-h', '--help' {
				cli.show_help = true
			}
			'--version' {
				cli.show_version = true
			}
			'-v', '--verbose' {
				cli.verbose = true
			}
			'-c', '--check' {
				cli.check_only = true
			}
			'-o', '--output' {
				if i + 1 < args.len {
					i++
					cli.output_file = args[i]
				} else {
					return error('missing argument for -o')
				}
			}
			'-' {
				cli.input_file = '-'
			}
			else {
				if args[i].starts_with('-') {
					return error('unknown option: ${args[i]}')
				}
				cli.input_file = args[i]
			}
		}
		i++
	}

	return cli
}

fn main() {
	args := os.args

	cli := parse_args(args) or {
		eprintln('Error: ${err.msg}')
		print_help()
		exit(1)
	}

	if cli.show_help {
		print_help()
		exit(0)
	}

	if cli.show_version {
		print_version()
		exit(0)
	}

	if cli.input_file == '' {
		eprintln('Error: no input file specified')
		print_help()
		exit(1)
	}

	mut input := ''
	if cli.input_file == '-' {
		// Read from stdin - not implemented for now
		eprintln('Error: stdin input not supported yet')
		exit(1)
	} else {
		input = os.read_file(cli.input_file) or {
			eprintln('Error reading file: ${err.msg}')
			exit(1)
		}
	}

	if cli.verbose {
		eprintln('// Parsing: ${cli.input_file}')
		eprintln('// Input size: ${input.len} bytes')
	}

	mut p := parser.new_parser(input)
	script := p.parse_script()

	if cli.verbose {
		eprintln('// Parsed ${script.len()} statements')
		eprintln('')
	}

	if cli.check_only {
		eprintln('Check mode: parsing successful')
		eprintln('Statements found: ${script.len()}')
		exit(0)
	}

	mut e := emitter.Emitter{verbose: cli.verbose}
	output := e.emit_script(script)

	if cli.output_file != '' {
		os.write_file(cli.output_file, output) or {
			eprintln('Error writing output: ${err.msg}')
			exit(1)
		}
		if cli.verbose {
			eprintln('// Written to: ${cli.output_file}')
		}
	} else {
		println(output)
	}
}
