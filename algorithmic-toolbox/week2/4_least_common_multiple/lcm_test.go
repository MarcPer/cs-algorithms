package main

import "testing"

func TestLastFib(t *testing.T) {
	tests := []struct {
		a, b int
		out  int
	}{
		{1, 1, 1},
		{6, 8, 24},
		{7, 13, 91},
	}

	for _, tt := range tests {
		res := lcm(tt.a, tt.b)
		if res != tt.out {
			t.Errorf("want=%d, got=%d", tt.out, res)
		}
	}
}
