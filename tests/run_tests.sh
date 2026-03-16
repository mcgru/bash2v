#!/bin/bash
# Test runner for bash-to-vlang transpiler

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TRANSILER="$SCRIPT_DIR/../src/main.v"
PASSED=0
FAILED=0
SKIPPED=0

echo "================================"
echo "Bash-to-Vlang Transpiler Tests"
echo "================================"
echo ""

# Check if vlang is available
if ! command -v v &> /dev/null; then
    echo "Error: vlang (v) is not installed or not in PATH"
    exit 1
fi

for test_file in "$SCRIPT_DIR"/test_*.sh; do
    test_name=$(basename "$test_file" .sh)
    expected_file="$SCRIPT_DIR/${test_name}.v"
    
    if [ ! -f "$expected_file" ]; then
        echo "⚠️  SKIP: $test_name (no expected output file)"
        ((SKIPPED++))
        continue
    fi
    
    echo -n "Testing $test_name... "
    
    # Run transpiler
    output=$(v run "$TRANSILER" "$test_file" 2>&1) || {
        echo "❌ FAIL (transpiler error)"
        echo "   Error: ${output:0:200}"
        ((FAILED++))
        continue
    }
    
    # Compare with expected
    expected=$(cat "$expected_file")
    
    # Normalize whitespace for comparison
    output_normalized=$(echo "$output" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
    expected_normalized=$(echo "$expected" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
    
    if [ "$output_normalized" = "$expected_normalized" ]; then
        echo "✅ PASS"
        ((PASSED++))
    else
        echo "❌ FAIL"
        echo "  --- Expected (first 10 lines) ---"
        echo "$expected" | head -10 | sed 's/^/  | /'
        echo "  --- Got (first 10 lines) ---"
        echo "$output" | head -10 | sed 's/^/  | /'
        ((FAILED++))
    fi
done

echo ""
echo "================================"
echo "Results: $PASSED passed, $FAILED failed, $SKIPPED skipped"
echo "================================"

if [ $FAILED -gt 0 ]; then
    exit 1
fi

exit 0
