$\huge\color{cadetblue}{\text{Problem 3}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 3.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 0, j = N;
while (i < j) {
  i++;
  j--;
}
```

Both variables run through their consecutive values, until they meet in the middle at which point the loop terminates. The total number of iterations is $N/2$, and the fragment's complexity is therefore in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.2: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int i = 0, j = N;
while (j - i > 1) {
  if (i % 2 == 0) {
    i = (i + j)/2;
  } else {
    j = (i + j)/2;
  }
}
```

This is a binary search algorithm. At each iteration, the size of the interval is halved, and the loop terminates when the interval is of size $1$ or less. The number of iterations is therefore the number of times $N$, the size of the search interval, can be halved before reaching $1$, which is $\log(N)$. Thus, the fragment's complexity is in $\mathcal{O}(\log N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.3: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int i = 0;
while (i*i < N) {
  i++;
}
```

The loop terminates when $i^2 \geq N$, which is equivalent to $i \geq \sqrt{N}$. Thus, the number of iterations is $\sqrt{N}$, and the fragment's complexity is in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int i, j = 0, s = 0;
for (i = 0; i < N; i++) {
  s += i;
}
for (i = 0; i < s; i++) {
  j += i;
}
```

The first loop computes the sum of the first $N - 1$ integers in $N$ steps, so that in the end, we have $s = N(N-1)/2$. The second loop then runs $s$ times, which is quadratic in $N$. The loops are not nested, and so the overall complexity is determined by the most expensive loop, which is the second one. Thus, the fragment's complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int i, j, s = 0;
for (i = 1; i < N; i++) {
  for (j = 1; j < i; j *= 2) {
    s += j;
  }
}
```

The outer loop runs $N - 1$ times, whereas the inner loop runs $\log(i)$ times for each value of $i$. The total number of iterations is therefore given by:

$$
\begin{align*}
\sum_{i=1}^{N-1} \log(i) &= \log\left(\prod_{i=1}^{N-1} i\right) \\
&= \log\left((N-1)!\right) \\
&= \mathcal{O}(N \log N)
\end{align*}
$$

Thus, the fragment's complexity is in $\mathcal{O}(N \log N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i, j, s = 0, a[5] = {0, 0, 0, 0, 0};
for (i = 0; i < N; i++) {
  a[i % 5]++;
}
for (i = 0; i < 5; i++) {
  for (j = 0; j < a[i]; j++) {
    s += i + j;
  }
}
```

The first loop runs $N$ times: it sets the values of the items in the array $a$ to their respective values. The second loop is nested: the outer loop runs $5$ times, whereas the inner loop runs $a[i]$ times, which is at most $\lfloor N/5 \rfloor + 1$, given the fact that $a[i]$ is incremented at most $\lfloor N/5 \rfloor + 1$ times in the first loop.
This means that both the first and the second, nested loop are linear in $N$, and so the fragment's total complexity is in $\mathcal{O}(N)$.

<br/>