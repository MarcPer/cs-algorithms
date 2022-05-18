package main

import "testing"

func TestFib(t *testing.T) {
	tests := []struct {
		in  int
		out int
	}{
		{0, 0},
		{1, 1},
		{2, 1},
		{3, 2},
		{4, 3},
		{5, 5},
		{6, 8},
		{7, 13},
		{8, 21},
	}

	for _, tt := range tests {
		res := fib(tt.in)
		if res != tt.out {
			t.Errorf("want=%d, got=%d", tt.out, res)
		}
	}
}
