# Implementation Constraints

## Overview
This document describes the mandatory constraints for the Bash-to-Vlang transpiler implementation.

## Core Constraints

### 1. Variable Types
- **All linear bash variables are strings** (except arrays and associative arrays)
- Add explicit type conversion where needed:
  - `int()` for integer arithmetic
  - `f64()` for floating-point arithmetic

```bash
# Bash
num="42"
result=$((num + 10))
```

```v
// Vlang
num := '42'
result := num.int() + 10
```

### 2. Nameref Implementation
- Implement `declare -n` (name references) via `map[string]string`
- Store variable values in a central map for indirection

```bash
# Bash
declare -n ref=myvar
ref="new value"
```

```v
// Vlang
mut vars := map[string]string{
    'myvar': 'initial'
}
// ref points to myvar
vars['myvar'] = 'new value'
```

### 3. Associative Arrays
- Support `declare -A` for associative arrays
- Implement via `map[string]string` or typed maps

```bash
# Bash
declare -A colors=([red]="#ff0000" [green]="#00ff00")
```

```v
// Vlang
colors := map[string]string{
    'red': '#ff0000',
    'green': '#00ff00'
}
```

### 4. Nested Commands
- **Carefully handle nested bash commands**
- Process command substitution `$(...)` recursively
- Handle nested quotes and expansions
- Add detailed comments for complex nested structures using `#%#` markers

```bash
# Bash - nested command
result=$(echo "Value: $(date +%Y)")
```

```v
// Vlang
#%#
# Nested command analysis:
# 1. Inner: date +%Y -> returns year as string
# 2. Outer: echo "Value: $(inner_result)" -> interpolates year
# 3. Assignment: result captures the output
# Variable transformations:
#   - date output: string
#   - echo output: string
#   - result: string (no conversion needed)
#%#
result := os.exec('echo "Value: $(date +%Y)"')!
```

### 5. Pipeline Implementation
- Use `go_scriptish` project as reference for pipeline handling
- Port the approach to Vlang as `vscriptish` module
- Reference: https://github.com/ganbarodigital/go_scriptish

```bash
# Bash
cat file.txt | grep "pattern" | wc -l
```

```v
// Vlang - using vscriptish
import vscriptish

result := vscriptish.run_pipeline([
    'cat file.txt',
    'grep "pattern"',
    'wc -l'
])!
```

### 6. Pipe Handling
- Use approach from https://labix.org/pipe
- See examples in `devel-ex/labix.*.go` files
- Implement proper stream handling for pipelines

## Code Style Requirements

### Comment Format for Complex Commands
When processing complex bash commands, add detailed comments:

```v
#%#
# Command: <bash_command>
# Structure:
#   - Level 1: <description>
#   - Level 2: <nested description>
# Variable transformations:
#   - <var1>: <type> -> <type>
#   - <var2>: <type> -> <type>
# Execution flow:
#   1. <step 1>
#   2. <step 2>
#%#
```

## Module Structure

### vscriptish Module
Create a `vscriptish` module (port of `go_scriptish`):

```
./src/vscriptish/
├── vscriptish.v    # Main module
├── pipe.v          # Pipeline handling
├── redirect.v      # Redirection handling
└── exec.v          # Command execution
```

## References

| Resource | Purpose |
|----------|---------|
| [go_scriptish](https://github.com/ganbarodigital/go_scriptish) | Pipeline implementation reference |
| [labix.org/pipe](https://labix.org/pipe) | Pipe handling approach |
| `devel-ex/labix.*.go` | Local examples of pipe usage |
