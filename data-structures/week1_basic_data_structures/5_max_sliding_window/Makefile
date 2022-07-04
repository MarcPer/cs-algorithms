CC=gcc
CFLAGS=-pipe -O0 -g -Wall -std=c11 -lm

.DEFAULT: max_sliding_window
max_sliding_window: max_sliding_window.c

.PHONY: clean
clean:
	@rm -f max_sliding_window

.PHONY: test_ruby
test_ruby: max_sliding_window
	@ruby max_sliding_window_test_c.rb

