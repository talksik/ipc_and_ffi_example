package main

import (
	"fmt"
	"os"
	"os/exec"
)

func main() {
	message := "Hello from Go!"

	// Create a pipe
	reader, writer, err := os.Pipe()
	if err != nil {
		fmt.Println("Error creating pipe:", err)
		return
	}

	// Execute the C program
	cmd := exec.Command("./test_pipe_c_program")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = reader

	// Start the C program
	if err := cmd.Start(); err != nil {
		fmt.Println("Error starting C program:", err)
		return
	}

	// Write the message to the pipe
	_, err = writer.Write([]byte(message))
	if err != nil {
		fmt.Println("Error writing to pipe:", err)
		return
	}

	// Close the write end of the pipe
	writer.Close()

	// Wait for the C program to finish
	if err := cmd.Wait(); err != nil {
		fmt.Println("Error waiting for C program:", err)
		return
	}
}
