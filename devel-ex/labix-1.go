package main

import (
	"fmt"

	"gopkg.in/pipe.v2"
)

func main() {
	p := pipe.Line(
		pipe.ReadFile("article.ps"),
		pipe.Exec("lpr"),
	)
	output, err := pipe.CombinedOutput(p)
	if err != nil {
		fmt.Printf("%v\n", err)
	}
	fmt.Printf("%s", output)
}
