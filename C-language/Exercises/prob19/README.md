$\huge\color{cadetblue}{\text{Increasing numbers}}$

<br/>

In the sequence $[1 \space 9 \space 2 \space 3 \space 5 \space 7 \space 6 \space 8]$, the longest **contiguous** subsequence of **strictly** increasing numbers is $[2 \space 3 \space 5 \space 7]$. However, if we are allowed to remove the numbers $9$ and $7$, the longest subsequence would have been $[1 \space 2 \space 3 \space 5 \space 6 \space 8]$ .

The input of this problem consists of two lines. The ﬁrst line contains an unknown number of integers. The second line is the maximum number $k$ of values you are allowed to remove from this sequence. The output is the length of the longest increasing subsequence possible when removing at most $k$ values from the original sequence.

<br/>

$\Large\color{darkseagreen}{\text{Examples}}$

```text
input:
  1 9 2 3 5 7 6 8
  2
output:
  6

input:
  1 2 3 3 4 4 5 6 7 8
  1
output:
  6

input:
  1 2 3 4 4 5 6 7 8
  2
output:
  8
```
