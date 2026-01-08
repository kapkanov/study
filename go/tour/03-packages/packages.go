package main

import (
	"fmt"
	"math/rand" // package name is the same as the last element
	            // of the import path. thus math/rand is package rand
)



func main() {
	fmt.Println("Random = ", rand.Intn(10))
}

