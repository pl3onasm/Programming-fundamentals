$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
int n = 1, d = 1;
while (d < N) {
  d = d + 2*n + 1;
  n++;
}
```

At the end of each loop iteration, $d$ equals the square of $n$, the variable that keeps track of the number of iterations. So at loop termination, we have:

$$
\begin{align*}
&d \geq N \\
\Leftrightarrow \quad &n^2 \geq N \\
\Leftrightarrow \quad &n \geq \sqrt{N}
\end{align*}
$$

Thus, the fragment's overall time complexity is in $\mathcal{O}(\sqrt{N})\space$.

The fragment is based on Gauss' formula for the sum of the first $n$ integers, but modified so that $d$ becomes the exact square of $n$, and not $n(n+1)/2$, at the end of each iteration.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i++) {
  for (int j = N; j > i; j -= 2) {
    s++;
  }
}
```

The outer loop is linear: it runs $N$ times. The inner loop runs $(N - i)/2$ times for each value of $i$, so that the total number of times the body of the inner loop is executed is:

$$
\begin{align*}
\sum_{i=0}^{N-1} \frac{N - i}{2}&= \frac{1}{2}\sum_{i=0}^{N-1} N - \frac{1}{2} \sum_{i=0}^{N-1} i\\
&= \frac{N \cdot N}{2} - \frac{1}{2} \sum_{i=0}^{N-1} i \\
&= \frac{ N^2}{2} - \frac{1}{2} \cdot \frac{N(N-1)}{2} \\
&= \frac{1}{4} N(N+1) \\
\end{align*}
$$

Thus, the fragment's time complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0, i = 0;
while (i < N) {
  i += (s % 2 == 0) ? 1 : 2;
  s++;
}
```

In each iteration, $i$ is incremented by either $1$ or $2$, depending on the parity of $s$, which switches in each iteration. This means that $i$ is incremented by $3$ every two iterations, and the loop needs around $2/3N$ iterations to reach or exceed $N$. Thus, the fragment's complexity is in $\mathcal{O}(N)$.

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

The outer loop is linear: it runs $N$ times, whereas the inner loop runs $\log(i)$ times for each value of $i$. Thus, the total number of iterations is:

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
int l = 0, r = N;
while (l + 1 < r) {
  int m = (l + r) / 2;
  if (N < m * m) {
    l = m;
  } else {
    r = m;
  }
}
```

We can interpret the variables $l$ and $r$ as indexes indicating the left and right end of a sequence of $N$ elements. In each iteration, the fragment checks whether the middle element of the sequence is greater than $\sqrt{N}$ or not. If it is, then the left end of the sequence is moved to the middle index, otherwise the right end, meaning that half of the sequence is discarded in each iteration.  
This process is repeated until the left and right ends are adjacent to each other. Thus, just like binary search, the fragment runs in $\mathcal{O}(\log N)$ time.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int a = 0, b = 1, n = 0;
while (n < N) {
  b = a + b;
  a = b - a;
  n++;
}
```

The fragment is based on the Fibonacci sequence. In each iteration, the variables $a$ and $b$ are updated to the next two numbers in the sequence. For example, after five iterations, we get $a = 5$ and $b = 8$. The variable $n$ is incremented by $1$ in each iteration, and the loop terminates when $n = N$. Thus, the fragment runs in $\mathcal{O}(N)$ time.

<br/>