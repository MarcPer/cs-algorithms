package main

import (
	"testing"
)

func TestLastDigSumFib(t *testing.T) {
	tests := []struct {
		n   int
		out int
	}{
		{1, 1}, {2, 2}, {3, 6}, {4, 5}, {5, 0}, {6, 4}, {7, 3},
		{10, 5}, {11, 6}, {15, 0},
		{17, 8}, {27, 8},
		{50, 0}, {58, 9}, {59, 0},
		{60, 0}, {61, 1}, {66, 4},
		{72, 2}, {73, 1}, {1234567890, 0},
	}

	for _, tt := range tests {
		res := fibSumSquareLastDigit(tt.n)
		if res != tt.out {
			t.Errorf("n=%d: want=%d, got=%d", tt.n, tt.out, res)
		}

	}
}
