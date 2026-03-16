# Bash to Vlang Transpiler

A source-to-source transpiler that converts Bash v5.1 scripts to Vlang v0.5.1 code.

## Quick Start

```bash
# Transpile a Bash script
v run . script.sh > script.v

# Run the transpiled Vlang code
v run script.v
```

## Installation

```bash
# Clone the repository
cd /home/mcgru/work/qwen/bash2v

# Build the transpiler
v build -o bash2v .

# Install globally (optional)
sudo cp ./bash2v /usr/local/bin/
```

## Features

- ✅ Variables (as strings)
- ✅ echo → println()
- ⚠️ Conditionals (if/else) - basic support
- ⚠️ Loops (for, while) - basic support
- ❌ Functions - in development
- ❌ Pipelines - via vscriptish module
- ❌ Redirections - in development

## Usage

```bash
# Basic transpilation
v run . input.sh > output.v

# With output file
v run . input.sh -o output.v

# Verbose output
v run . input.sh --verbose

# Check mode (parse only)
v run . input.sh --check
```

## Example

**input.sh**:
```bash
#!/bin/bash
name="World"
echo "Hello, $name!"
```

**output.v**:
```v
module main

import os
import vscriptish

fn main() {
	name := "World"
	println("Hello, World!")
}
```

## Testing

```bash
# Create test script
echo 'name="Test"
echo "Hello"' > /tmp/test.sh

# Transpile
v run . /tmp/test.sh

# Run result
v run /tmp/test.v
```

## Documentation

- [Project Overview](project.md)
- [Agent Instructions](AGENTS.md)
- [Skill Definition](SKILL.md)
- [Examples](examples/)

## Limitations

- All variables are strings (per constraints)
- Does not support: coproc, complex arrays
- Some constructs may require manual review
- External command semantics preserved as-is

## License

MIT

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new features
4. Submit a pull request
