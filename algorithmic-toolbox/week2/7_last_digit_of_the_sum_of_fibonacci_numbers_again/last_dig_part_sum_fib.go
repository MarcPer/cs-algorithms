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
	start, end := inputs[0], inputs[1]
	fmt.Println(fibSumPartialLastDigit(start, end))
}

func fibSumPartialLastDigit(start, end int) int {
	fibSeq := fibModSeq(10)
	sums := fibSumSeq(fibSeq, start)
	return sums[(end-start)%len(sums)]
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

// find repeating sequence in the sum series
func fibSumSeq(in []int, start int) []int {
	if len(in) < 1 {
		return []int{}
	} else if len(in) == 1 {
		return []int{in[start%len(in)]}
	}
	period := len(in)
	a0 := in[start%period]
	b0 := in[(start+1)%period]
	out := []int{a0, (a0 + b0) % 10}
	for i := 2; ; i++ {
		b, a := in[(start+i)%period]%10, out[i-1]
		if b == b0 && a == a0 {
			break
		}
		out = append(out, (a+b)%10)
	}
	out = out[:len(out)-1]
	return out
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
