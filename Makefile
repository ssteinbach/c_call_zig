all: test.c simple.zig
	zig build
	clang test.c -llibTestProg -Lzig-out/lib

clean:
	rm test
	rm -rf zig-cache zig-out
