# Bash Grammar Reference

## Overview
This document describes the Bash v5.1 grammar constructs supported by the transpiler.

## Token Types

### Keywords
```
if, then, else, elif, fi
case, esac, in
for, while, until, do, done
function, return
break, continue, exit
```

### Operators
```
=, +=, -=, *=, /=
-eq, -ne, -lt, -le, -gt, -ge
&&, ||, !
|, >>, >, <, 2>&1
```

### Special Variables
```
$0, $1, $2, ...    # Positional parameters
$#                 # Number of arguments
$@, $*             # All arguments
$?                 # Exit status of last command
$$                 # PID of current shell
$!                 # PID of last background job
$HOME, $PATH, etc. # Environment variables
```

## Grammar Rules

### Script
```ebnf
script = { command | function | control_structure } ;
```

### Commands
```ebnf
command = word { word | redirection } ;
redirection = ('>' | '>>' | '<' | '2>&1') filename ;
```

### Variables
```ebnf
variable_assignment = name '=' value ;
value = { char | '$' name | '$(' command ')' | '`' command '`' } ;
```

### Conditionals
```ebnf
if_statement = 'if' test 'then' { command } { 'elif' test 'then' { command } } [ 'else' { command } ] 'fi' ;
test = '[' expression ']' | '[[' expression ']]' ;
```

### Case Statement
```ebnf
case_statement = 'case' word 'in' { pattern ')' { command } ';;' } 'esac' ;
pattern = { char | '*' | '?' | '[' char_range ']' } ;
```

### Loops
```ebnf
for_loop = 'for' name 'in' { word } 'do' { command } 'done' ;
while_loop = 'while' test 'do' { command } 'done' ;
until_loop = 'until' test 'do' { command } 'done' ;
```

### Functions
```ebnf
function = 'function' name '(' ')' { command } | name '(' ')' { command } ;
```

### Nameref (Name Reference)
```ebnf
nameref = 'declare' '-n' name '=' ref_name ;
```

### Associative Arrays
```ebnf
assoc_array = 'declare' '-A' name '=' '(' [key '=' value] ')' ;
```

## Supported Features (Extended)
- ✅ Name references (`declare -n`) — via `[]string{}`
- ✅ Associative arrays (`declare -A`)
- ✅ All linear variables as strings with type conversion

## Unsupported Features
- Coprocesses (`coproc`)
- Complex process substitution
- `eval` (security concerns)
