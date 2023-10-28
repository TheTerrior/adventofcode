package main

import (
    "fmt"
    "os"
    "strings"
    "math" 
)


// Convert a list of ints into bits
func to_bits(inp []int) int64 {
    var ret int64 = 0
    for i := 0; i < len(inp); i++ {
        ret |= 1 << inp[i]
    }
    return ret
}


// Main entry point
func main() {
    data, err := os.ReadFile("input.txt") //retrieve data from input.txt
    if err != nil {
        panic(err)
    }

    var total float64 = 0
    var splitted = strings.Split(string(data), "\n")
    for i := 0; i < len(splitted); i++ {
        var length = len(splitted[i])
        var inted = make([]int, len(splitted[i]))

        for j := 0; j < length; j++ { //convert string to ints
            inted[j] = (int(splitted[i][j]) - 38) % 58 //-38 instead of -96 so no negatives
        }

        var fst_bits = to_bits(inted[:length/2]) //use bits to see the matching value
        var snd_bits = to_bits(inted[length/2:])
        var shared = fst_bits & snd_bits
        total += math.Log2(float64(shared))
    }
    fmt.Println(total)
}

