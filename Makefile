.PHONY: all clean test pipe named-pipe ffi
.ONESHELL:

all: clean
	echo "going to run all ipc/ffi examples"
	sleep 1;
	make test;
	make pipe;
	sleep 3;
	make named-pipe;
	sleep 3;
	make ffi;
	make clean;

test:
	mkdir -p test;
	cd test;
	pwd;
	cd ..;
	# note: below line stays in root dir because no `\` at the end of previous line
	rm -rf test;

pipe: clean
	cd pipe;
	gcc test_pipe.c -o test_pipe_c_program;
	go build -o test_pipe_go_program main.go;
	./test_pipe_go_program

named-pipe: clean
	cd named_pipe;
	gcc test_named_pipe_receiver.c -o test_named_pipe_receiver_c_program;
	go build -o test_named_pipe_sender_go_program main.go;
	./test_named_pipe_receiver_c_program & ./test_named_pipe_sender_go_program;

ffi: clean
	cd ffi;
	gcc -c -o example.o example.c;
	ar rcs libexample.a example.o;

	go build -o test_ffi_go_program main.go;
	./test_ffi_go_program;

clean:
	echo "cleaning..."
	rm -rf pipe/test_pipe_c_program pipe/test_pipe_go_program
	rm -rf named_pipe/test_named_pipe_receiver_c_program named_pipe/test_named_pipe_sender_go_program
	rm -rf ffi/main.o ffi/libmain.a ffi/test_ffi_go_program

