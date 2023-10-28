package main

import (
	"fmt"
	"os"
	"strings"
)

// Convert a char into a priority
func charToPriority(char rune) int {
	convert := int(char) - 96
	if convert < 0 { // account for capital letters A-Z
		convert = convert + 58
	}
	return convert
}

// Main entry point
func main() {
	data, err := os.ReadFile("input.txt") //retrieve data from input.txt
	if err != nil {
        panic(err)
    }

	textLines := strings.Split(string(data), "\n") //convert file to lines
	totalSingular := 0 //keep track of all priorities for singular
	totalGroups := 0 //keep track of all priorities for groups
	var seenGroups map[byte]int //keeps track of chars we've seen for members of a group

	// for each line
	for i := 0; i < len(textLines); i++ {
		thisLine := textLines[i]

		/// Singular
	
		// setup
		seenSingular := map[byte]bool{}
		firstHalf := thisLine[:len(thisLine) / 2]
		secondHalf := thisLine[len(thisLine) / 2:]

		// for each char in the first half, remember that we've seen this char
		for j := 0; j < len(firstHalf); j++ {
			seenSingular[firstHalf[j]] = true
		}

		// for each char in the second half, check if we've seen this char
		for j := 0; j < len(secondHalf); j++ {
			if seenSingular[secondHalf[j]] {
				totalSingular += charToPriority(rune(secondHalf[j]))
				break
			}	
		}


		/// Groups

		seenSingular = map[byte]bool{}

		// reset group
		if i % 3 == 0 {
			seenGroups = map[byte]int{}
		}

		// if this isn't the last one in the group
		if i % 3 != 2 {

			// for each char in the line, remember what we've seen so far
			for j := 0; j < len(thisLine); j++ {

				// ensure that we don't count the same char twice
				if !seenSingular[thisLine[j]] {
					seenSingular[thisLine[j]] = true
					seenGroups[thisLine[j]] += 1
				}
			}
		} else { // this is the last one in the group

			// for each char in the line, ensure we've seen this twice
			for j := 0; j < len(thisLine); j++ {
				if seenGroups[thisLine[j]] == 2 {
					totalGroups += charToPriority(rune(thisLine[j]))
					break
				}
			}
		}
	}

	fmt.Println(totalSingular)
	fmt.Println(totalGroups)
}
