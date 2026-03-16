# Examples

This directory contains example Bash scripts and their Vlang transpiled equivalents.

## Files

| Bash Script | Vlang Output | Description |
|-------------|--------------|-------------|
| `hello_world.sh` | `hello_world.v` | Basic variables and loops |
| `conditionals.sh` | `conditionals.v` | if/else and case statements |

## Usage

```bash
# View original Bash script
cat hello_world.sh

# Transpile (if transpiler is built)
v run ../src/main.v hello_world.sh

# Compare with expected output
diff <(v run ../src/main.v hello_world.sh) hello_world.v
```

## Adding New Examples

1. Create a new `.sh` file with Bash code
2. Run the transpiler to generate `.v` output
3. Review and manually adjust the Vlang output if needed
4. Document the example in this README
