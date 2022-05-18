package main

import (
	"fmt"
	"testing"
)

func TestSort(t *testing.T) {
	tests := []struct {
		in  []int
		out []int
	}{
		{[]int{1}, []int{1}},
		{[]int{}, []int{}},
		{[]int{2, 1}, []int{1, 2}},
		{[]int{1, 3, 1}, []int{1, 1, 3}},
		{[]int{-1, -2, -3}, []int{-3, -2, -1}},
	}

	for _, tt := range tests {
		output := Sort(tt.in)
		if !equal(output, tt.out) {
			t.Errorf("want=%v, got=%v", tt.out, output)
		}
	}

	bytetests := []struct {
		in  []byte
		out []byte
	}{
		{[]byte{1}, []byte{1}},
		{[]byte{}, []byte{}},
		{[]byte{2, 1}, []byte{1, 2}},
		{[]byte{1, 3, 1}, []byte{1, 1, 3}},
	}

	for _, tt := range bytetests {
		output := Sort(tt.in)
		if !equal(output, tt.out) {
			t.Errorf("want=%v, got=%v", tt.out, output)
		}
	}
}

func ExampleSort() {
	fmt.Println(Sort([]int{3, 2, 1}))
	// Output: [1 2 3]
}

func BenchmarkSort(b *testing.B) {
	input := make([]float32, 0, 100)
	for i, _ := range input {
		input[i] = float32(i) / 2
	}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		newIn := make([]float32, 0, 100)
		copy(newIn, input)
		Sort(newIn)
	}
}

func FuzzSort(f *testing.F) {
	f.Add([]byte{3, 1, 1})
	f.Add([]byte{2, 2, 2})
	f.Add([]byte{1, 2, 4})
	f.Fuzz(func(t *testing.T, a []byte) {
		len0 := len(a)
		out := Sort(a)
		if len(out) != len0 {
			t.Fatalf("wrong size after sort, want=%v got=%v", len0, len(out))
		}
		if len(a) <= 1 {
			return
		}

		for i := 0; i < len(out)-1; i++ {
			if out[i] > out[i+1] {
				t.Fatalf("Sort(%v) not sorted", a)
			}
		}
	})
}

func equal[T comparable](a1 []T, a2 []T) bool {
	if len(a1) != len(a2) {
		return false
	}
	for i, x := range a1 {
		if x != a2[i] {
			return false
		}
	}
	return true
}
