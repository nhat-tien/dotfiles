package main

import (
	"fmt"
	"os"
	"time"
)

func main() {
	var arg string = os.Args[1]

	switch arg {
		case "date":
		printDate()
	}

	fmt.Println("")
}

func printDate() {
	currentTime := time.Now()
	fmt.Printf("%d-%02d-%02d", currentTime.Year(), currentTime.Month(), currentTime.Day())
}
