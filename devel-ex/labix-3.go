package main

import (
        "bytes"
        "fmt"
        "os"

        "gopkg.in/pipe.v2"
)

func main() {
	prefix := []byte("root:")
	script := pipe.Script(
		pipe.Println("root:x:0:0:root:/root:/bin/sh"),
		pipe.Line(
			pipe.ReadFile("/etc/passwd"),
			pipe.Filter(func(line []byte) bool {
				return !bytes.HasPrefix(line, prefix)
			}),
		),
	)
        p := pipe.Line(
		script,
		pipe.Write(os.Stdout),
	)
        err := pipe.Run(p)
        if err != nil {
                fmt.Printf("%v\n", err)
        }
}

