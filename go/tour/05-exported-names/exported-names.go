package main

import (
	"fmt"
	"math"
)



func main() {
	fmt.Println(math.pi) // Won't be compiled cause exported package variables (accesible outside of package) starts with a capital letter
	fmt.Println(math.Pi)
}

