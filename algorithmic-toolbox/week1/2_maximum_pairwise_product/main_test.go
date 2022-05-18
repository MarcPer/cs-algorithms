package main

import "testing"

func TestMaxProduct(t *testing.T) {
	tests := []struct {
		n   int
		in  []int
		out int
	}{
		{3, []int{1, 2, 3}, 6},
		{2, []int{1, 1}, 1},
		{6, []int{10, 10, 1, 2, 3, 4}, 100},
	}

	for _, tt := range tests {
		out := maxProduct(tt.n, tt.in)
		if out != tt.out {
			t.Errorf("want=%v, got=%v", tt.out, out)
		}
	}
}
