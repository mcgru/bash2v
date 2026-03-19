module bashrt

pub fn case_match(value string, pattern string) bool {
    return match_pattern(value, pattern, 0, 0)
}

fn match_pattern(value string, pattern string, value_idx int, pattern_idx int) bool {
    if pattern_idx >= pattern.len {
        return value_idx >= value.len
    }
    if pattern[pattern_idx] == `*` {
        mut next_pattern_idx := pattern_idx
        for next_pattern_idx < pattern.len && pattern[next_pattern_idx] == `*` {
            next_pattern_idx++
        }
        if next_pattern_idx >= pattern.len {
            return true
        }
        mut i := value_idx
        for i <= value.len {
            if match_pattern(value, pattern, i, next_pattern_idx) {
                return true
            }
            i++
        }
        return false
    }
    if value_idx >= value.len {
        return false
    }
    if pattern[pattern_idx] == `?` {
        return match_pattern(value, pattern, value_idx + 1, pattern_idx + 1)
    }
    if value[value_idx] != pattern[pattern_idx] {
        return false
    }
    return match_pattern(value, pattern, value_idx + 1, pattern_idx + 1)
}
