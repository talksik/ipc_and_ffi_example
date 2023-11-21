package main

/*
#cgo LDFLAGS: -L./ -lexample
void helloFromC();
*/
import "C"

func main() {
  print("Hello from Go! calling FFI for C\n")
  C.helloFromC()
}
