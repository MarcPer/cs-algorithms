package main

import (
	"testing"
)

func TestLastDigSumFib(t *testing.T) {
	tests := []struct {
		min, max int
		out      int
	}{
		{3, 7, 1},
		{10, 10, 5},
		{10, 200, 2},
	}

	for _, tt := range tests {
		res := fibSumPartialLastDigit(tt.min, tt.max)
		if res != tt.out {
			t.Errorf("min=%d max=%d: want=%d, got=%d", tt.min, tt.max, tt.out, res)
		}

	}
}
