package main

import (
	"bytes"
	"fmt"

	"gopkg.in/pipe.v2"
)

func main() {
	b := &bytes.Buffer{}
	p := pipe.Line(
		pipe.Exec("df"),
		pipe.Filter(func(line []byte) bool {
			return bytes.HasSuffix(line, []byte(" /boot"))
		}),
		pipe.Tee(b),
		pipe.WriteFile("boot.txt", 0644),
	)
	err := pipe.Run(p)
	if err != nil {
		fmt.Printf("%v\n", err)
	}
	fmt.Print(b.String())


        p := pipe.Script(
            pipe.Line(
                pipe.ReadFile("article.ps"),
                pipe.Exec("lpr"),
            ),
            pipe.RenameFile("article.ps", "article.ps.done"),
        )
}

