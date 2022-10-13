all: test.c simple.zig
	zig build
	# zig build-exe --verbose-link  test.c -llibTestProg -Lzig-out/lib 
	# clang  test.c -llibTestProg -Lzig-out/lib -otest -dynamic ~/.cache/zig/o/4e58ae372ec9dcc0c2b625ba017dea2e/libcompiler_rt.a 
	clang  test.c -llibTestProg -Lzig-out/lib -otest


test:
	zig test simple.zig


clean:
	rm test
	rm -rf zig-cache zig-out
