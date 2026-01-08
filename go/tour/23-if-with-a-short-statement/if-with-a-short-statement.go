package main

import (
	"fmt"
	"math"
)



func pow(x, n, lim float64) float64 {
	// return v := math.Pow(x, n) // unexpected := at end of statement

	// cannot use v := math.Pow(x, n) as value
	// if v := math.Pow(x, n) {
	// 	return v
	// }

	if v := math.Pow(x, n); v < lim {
		return v
	}

	// fmt.Println(v) // not accesible outside if statement

	return lim
}


func main() {
	fmt.Println(
		pow(3, 2, 10),
		pow(3, 3, 20),
	)
}

