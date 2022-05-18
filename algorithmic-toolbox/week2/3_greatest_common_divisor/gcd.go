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
	res := gcd(a, b)
	fmt.Println(res)
}

func gcd(a, b int) int {
	if b == 0 {
		return a
	}
	rem := a % b

	return gcd(b, rem)
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
