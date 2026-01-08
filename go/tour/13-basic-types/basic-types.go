/*

Basic types:
1. bool
2. string
3. int  in8   int16  int32  int64
4. uint uint8 uint16 uint32 uint64 uintptr
5. byte (alias for uint8)
6. rune (alias for int32. Reperesents a Unicode code point)
7. float32 float64
8. complex64 complex128

*/

package main

import (
	"fmt"
	"math/cmplx"
)



var (
	ToBe bool     = false
	MaxInt uint64 = 1 << 64 - 11
	z complex128  = cmplx.Sqrt(-5 + 12i)
)


func main() {
	fmt.Printf("Type: %T Value %v\n", ToBe,   ToBe)
	fmt.Printf("Type: %T Value %v\n", MaxInt, MaxInt)
	fmt.Printf("Type: %T Value %v\n", z, z)
}

