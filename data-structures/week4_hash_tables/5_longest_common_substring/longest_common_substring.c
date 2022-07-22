#define _GNU_SOURCE
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MODA 100003
#define MODB 100151
#define HASH_X 29

#ifdef DEBUG
#define debug(M, ...) fprintf(stderr, "DEBUG %s:%d: " M "\n",\
		__FILE__, __LINE__, ##__VA_ARGS__)
#else
#define debug(M, ...)
#endif

typedef struct Hashes {
	int size1;
	int size2;
	long int *hashes1a;
	long int *hashes1b;
	long int *hashes2a;
	long int *hashes2b;
} Hashes;

Hashes *Hashes_create(int const size1, int const size2, char *const s1, char *const s2) {
	Hashes *h = malloc(sizeof(Hashes));
	assert(h != NULL);
	h->size1 = size1;
	h->size2 = size2;

	h->hashes1a = calloc(size1+1, sizeof(long int));
	h->hashes1b = calloc(size1+1, sizeof(long int));
	h->hashes2a = calloc(size2+1, sizeof(long int));
	h->hashes2b = calloc(size2+1, sizeof(long int));

	for (int i = 0; i < size1; i++) {
		int b = (int)s1[i];
		h->hashes1a[i+1] = (HASH_X * h->hashes1a[i] + b) % MODA;
		h->hashes1b[i+1] = (HASH_X * h->hashes1b[i] + b) % MODB;
	}
	for (int i = 0; i < size2; i++) {
		int b = (int)s2[i];
		h->hashes2a[i+1] = (HASH_X * h->hashes2a[i] + b) % MODA;
		h->hashes2b[i+1] = (HASH_X * h->hashes2b[i] + b) % MODB;
	}
	return h;
}

void Hashes_destroy(Hashes *h) {
	assert(h != NULL);
	free(h->hashes1a);
	free(h->hashes1b);
	free(h->hashes2a);
	free(h->hashes2b);

	free(h);
}

long int mod_power(long int x, int exp, int mod) {
	x %= mod;

	if (x==0) return 0;

	long int result = 1;

	while (exp>0) {
		if ((exp&1) != 0)
			result = (result*x)%mod;

		exp >>= 1;
		x = (x*x)%mod;
	}

	return result;
}

// returns 1 if there is a match, and 0 otherwise
int match(int out[3], Hashes *h, int len) {
	if (len == 0) return 1;

	long int xla = mod_power(HASH_X, len, MODA);
	long int xlb = mod_power(HASH_X, len, MODB);

	// precompute hashes of length len for string s1
	long int h1a[h->size1];
	long int h1b[h->size1];
	for (int i = 0; i <= h->size1-len; i++) {
		h1a[i] = (h->hashes1a[i+len] - xla*(h->hashes1a[i])) % MODA;
		h1a[i] = (h1a[i]+MODA)%MODA;
		h1b[i] = (h->hashes1b[i+len] - xlb*(h->hashes1b[i])) % MODB;
		h1b[i] = (h1b[i]+MODB)%MODB;
	}

	for (int s2i=0; s2i <= h->size2-len; s2i++) {
		long int va = (h->hashes2a[s2i+len] - xla*(h->hashes2a[s2i])) % MODA;
		va = (va+MODA)%MODA;
		long int vb = (h->hashes2b[s2i+len] - xlb*(h->hashes2b[s2i])) % MODB;
		vb = (vb+MODB)%MODB;

		for (int s1i=0; s1i <= h->size1-len; s1i++) {
			if (va != h1a[s1i])
				continue;

			if (vb == h1b[s1i]) {
				out[0] = s1i;
				out[1] = s2i;
				out[2] = len;
				return 1;
			}
		}
	}
	return 0;
}

void max_substr(int out[3], char *s1, char *s2) {
	int s1_sz = strlen(s1);
	int s2_sz = strlen(s2);

	out[0] = 0;
	out[1] = 0;
	out[2] = 0;

	Hashes *h = Hashes_create(s1_sz, s2_sz, s1, s2);

	int top, bottom;
	int len = -1;
	bottom = 0;
	if (s1_sz < s2_sz)
		top = s1_sz;
	else
		top = s2_sz;

	if (match(out, h, top)) {
		Hashes_destroy(h);
		return;
	}

	// Binary search through different lenghts
	while (top > bottom) {
		len = (top+bottom)/2;

		debug("top=%d bottom=%d len=%d", top, bottom, len);
		if (match(out, h, len)) {
			debug("matched");
			bottom = len+1;
		}
		else {
			debug("NOT matched");
			top = len;
		}
	}

	Hashes_destroy(h);
}

int main(int argc, char *argv[]) {
	char *line = NULL;
	size_t len = 0;

	int out[3] = {0};
	char *s1 = NULL;
	char *s2 = NULL;
	char *pch = NULL;
	while (getline(&line, &len, stdin) != -1) {
		pch = strtok(line, " ");
		s1 = strdup(pch);
		pch = strtok(NULL, " ");
		s2 = strdup(pch);
		s2[strcspn(s2, "\n")] = 0;

		debug("s1=%s s2=%s", s1, s2);
		max_substr(out, s1, s2);
		printf("%d %d %d\n", out[0], out[1], out[2]);
	}
	free(s1);
	free(s2);
	free(line);

	return 0;
}
