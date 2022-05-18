package main

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"golang.org/x/exp/constraints"
)

func main() {
	args := os.Args[1:]

	input := make([]int, 0)
	for i, x := range args {
		n, err := strconv.Atoi(x)
		if err != nil {
			log.Fatalf("conversion to integer failed for %d-th input %v", i, x)
		}
		input = append(input, n)
	}
	fmt.Println(input)
}

func Sort[T constraints.Ordered](arr []T) []T {
	if len(arr) <= 1 {
		return arr
	}
	for i := 1; i < len(arr); i++ {
		key := arr[i]
		j := i - 1
		for j >= 0 && arr[j] > key {
			arr[j+1] = arr[j]
			j--
		}
		arr[j+1] = key
	}
	return arr
}
