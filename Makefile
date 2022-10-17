CC = clang

all: src/main.c src/json_reader.zig
	zig build
	$(CC) src/main.c -Isrc -lzigJsonReader -Lzig-out/lib -o c_to_zig_json_reader
	@echo "running test program..."
	./c_to_zig_json_reader

test:
	zig build test

clean:
	rm -f c_to_zig_json_reader
	rm -rf zig-cache zig-out
