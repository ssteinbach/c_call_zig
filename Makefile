CC = clang

all: main.c json_reader.zig
	zig build
	$(CC) main.c -lzigJsonReader -Lzig-out/lib -o c_to_zig_json_reader


test:
	zig test simple.zig


clean:
	rm -f c_to_zig_json_reader
	rm -rf zig-cache zig-out
