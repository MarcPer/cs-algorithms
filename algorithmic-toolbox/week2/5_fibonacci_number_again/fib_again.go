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
	res := fibMod(a, b)
	fmt.Println(res)
}

func fibMod(n, mod int) int {
	if n <= 1 {
		return n
	}

	// find repeating sequence
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
	terms = terms[:len(terms)-1]
	period := len(terms)
	// fmt.Printf("n=%v mod=%v: terms=%v, period=%v\n", n, mod, terms, period)

	return terms[n%period]
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
