# Bash-to-Vlang Transpiler Skill

Ты - профессионал, сеньор при написании скриптов bash v.5.1+, с активным использованием всех башизмов.
Ты также - профессионал, сеньор в использовании Vlang v0.5.1+, умеешь пользоваться vlang.stdlib, а также наизусть знаешь документацию vlang.

## Core Principles
1. Все линейные переменные bash считаются строковыми (кроме массивов)
2. Типы преобразуются явно: `int()`, `f64()`, где требуется арифметика
3. Nameref реализуется через мапы `map[string]string`
4. Ассоциативные массивы — через `map[string]string` или `map[string]int`
5. Pipeline — через модуль `vscriptish` (порт go_scriptish)

## Skill Name
`bash2v`

## Description
Specialized skill for transpiling Bash v5.1 scripts to Vlang v0.5.1 code.

## Capabilities
- Parse Bash v5.1 syntax into AST
- Translate Bash constructs to idiomatic Vlang
- Handle edge cases: quoting, expansions, special variables
- Validate output Vlang compiles and runs
- Provide migration guidance and warnings

## Usage
```bash
# Transpile a script
v run src/main.v input.sh > output.v

# Check compatibility
v run src/main.v --check input.sh

# Generate with comments
v run src/main.v --verbose input.sh > output.v
```

## Supported Bash Features
| Feature | Status | Notes |
|---------|--------|-------|
| Variables | ✅ | Typed in Vlang |
| Arrays | ️ | Indexed and associative |
| Functions | ✅ | Converted to Vlang fns |
| Conditionals | ✅ | if/else → match |
| Case statements | ✅ | case → match |
| For loops | ✅ | for → for range |
| While loops | ✅ | while → for |
| Pipelines | ⚠️ | Via os.pipe |
| Redirections | ⚠️ | Via os.File |
| Command substitution | ✅ | Backticks → os.exec |

## Limitations
- ❌ Coprocesses (coproc)
- ❌ Signal trapping (trap) — partial

## Best Practices
1. Run `shellcheck` on input Bash scripts first
2. Review generated Vlang for semantic correctness
3. Test both original and transpiled scripts with same inputs
4. Use `--verbose` for debugging complex scripts

## Integration
- Can be used as CLI tool
- Can be imported as Vlang module
- Supports CI/CD pipelines

## Examples
See `./examples/` directory for sample conversions.
