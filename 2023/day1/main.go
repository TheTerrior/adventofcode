package main

import "fmt"
import "os"
import "strings"
import "strconv"


var numberMap = map[string]int{
    "one":   1,
    "two":   2,
    "three": 3,
    "four":  4,
    "five":  5,
    "six":   6,
    "seven": 7,
    "eight": 8,
    "nine":  9,
}


func retFirst(line []rune) int {
    for i := range line {
        var n, err = strconv.Atoi(string(line[i]))
        if err == nil {
            return n //current char is an int
        }
        for str, j := range numberMap {
            var res = strings.HasPrefix(string(line[i:]), str)
            if res {
                return j //number showed up as word
            }
        }
    }
    return 0
}


func retLast(line []rune) int {
    for i := range line {
        i = len(line) - i - 1
        var n, err = strconv.Atoi(string(line[i]))
        if err == nil {
            return n //current char is an int
        }
        for str, j := range numberMap {
            var res = strings.HasPrefix(string(line[i:]), str)
            if res {
                return j //number showed up as word
            }
        }
    }
    return 0
}


func retFirsta(line []rune) int {
    for i := range line {
        var n, err = strconv.Atoi(string(line[i]))
        if err == nil {
            return n //current char is an int
        }
    }
    fmt.Println("BAD")
    return 0
}


func retLasta(line []rune) int {
    for i := range line {
        i = len(line) - i - 1
        var n, err = strconv.Atoi(string(line[i]))
        if err == nil {
            return n //current char is an int
        }
    }
    fmt.Println("BAD")
    return 0
}



func part1(text []byte) {
    var totalSum = 0
    var splitted = strings.Split(string(text), "\n")
    for _, line := range splitted {
        var runed = []rune(line)
        var fst = retFirsta(runed)
        var snd = retLasta(runed)

        totalSum += 10 * fst + snd
    }
    fmt.Printf("%v\n", totalSum)
}


func part2(text []byte) {
    var totalSum = 0
    var splitted = strings.Split(string(text), "\n")
    for _, line := range splitted {
        var runed = []rune(line)
        var fst = retFirst(runed)
        var snd = retLast(runed)

        totalSum += 10 * fst + snd
    }
    fmt.Printf("%v\n", totalSum)
}


func main() {
    var text, err = os.ReadFile("input.txt")
    if err != nil {
        panic(err)
    }
    part1(text)
    part2(text)
}


