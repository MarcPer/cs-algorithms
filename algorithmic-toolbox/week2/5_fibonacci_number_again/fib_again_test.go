package main

import "testing"

func TestLastFib(t *testing.T) {
	tests := []struct {
		a, mod int
		out    int
	}{
		{0, 2, 0}, {1, 2, 1}, {2, 2, 1}, {3, 2, 0}, {4, 2, 1}, {5, 2, 1},
		{0, 3, 0}, {1, 3, 1}, {2, 3, 1}, {3, 3, 2}, {4, 3, 0}, {5, 3, 2}, {6, 3, 2}, {7, 3, 1}, {8, 3, 0}, {9, 3, 1},
		{100, 999, 858},
	}

	for _, tt := range tests {
		res := fibMod(tt.a, tt.mod)
		if res != tt.out {
			t.Errorf("Fib(%d) mod %d: want=%d, got=%d", tt.a, tt.mod, tt.out, res)
		}
	}
}
