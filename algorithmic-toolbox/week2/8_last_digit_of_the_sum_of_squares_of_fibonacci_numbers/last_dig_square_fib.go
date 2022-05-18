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
	n := inputs[0]
	fmt.Println(fibSumSquareLastDigit(n))
}

func fibSumSquareLastDigit(n int) int {
	fibSeq := fibModSeq(10)
	period := len(fibSeq)

	// check problem instructions. One can see geometrically that:
	// sum_0^m(Fib(n)^2] = Fib(m+1) * Fib(m)
	return (fibSeq[(n+1)%period] * fibSeq[n%period]) % 10
}

// find repeating sequence of [Fib(n) % mod]
func fibModSeq(mod int) []int {
	a, b := 0, 1
	terms := []int{a, b}
	for {
		b, a = (a+b)%mod, b%mod
		if a == 0 && b == 1 {
			// inputs are repeating, no need to go further
			break
		}
		terms = append(terms, b)
	}
	return terms[:len(terms)-1]
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
