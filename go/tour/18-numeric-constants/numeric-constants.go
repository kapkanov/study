// Numeric constants are high-precision values
// Untyped constants take type they needed by its context

package main

import "fmt"



const (
	Big       = 1 << 100
	Small     = Big >> 99
	Typed int = 5432
)


func needInt(x int) int { return 10 * x + 1 }

func needFloat(x float64) float64 {
	return 0.1 * x
}


func main() {
	fmt.Println(needInt(Small))
	fmt.Println(needFloat(Small))
	fmt.Println(needFloat(Big))

	// fmt.Println(needInt(Big)) // overflow
	fmt.Println(needInt(Typed))

	// fmt.Println(needFloat(Typed)) // types check fails
	fmt.Println(needFloat(float64(Typed)))
}

