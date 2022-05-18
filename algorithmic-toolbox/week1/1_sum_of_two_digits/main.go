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
	line, err := reader.ReadString('\n')
	if err != nil {
		log.Fatal(err)
	}
	line = strings.TrimRight(line, "\n")
	splits := strings.Split(line, " ")
	if len(splits) < 2 {
		log.Fatalf("requires 2 arguments, given %d", len(splits))
	}

	inputs := make([]int, len(splits))
	for i, arg := range splits {
		n, err := strconv.Atoi(arg)
		if err != nil {
			log.Fatalf("%d-th argument needs to be an integer, was %v", i, arg)
		}
		inputs[i] = n
	}
	fmt.Println(sum(inputs[0], inputs[1]))
}

func sum(a, b int) int {
	return a + b
}
