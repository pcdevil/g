function gcd {
	TOP_LEVEL_DIR=$(git rev-parse --show-toplevel 2>/dev/null)
	[ -n "$TOP_LEVEL_DIR" ] && cd "$TOP_LEVEL_DIR"
}
