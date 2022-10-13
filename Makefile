all: test.c simple.zig
	zig build
	clang  test.c -llibTestProg -Lzig-out/lib -otest


test:
	zig test simple.zig


clean:
	rm test
	rm -rf zig-cache zig-out
