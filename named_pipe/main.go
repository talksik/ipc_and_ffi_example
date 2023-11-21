package main

import (
	"fmt"
	"os"
	"syscall"
)

// createNamedPipe creates a named pipe (FIFO)
func createNamedPipe(pipeName string) error {
	err := syscall.Mkfifo(pipeName, 0666)
	if err != nil && !os.IsExist(err) {
		return err
	}
	return nil
}

func main() {
	// Create a named pipe (FIFO)
	pipeName := "my_pipe"
	err := createNamedPipe(pipeName)
	if err != nil {
		fmt.Println("Error creating named pipe:", err)
		return
	}

	// Open the named pipe for writing
	pipe, err := os.OpenFile(pipeName, os.O_WRONLY, os.ModeNamedPipe)
	if err != nil {
		fmt.Println("Error opening named pipe for writing:", err)
		return
	}
	defer pipe.Close()

	// Write data to the named pipe
	message := "Hello from the writer program!"
	_, err = pipe.WriteString(message)
	if err != nil {
		fmt.Println("Error writing to named pipe:", err)
		return
	}
}
