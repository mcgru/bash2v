# Agent Instructions for Bash-to-Vlang Transpiler

## Project Context
This project transpiles Bash v5.1 scripts to Vlang v0.5.1 code.

## Development Guidelines

### Code Style
- Follow Vlang style guide (`v fmt`)
- Use descriptive variable names
- Add comments for complex translation logic

### Bash Parsing
- Use established parsing tools (bash -n, shellcheck) for validation
- Build AST before translation
- Handle edge cases: quoted strings, expansions, special variables
- Важно! В процессе разбора скрипта bash - напиши отдельно (в виде комментария, обрамлённого символами #%# и #%#) словами - что делается в данной сложной составной команде, распиши все вложения и преобразования переменных.

### Vlang Generation
- Generate idiomatic Vlang code
- Prefer `os.exec()` over system()
- Use Vlang's error handling (`?` functions)
- Add type annotations where inference fails

### Testing
- Every Bash feature must have test coverage
- Tests include: input.sh, expected.v, run both, compare behavior
- Validate generated Vlang compiles and runs

### Error Reporting
- Provide clear error messages with line numbers
- Suggest Vlang alternatives for unsupported Bash features
- Exit gracefully on parse errors

## Common Tasks

### Adding New Bash Construct Support
1. Add parser rule in `src/parser/`
2. Add AST node in `src/ast/`
3. Add Vlang emitter in `src/emitter/`
4. Add test cases in `tests/`
5. Update documentation in `docs/`

### Debugging Translation Issues
1. Enable verbose mode: `v run src/main.v --verbose <input.sh>`
2. Inspect generated AST
3. Compare with expected Vlang output
4. Check Bash semantics vs Vlang semantics

## Known Challenges
- **Arrays**: Bash arrays are dynamic; Vlang arrays are typed
- **Variable scope**: Bash has global/function scope; Vlang has block scope
- **Exit codes**: Bash `$?` vs Vlang error handling
- **String interpolation**: `${var}` vs `${var}` (similar but different rules)

## Resources
- `docs/bash-grammar.md` — Bash grammar reference
- `docs/vlang-mapping.md` — Bash-to-Vlang construct mapping
- `tests/coverage.md` — Feature coverage matrix
