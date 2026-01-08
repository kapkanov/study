// Constants cannot be declared using the := syntax

package main

import "fmt"

const Pi float32 = 3.14

func main() {
	const World string = "123"

	fmt.Println("Hola", World)
	fmt.Println("Happy", Pi, "Day")


	const Truth = true

	fmt.Println("Opa", Truth)
}

