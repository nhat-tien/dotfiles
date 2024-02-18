package main

import (
	"fmt"
	"time"
	"strconv"
	"text/template"
)

func main() {
	// var arg string = os.Args[1]

	// switch arg {
	// 	case "date":
	// 	printDate()
	// }

	fmt.Println("")
}

func printDate() string {
	currentTime := time.Now()
	var date string
	date = strconv.Itoa(currentTime.Year()) + "-" + strconv.Itoa(int(currentTime.Month())) + "-" + strconv.Itoa(currentTime.Day())

	return date  
}
