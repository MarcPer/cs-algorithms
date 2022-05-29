# Rocks game

The games are given as practice quizzes in the Week 5, "Change Problem" section.
It's always a two player game, that alternate taking rocks from rock piles. The
winner is the one who takes the last rock.

There are always two rock piles, and the allowed operations depend on the game
variant. We represent an operation as a two-element array like [1,0], which
means taking a rock from the left pile, and none from the right.

Two variants are given:

**Two rocks game**: there are two piles of rocks, and a player can apply one of
the following operations:
[[0,1], [1,0], [1,1]]

**Three rocks game**: again there are two piles, but the allowed operations are
[[0,1], [0,2], [0,3], [1,0], [1,1], [1,2], [2,0], [2,1], [3,0]]


The first variant can be played with `ruby 2_piles.rb`. As input, you give the
left and right pile sizes, separated by a space (e.g. `4 2`) and as output you
get the operation you should apply.

## Dynamic programming

The algorithm is built by constructing a list of good target states. This is a
list of states you want to reach applying your next operation. They are such
that, no matter what operation the opponent performs, there's always a way to
apply some operation that gives you again a good state.

