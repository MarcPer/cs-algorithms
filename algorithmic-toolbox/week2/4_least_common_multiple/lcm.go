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
	r := bufio.NewReader(os.Stdin)
	inputs := ReadInt(r)
	a, b := inputs[0], inputs[1]
	if b > a {
		a, b = b, a
	}
	res := lcm(a, b)
	fmt.Println(res)
}

func lcm(a, b int) int {
	if a == 1 {
		return b
	} else if b == 1 {
		return a
	}

	// compute multiples of a and b (assigned to am, and bm)
	// if am != bm, check which is smaller and compute the next corresponding multiple
	am, bm := a, b
	ai, bi := 1, 1
	for am != bm {
		if am > bm {
			bi++
			bm = bi * b
		} else {
			ai++
			am = ai * a
		}
	}

	return am
}

func Check(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func ReadInt(r *bufio.Reader) []int {
	input, err := r.ReadString('\n')
	Check(err)

	input = strings.TrimRight(input, "\n")
	splits := strings.Split(input, " ")
	conv := make([]int, len(splits))
	for i, x := range splits {
		n, err := strconv.Atoi(x)
		Check(err)
		conv[i] = n
	}

	return conv
}
