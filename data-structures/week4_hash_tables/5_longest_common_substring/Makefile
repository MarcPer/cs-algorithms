CC=gcc
CFLAGS=-pipe -O2 -Wall -std=c11 -lm

.DEFAULT: debug_build

longest_common_substring: longest_common_substring.c

.PHONY: build
build: longest_common_substring

.PHONY: clean
clean:
	@rm -f longest_common_substring

.PHONY: test_ruby
test_ruby: longest_common_substring
	@ruby longest_common_substring_test_c.rb

.PHONY: debug_build
debug_build: longest_common_substring.c
	@gcc -pipe -O0 -DDEBUG -g -Wall -std=c11 -lm longest_common_substring.c -o longest_common_substring
