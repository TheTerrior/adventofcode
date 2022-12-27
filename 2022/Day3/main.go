package main

import (
	"fmt"
	"os"
	"strings"
)

// Convert a char into a priority
func charToPriority(char rune) int {
	convert := int(char) - 96
	if convert < 0 {
		convert = convert + 58
	}
	return convert
}

// Main entry point
func main() {
	dat, err := os.ReadFile("input.txt")
	if err != nil {
        panic(err)
    }

	text := string(dat)
	textLines := strings.Split(text, "\n")

	total := 0

	// for each line
	for i := 0; i < len(textLines); i++ {
		seen := map[byte]bool{}
		thisLine := textLines[i]
		firstHalf := thisLine[:len(thisLine) / 2]
		secondHalf := thisLine[len(thisLine) / 2:]

		// for each char in the first half
		for j := 0; j < len(firstHalf); j++ {
			seen[firstHalf[j]] = true
		}

		// for each char in the second half
		for j := 0; j < len(secondHalf); j++ {
			if seen[secondHalf[j]] {
				//fmt.Println("Found it: ", string(rune(secondHalf[j])), " on line ", i)
				total += charToPriority(rune(secondHalf[j]))
				break
			}	
		}

	}

	fmt.Println(total)

	//fmt.Println(charToPriority('a'))
	//fmt.Println(charToPriority('z'))
	//fmt.Println(charToPriority('A'))
	//fmt.Println(charToPriority('Z'))


}