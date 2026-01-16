$\huge\color{cadetblue}{\text{Prime choice}}$

<br/>

The input for this exercise is a positive integer $n$. The output should be the $n$-th prime in the ordered list of prime numbers. In this list, the first five primes are $2, 3, 5, 7,$ and $11$. The time limit for this calculation is 1 second. It is guaranteed that $n \le 300\,000$. Note that it is not allowed to use a hardcoded table lookup strategy.

**Hint.** Primes get rarer as numbers get larger. The average gap between two consecutive primes near a large number $x$ is about $\ln(x)$, suggesting that the $n$-th prime number $p_n$ is roughly $n\ln(n)$. A safe explicit upper bound (by Rosser and Schoenfeld) is, for $n \ge 6$:
\[
p_n < n\bigl(\ln(n) + \ln(\ln(n))\bigr)
\]

<br/>

$\Large\color{darkseagreen}{\text{Examples}}$

```text
input:
  1
output:
  2

input:
  100
output:
  541

input:
  1000
output:
  7919
```
