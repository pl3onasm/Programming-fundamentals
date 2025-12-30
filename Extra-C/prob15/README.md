$\huge\color{cadetblue}{\text{Tricky squares}}$

<br/>

A number $n$ is a perfect square if there exists an integer $k$ so that $k^2 = n$. We will call a perfect square $n$ a ‘tricky square’ if exactly one of the digits $0 \dots 9$ appears more than once in the number.

For example, $1444$ is a tricky square since $38^2 = 1444$ and 4 is the only digit that appears more than once in the number. However, $961$ is not a tricky square even though $31^2 = 961$, since no digit appears more than once in the number. Similarly, $7744$ is not a tricky square even though $88^2 = 7744$, because both $4$ and $7$ appear more than once. Finally, $404$ is not a tricky square even though only $4$ appears more than once, since there is no integer number $k$ such that $k^2 = 404$.

The input for this exercise consists of a line with two numbers $a$ and $b$ with $1 \leq a < b \leq 10^{10}$. The output should be the number of tricky squares that are at least $a$ and at most $b$.

<br/>

$\Large\color{darkseagreen}{\text{Examples}}$

```text
input:
  1 100
output:
  1

input:
  100 225
output:
  4

input:
  12345 123456
output:
  130
```
