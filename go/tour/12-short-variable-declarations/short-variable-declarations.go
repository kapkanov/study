package main

import "fmt"

// This won't work:
// Noggano := "Oplya"
//
// It should be:
var Noggano = "Oplya"

func main() {
	var i, j             = 1, 21
	    k               := 3
	    c, python, java := true, false, "no!"

	fmt.Println(i, j, k, c, python, java, Noggano)
}

