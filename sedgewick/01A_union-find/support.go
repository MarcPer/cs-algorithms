package unionfind

import (
  "bufio"
  "fmt"
  "os"
  "strconv"
)

func ReadSize() (int, bool) {
  reader := bufio.NewReader(os.Stdin)
  n, ok := 0, false
  for i := 0; i < 10; i++ {
    fmt.Println("Enter array size: ")
    nstr, err := reader.ReadString('\n')
    nstr = nstr[0 : len(nstr)-1]
    if err != nil {
      fmt.Printf("Type an integer. %s\n", err)
      continue
    }
    n, err = strconv.Atoi(nstr)
    if err != nil {
      fmt.Printf("Type an integer. %s\n", err)
      continue
    }
    ok = true
    break
  }

  return n, ok
}
