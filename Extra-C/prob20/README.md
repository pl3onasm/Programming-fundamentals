$\huge\color{cadetblue}{\text{Cycle counting}}$

<br/>

The input for this exercise is a list of an unknown number of integers. The given list defines a path through its indices as follows: starting at an index i, the next index is given by the value at position i. In other words, if we call the list `lst`, then from index `i` you move to index `lst[i]`. This process is repeated to form a path.

For example, the input $1 \space 2 \space 0$ represents the path $0 \rightarrow 1 \rightarrow 2 \rightarrow 0$, which forms one cycle that visits all indices exactly once. However, the input $2 \space 1 \space 0$ contains two separate cycles: $0 \rightarrow 2 \rightarrow 0$ and $1 \rightarrow 1$.

The goal of this exercise is to determine how many distinct cycles occur in the input list. The output should be this number of cycles. You may assume that all numbers in the input are valid indices of the list.

<br/>

$\Large\color{darkseagreen}{\text{Examples}}$

```text
input:
  1 2 0 4 3
output:
  2

input:
  1 0 3 4 2 5
output:
  3

input:
  2 6 3 0 7 5 1 8 4
output:
  4
```
