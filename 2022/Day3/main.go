package main

import (
	"fmt"
	"os"
	"strings"
)

// Convert a char into a priority
func charToPriority(char rune) int8 {
	convert := int8(char) - 96
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

	for i := 0; i < len(textLines); i++ {
		fmt.Println(textLines[i])
	}

	fmt.Println(charToPriority('a'))
	fmt.Println(charToPriority('z'))
	fmt.Println(charToPriority('A'))
	fmt.Println(charToPriority('Z'))


}