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
	n := ReadInt(r)
	fmt.Println(lastFib(n[0]))
}

func lastFib(n int) int {
	if n <= 1 {
		return n
	}

	var a, b int
	b = 1

	for i := 0; i < n-1; i++ {
		b, a = (a+b)%10, b
	}

	return b
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
