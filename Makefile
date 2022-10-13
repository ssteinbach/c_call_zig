all: test.c simple.zig
	zig build
	clang test.c -llibTestProg -Lzig-out/lib -otest

clean:
	rm test
	rm -rf zig-cache zig-out
