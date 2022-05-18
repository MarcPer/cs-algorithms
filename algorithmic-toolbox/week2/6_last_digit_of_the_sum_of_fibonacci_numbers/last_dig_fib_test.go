package main

import (
	"testing"
)

func TestLastDigSumFib(t *testing.T) {
	fibs := []int{0, 1, 1, 2, 3, 5, 8, 13, 21, 34}
	want := make([]int, len(fibs))
	for i := 0; i < len(fibs); i++ {
		want[i] = cumSum(fibs[:i+1]) % 10
	}

	for i, w := range want {
		res := fibSumLastDigit(i)
		if res != w {
			t.Errorf("n=%d want=%d, got=%d", i, w, res)
		}
	}
}

func cumSum(arr []int) int {
	sum := 0
	for i := 0; i < len(arr); i++ {
		sum += arr[i]
	}
	return sum
}
