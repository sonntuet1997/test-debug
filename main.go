package main

import "time"

func main() {
	print("Hello World")
	for {
		print("Waiting")
		time.Sleep(1 * time.Second)
	}
}
