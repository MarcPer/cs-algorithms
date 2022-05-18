package main

import "testing"

func TestLastFib(t *testing.T) {
	tests := []int{0, 1, 1, 2, 3, 5, 8, 3, 1}

	for i, want := range tests {
		res := lastFib(i)
		if res != want {
			t.Errorf("want=%d, got=%d", want, res)
		}
	}
}
