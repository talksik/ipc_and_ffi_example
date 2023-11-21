.PHONY: all clean test pipe named-pipe
.ONESHELL:

all: clean
	echo "going to run all ipc/ffi examples"
	sleep 1;
	make test;
	make pipe;

test:
	mkdir -p test;
	cd test;
	pwd;
	cd ..;
	# note: below line stays in root dir because no `\` at the end of previous line
	rm -rf test;

pipe:
	cd pipe;
	gcc test_pipe.c -o test_pipe_c_program;
	go build -o test_pipe_go_program main.go;
	./test_pipe_go_program

named-pipe:
	cd named_pipe;
	gcc test_named_pipe_receiver.c -o test_named_pipe_receiver_c_program;
	go build -o test_named_pipe_sender_go_program main.go;
	./test_named_pipe_receiver_c_program & ./test_named_pipe_sender_go_program;

clean:
	echo "cleaning..."
	rm -rf pipe/test_pipe_c_program pipe/test_pipe_go_program
	rm -rf named_pipe/test_named_pipe_receiver_c_program named_pipe/test_named_pipe_sender_go_program

