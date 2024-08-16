$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
int d = 2;
while (d*d <= N) {
  if (N % d == 0) {
    break;
  }
  d++;
}
```

The code fragment looks to find the smallest divisor of $N$, if any. In the worst case, $N$ is prime or has no other divisors than its square root (e.g. $N = 25$). In this worst case scenario, the loop will run $\sqrt{N}$ times. Thus, the overall time complexity is in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i++) {
  s += i;
}
for (int i = s; i > 1; i -= 2) {
  s++;
}
```

The first loop is linear: it runs $N$ times. When it ends, we have $s = N(N-1)/2$, by Gauss' formula for the sum of the first $N - 1$ integers. The second loop then runs $s/2$ $= N(N-1)/4$ times, which is quadratic in $N$. Since the loops are not nested, and the second one takes the most time, the overall time complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int d = 2, n = N;
while (n > 1) {
  if (n % d == 0) {
    n = n / d;
  } else {
    d++;
  }
}
```

The loop keeps dividing $n$ by its prime divisors until $n \leq 1$. In the worst case, $N$ is prime, and the loop runs $N$ times: it only terminates after the prime $N$ is divided by itself. Thus, the overall time complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log(N))}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i++) {
  for (int j = 1; j < i; j *= 2) {
    s++;
  }
}
```

The outer loop runs $N$ times, and the inner loop runs $\log(i)$ times for each iteration of the outer loop, so that the total number of iterations is given by:

$$
\begin{align*}
\sum_{i=1}^{N-1} \log (i) &= \log \left( \prod_{i=1}^{N-1} i \right)\\
&= \log((N-1)!)\\
& = \mathcal{O}(N \log N)
\end{align*}
$$

Hence, the fragment's complexity is in $\mathcal{O}(N \log N)$.  [^1]

[^1]: Note that we need to let i start from 1, not 0, otherwise the logarithm would be undefined for i = 0. This does not affect the time complexity, however, as the first iteration of the inner loop is skipped anyway.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int a = 42, n = N, p = 1;
while (n > 0) {
  if (n % 2 == 1) {
    p *= a;
  }
  a = a*a;
  n /= 2;
}
```

The program computes $42^N$ using the binary exponentiation algorithm. The loop runs $\log(N)$ times, since $n$ is halved at each iteration until it reaches 0. Thus, the overall time complexity is in $\mathcal{O}(\log N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 0, j = 0, s = 0;
while (i < N) {
  i += j;
  j++;
  for (int k = 0; k*k < N; k++) {
    s++;
  }
}
```

If we first look at the outer loop without considering the inner one, we see that $i$ is incremented by $j$, which itself is incremented by $1$ at each iteration, so that $i$ is the sum of the first $j$ integers at the end of each iteration. The outer loop terminates when $i \geq N$, which happens when $j(j+1)/2 \geq N$, for which we get the solution $j = \sqrt{2N + 1/4} - 1/2$ $\approx \sqrt{2N} $. So, the outer loop runs in $\mathcal{O}(\sqrt{N})\space$ time.  
The inner loop increments $k$ by $1$ at each iteration, and terminates when $k^2 \geq N$ $\Leftrightarrow$ $k \geq \sqrt{N}$. Thus, the inner loop runs in $\mathcal{O}(\sqrt{N})\space$ time as well. Since the loops are nested, the overall time complexity is in $\mathcal{O}(N)$.

<br/>