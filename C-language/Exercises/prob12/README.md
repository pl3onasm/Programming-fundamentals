$\huge\color{cadetblue}{\text{Separated by distance}}$

<br/>

The input for this problem consists of two lines. The ﬁrst line holds the number $k$, while the second holds a sequence of integer numbers. The goal is to count the number of unique pairs $(i, j)$ in the sequence that are exactly $k$ apart, i.e., $j - i = k$.

For example, suppose $k = 7$ and consider the sequence below.

$$[1, 2, 3, 1, 4, 7, 4, 8, 9, 6, 5, 10, 10, 8]$$

This sequence has exactly three unique pairs that are $7$ apart: $(1, 8)$, $(2, 9)$, and $(3, 10)$. Note that duplicate numbers should produce additional pairs, i.e., only unique pairs should be counted.

<br/>

$\Large\color{darkseagreen}{\text{Examples}}$

```text
input:
  9
  53 62 35 25 4 57 42 31 16 82
output:
  2

input:
  9
  56 91 81 43 96 85 86 7 64 44 51 22 16 53 21 60 90 71 51 28
output:
  4

```
