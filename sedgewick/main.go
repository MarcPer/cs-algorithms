package main

import (
  "flag"
  "fmt"
  "github.com/MarcPer/cs-algorithms/unionfind"
)

func main() {
  tFlag := flag.String("t", "", "name of the topic")
  flag.Parse()

  if *tFlag == "" {
    fmt.Println("Usage of cs-algorithms/main")
    flag.PrintDefaults()
    panic("Topic required")
  }

  switch *tFlag {
  case "unionfind":
    unionfind.Run()
  default:
    panic("Unrecognized topic")
  }
}
