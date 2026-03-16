# Bash to Vlang Construct Mapping

## Variables

### Simple Variables
```bash
# Bash
name="value"
echo "$name"
```

```v
// Vlang
name := 'value'
os.echo(name)
```

### Arrays
```bash
# Bash
arr=(one two three)
echo "${arr[0]}"
```

```v
// Vlang
arr := ['one', 'two', 'three']
os.echo(arr[0])
```

## Conditionals

### If/Else
```bash
# Bash
if [ $x -gt 10 ]; then
    echo "big"
else
    echo "small"
fi
```

```v
// Vlang
if x > 10 {
    os.echo('big')
} else {
    os.echo('small')
}
```

### Case/Match
```bash
# Bash
case $cmd in
    start) echo "Starting" ;;
    stop) echo "Stopping" ;;
    *) echo "Unknown" ;;
esac
```

```v
// Vlang
match cmd {
    'start' {
        os.echo('Starting')
    }
    'stop' {
        os.echo('Stopping')
    }
    else {
        os.echo('Unknown')
    }
}
```

## Loops

### For Loop
```bash
# Bash
for i in 1 2 3; do
    echo $i
done
```

```v
// Vlang
for i in [1, 2, 3] {
    os.echo(i)
}
```

### While Loop
```bash
# Bash
while [ $count -lt 10 ]; do
    echo $count
    ((count++))
done
```

```v
// Vlang
mut count := 0
for count < 10 {
    os.echo(count)
    count++
}
```

## Functions

```bash
# Bash
greet() {
    echo "Hello, $1!"
}
greet "World"
```

```v
// Vlang
fn greet(name string) {
    os.echo('Hello, ${name}!')
}

greet('World')
```

## Command Execution

### Simple Command
```bash
# Bash
result=$(ls -la)
```

```v
// Vlang
result := os.exec('ls -la')!
```

### Pipeline
```bash
# Bash
cat file.txt | grep "pattern" | wc -l
```

```v
// Vlang
// Requires os.pipe for full implementation
```

## Redirections

### Output Redirection
```bash
# Bash
echo "text" > file.txt
```

```v
// Vlang
mut file := os.create('file.txt')!
file.write_string('text\n')
file.close()
```

## Arithmetic

```bash
# Bash
result=$((10 + 5 * 2))
((counter++))
```

```v
// Vlang
result := 10 + 5 * 2
counter++
```

## Special Variables Mapping

| Bash | Vlang Equivalent |
|------|------------------|
| `$0` | `os.args[0]` |
| `$1`, `$2` | `os.args[1]`, `os.args[2]` |
| `$#` | `os.args.len - 1` |
| `$@`, `$*` | `os.args[1..]` |
| `$?` | Error handling via `!` or `?` |
| `$$` | `os.get_pid()` |
| `$HOME` | `os.home_dir()` |
| `$PATH` | `os.get_env('PATH')` |

## Nameref (Name Reference)

```bash
# Bash
declare -n ref=myvar
ref="new value"
```

```v
// Vlang - using string array for indirection
mut vars := {
    'myvar': 'initial'
}
vars['myvar'] = 'new value'
```

## Associative Arrays

```bash
# Bash
declare -A colors=([red]="#ff0000" [green]="#00ff00")
echo "${colors[red]}"
```

```v
// Vlang
colors := {
    'red': '#ff0000',
    'green': '#00ff00'
}
os.echo(colors['red'])
```

## Type Conversion

```bash
# Bash - all variables are strings
num="42"
result=$((num + 10))
```

```v
// Vlang - explicit type conversion
num := '42'
result := num.int() + 10
```

## Pipeline Implementation

Based on `go_scriptish` and `labix.org/pipe`:

```bash
# Bash
cat file.txt | grep "pattern" | wc -l
```

```v
// Vlang - using vscriptish module
import vscriptish

result := vscriptish.pipe([
    'cat file.txt',
    'grep "pattern"',
    'wc -l'
])!
```
