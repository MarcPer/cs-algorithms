package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	args0 := readInt(reader)
	n := args0[0]
	args1 := readInt(reader)
	prod := maxProduct(n, args1)
	fmt.Println(prod)
}

func maxProduct(n int, arr []int) int {
	maxi1 := -1
	maxval1, maxval2 := -1, -1
	for i := 0; i < n; i++ {
		if arr[i] > maxval1 {
			maxi1 = i
			maxval1 = arr[i]
		}
	}

	for i := 0; i < n; i++ {
		if arr[i] > maxval2 && i != maxi1 {
			maxval2 = arr[i]
		}
	}

	return maxval1 * maxval2
}

func check(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func readInt(r *bufio.Reader) []int {
	input, err := r.ReadString('\n')
	check(err)

	input = strings.TrimRight(input, "\n")
	splits := strings.Split(input, " ")
	conv := make([]int, len(splits))
	for i, x := range splits {
		n, err := strconv.Atoi(x)
		check(err)
		conv[i] = n
	}

	return conv
}
