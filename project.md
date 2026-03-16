# Bash to Vlang Transpiler

## Description
A source-to-source transpiler that converts Bash v5.1 scripts to Vlang v0.5.1 code.

## Goal
Enable migration of Bash scripts to Vlang for better type safety, performance, and maintainability.

## Scope
- **Source**: Bash v5.1 (POSIX-compatible features + common extensions)
- **Target**: Vlang v0.5.1

## Supported Features
### Bash Constructs
- [ ] Variables and arrays
- [ ] Conditionals (if/else, case)
- [ ] Loops (for, while, until)
- [ ] Functions
- [ ] Pipelines and redirections
- [ ] Command substitution
- [ ] Process substitution
- [ ] Arithmetic expressions
- [ ] String manipulation

### Vlang Output
- [ ] Equivalent Vlang modules
- [ ] Type-inferred variables
- [ ] os.exec() for command execution
- [ ] Pattern matching for case statements

## Project Structure
```
./src              # Transpiler source code
./tests            # Test cases (bash scripts + expected vlang output)
./examples         # Example conversions
./docs             # Documentation
```

## Build & Run
```bash
# Development
v run src/main.v <input.sh>

# Build
v build src/main.v
```

## Testing
```bash
# Run test suite
v test ./tests

# Validate bash script
bash --version  # v5.1+

# Validate vlang output
v run <output>.v
```

## Limitations
- Does not support Bash-specific features: coproc
- Some constructs may require manual review
- External command semantics preserved as-is

## Implementation Constraints
See [`docs/constraints.md`](docs/constraints.md) for detailed constraints:
- Variable typing (all linear variables as strings)
- Nameref via `map[string]string`
- Associative arrays support
- Nested command handling with `#%#` comments
- Pipeline implementation via `vscriptish` module
- используй для Raw-символов обрамление через backtick. Но только если символ там один, и если он не backslash.
- используй `r"blzblz"` для обозначения raw-string
- будь внимателен, когда пишешь `tok.val = "${"` - в vlang конструкция `"${varname}"` - для вставки значения переменной в строку.

## Roadmap
1. [ ] Core parser for Bash AST
2. [ ] Basic statement translation
3. [ ] Function and variable handling
4. [ ] Pipeline and redirection support
5. [ ] Error handling and reporting
6. [ ] Optimization passes

## References
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [Vlang Documentation](https://vlang.io/docs)
- [Vlang os module](https://modules.vlang.io/os.html)
