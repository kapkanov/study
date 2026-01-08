package main

import "fmt"



func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return // it's called "naked return". It returns (x, y)
}


func main() {
	fmt.Println(split(17))
}

