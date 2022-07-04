#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

typedef struct MaxStack {
	int size;
	int idx;
	int idx_max;
	int *arr;
	int *max_arr;
	int max_val;
} MaxStack;

MaxStack *Stack_create(int size) {
	int *arr = NULL;
	int *max_arr = NULL;
	MaxStack *stack = NULL;

	if (NULL == (stack = malloc(sizeof(MaxStack)))) {
		goto error;
	}
	if (NULL == (arr = calloc(size, sizeof(int)))) {
		goto error;
	}
	if (NULL == (max_arr = calloc(size, sizeof(int)))) {
		goto error;
	}

	stack->arr = arr;
	stack->max_arr = max_arr;
	stack->size = size;
	stack->idx = 0;
	stack->idx_max = 0;
	stack->max_val = -1;

	return stack;
error:
	if (arr) free(arr);
	if (max_arr) free(max_arr);
	if (stack) free(stack);
	return NULL;
};

#define STACK_EMPTY -1

int Stack_pop(MaxStack *s) {
	if (s->idx <= 0) {
		return STACK_EMPTY;
	}
	int res = s->arr[--s->idx];

	if (res == s->max_val) {
		int max_val = -1;
		if (s->idx_max > 1) {
			s->idx_max--;
			max_val = s->max_arr[s->idx_max-1];
		} else if (s->idx_max == 1) {
			s->idx_max--;
		}

		s->max_val = max_val;
	}

	return res;
};

int Stack_push(MaxStack *s, int val) {
	if (s->idx >= s->size) {
		return -1;
	}
	s->arr[s->idx++] = val;

	if (val >= s->max_val) {
		s->max_val = val;
		s->max_arr[s->idx_max] = val;
		s->idx_max++;
	}
	return 0;
}

typedef struct Queue {
	int size;
	int idx;
	MaxStack *inbox;
	MaxStack *outbox;
} Queue;

Queue *Queue_create(int size) {
	MaxStack *inbox = NULL;
	MaxStack *outbox = NULL;
	Queue *queue = NULL;

	if (NULL == (queue = malloc(sizeof(Queue)))) {
		goto error;
	}
	if (NULL == (inbox = Stack_create(size))) {
		goto error;
	}
	if (NULL == (outbox = Stack_create(size))) {
		goto error;
	}

	queue->size = size;
	queue->idx = 0;
	queue->inbox = inbox;
	queue->outbox = outbox;

	return queue;

error:
	if (inbox) free(inbox);
	if (outbox) free(outbox);
	if (queue) free(queue);
	return NULL;
};

int Queue_enq(Queue *q, int val) {
	return Stack_push(q->inbox, val);
}

int Queue_deq(Queue *q) {
	int res = Stack_pop(q->outbox);
	if (res != STACK_EMPTY) {
		return res;
	}

	while (q->inbox->idx > 0) {
		res = Stack_pop(q->inbox);
		Stack_push(q->outbox, res);
	}
	res = Stack_pop(q->outbox);
	return res;
}

int Queue_max(Queue *q) {
	if (q->inbox->max_val > q->outbox->max_val) {
		return q->inbox->max_val;
	} else {
		return q->outbox->max_val;
	}
}

void max_window(int *out, int *arr, int arr_sz, int win_sz) {
	Queue *q = Queue_create(win_sz);
	for (int i=0; i < win_sz; i++) {
		Queue_enq(q, arr[i]);
	}
	out[0] = Queue_max(q);

	for (int i=win_sz; i<arr_sz; i++) {
		Queue_deq(q);
		Queue_enq(q, arr[i]);
		out[i-win_sz+1] = Queue_max(q);
	}
}

int main(int argc, char *argv[]) {
	char *line = NULL;
	size_t len = 0;

	getline(&line, &len, stdin);
	int arr_sz = atoi(line);
	int arr[arr_sz];

	getline(&line, &len, stdin);
	char *pch;
	pch = strtok(line, " ");
	int idx;
	while (pch != NULL) {
		arr[idx] = atoi(pch);
		idx++;
		pch = strtok(NULL, " ");
	}
	
	getline(&line, &len, stdin);
	int win_sz = atoi(line);

	free(line);

	assert(win_sz <= arr_sz);
	int out[arr_sz-win_sz+1];

	max_window(out, arr, arr_sz, win_sz);
	for (int i=0; i < arr_sz-win_sz+1; i++ ) {
		printf("%d ", out[i]);
	}
	printf("\n");

	return 0;
}
