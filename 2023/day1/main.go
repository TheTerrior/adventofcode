package main

import "fmt"
import "os"
import "strings"
import "strconv"


// Grabs the first int rune from a string
func getFirst(line *string) (string, error) {
    for _, c := range *line {
        var _, err = strconv.Atoi(string(c))
        if err != nil {
            continue
        }
        return string(c), nil
    }
    return "", fmt.Errorf("no int in string")
}


// Grabs the last int rune from a string
func getLast(line *string) (string, error) {
    var sliced = []rune(*line)
    var length = len(sliced)
    for i, _ := range sliced {
        var c = sliced[length - i - 1]
        var _, err = strconv.Atoi(string(c))
        if err != nil {
            continue
        }
        return string(c), nil
    }
    return "", fmt.Errorf("no int in string")
}


func main() {
    //fmt.Println("hello")
    var text, err = os.ReadFile("input.txt")
    if err != nil {
        panic(err)
    }

    var totalSum = 0

    var splitted = strings.Split(string(text), "\n")
    for _, line := range splitted {
        var fst, err = getFirst(&line)
        if err != nil {
            continue
        }

        var snd string
        snd, err = getLast(&line)
        if err != nil {
            continue
        }

        var res, _ = strconv.Atoi(fst + snd)
        totalSum += res
    }

    fmt.Printf("%v\n", totalSum)
}


