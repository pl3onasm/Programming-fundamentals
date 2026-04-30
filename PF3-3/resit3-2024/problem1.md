$\huge\color{cadetblue}{\text{Problem 1}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 1.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N * N) {
  i++;
  s += 2 * i + 1;
}
```

At the end of each iteration, $s$ is incremented by $2i + 1$. Using Gauss' formula for the sum of the first $n$ integers, we have at the end of the $i$-th iteration:

$$
\begin{align*}
s &= 2 \sum_{k=1}^{i} k + i \\
&= i(i+1) + i \\
&= i^2 + 2i
\end{align*}
$$

The loop will terminate when:

$$
\begin{align*}
& s \geq N^2 \\
\Leftrightarrow \quad  &i^2 + 2i \geq N^2 \\
\Leftrightarrow \quad &i^2 + 2i + 1 \geq N^2 + 1 \\
\Leftrightarrow \quad &(i + 1)^2 \geq N^2 + 1 \\
\Leftrightarrow \quad &i + 1 \geq \sqrt{N^2 + 1} \\
\Leftrightarrow \quad &i \geq \sqrt{N^2 + 1} - 1 \approx N
\end{align*}
$$

Thus, the number of iterations is about $N$, and the fragment's complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.2: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log(N))}}}$  

<br/>

```c
int s = 1, t = 0;
for (int i = 0; i < N; i++) {
  s += i;
  for (int j = 1; j < s; j += j) {
    t += j;
  }
}
```

The outer loop runs $N$ times, computing the sum of the integers from $0$ to $N-1$, so that at each iteration $s = i(i+1)/2$. The second loop runs $\log(s)$ times, since the loop index $j$ is doubled at each iteration of the inner loop. Thus, the total number of iterations becomes:

$$
\begin{align*}
&\space \sum_{i=1}^{N-1} \log\left(\frac{i(i+1)}{2}\right) \\
=& \space \sum_{i=1}^{N-1} \left( \log\left(i(i+1)\right) - \log(2) \right)\\
=& \space\log\left(\prod_{i=1}^{N-1} \left(i(i+1)\right)\right) - (N-1) \\
=& \space\log\left(\prod_{i=1}^{N-1} i \prod_{i=1}^{N-1} (i+1)\right) -N +1 \\
=& \space\log\left((N-1)!\cdot N!\right) -N +1 \\
=& \space\log\left(N!^2\right) - \log(N) -N + 1 \\
=& \space2\log(N!) - \log(N) -N + 1 \\
=& \space \mathcal{O}(N \log(N))
\end{align*}
$$

The fragment's complexity is therefore in $\mathcal{O}(N \log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0, i = 0;
while (s < N) {
  for (j = 0; j < 10; j++) {
    s += i + j;
  }
  i += 10;
}
```

Let $k \in \lbrace 1, 2, 3, \dots \rbrace$ be the number of iterations of the outer loop. At each iteration of the inner loop, $s$ is then incremented by $100(k-1) + 45$, where $45$ is the sum of the integers from $0$ to $9$, computed using Gauss' formula. The outer loop will terminate when:

$$
\begin{align*}
& s \geq N \\
\Leftrightarrow \quad &100(k-1) + 45 \geq N \\
\Leftrightarrow \quad &k \geq \frac{N}{100} + 0.55 \\
\end{align*}
$$

We therefore conclude that the fragment's complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.4: }}{\color{darkseagreen}{{\space \mathcal{O}( \log(N))}}}$  

<br/>

```c
int s = 0, n = N;
while (n > 0) {
  n = (n % 2 ? n / 2 : n - 1);
  s += n;
}
```

In the best case, $N$ is a power of $2$, so that $n$ is halved at each iteration, and the loop runs $\log(N)$ times. In the worst case, $n$ is halved half of the time and decremented by $1$ the other half of the time, so that the loop runs $2\log(N)$ times. The fragment's complexity is therefore in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N*N; i += 2) {
  s += i;
}
```

The loop index $i$ is incremented by $2$ at each iteration, so that the loop runs $N^2/2$ times. The fragment's complexity is therefore in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.6: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i * i < N; i += 2) {
  s += i;
}
```

The loop's termination condition can be rewritten as $i^2 < N$, which is equivalent to $i < \sqrt{N}$. Since $i$ is incremented by $2$ at each iteration, the loop runs $\sqrt{N}/2$ times. The fragment's complexity is therefore in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.7: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0, t = 0;
for (int i = 0; i < N; i++) {
  s += i;
}
while (s > 2) {
  s = 1 + s / 2;
  t++;
}
```

The first loop runs $N$ times, computing the sum of the integers from $0$ to $N-1$, so that at termination $s = N(N-1)/2$. The second loop divides $s$ by $2$ at each iteration and adds $1$ to the result. The loop will terminate when $s \leq 2$, which will happen after at most $2\log(N)$ iterations.  

The loops are not nested, and so the most expensive one, the for loop in this case, determines the fragment's overall time complexity, which is thus in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.8: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int i = 0, j = N;
while (j - i > 1) {
  int m = (i + j)/2;
  i = (m * m <= N ? m : i);
  j = (m * m > N ? m : j);
}
```

In each loop iteration $m$ is set to the average of $i$ and $j$, and then either $i$ or $j$ is updated to $m$ depending on whether $m^2$ is less than or greater than $N$. In other words, the interval $[i, j]$ is halved at each and every iteration, and the loop terminates when $i$ and $j$ have become adjacent integers. The fragment's complexity is therefore in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.9: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i++) {
  int k = 2 + i % 5;
  for (int j = 1; j < N; j *= k) {
    s += i + j;
  }
}
```

The outer loop is linear in $N$: it runs $N$ times. The inner loop runs $\log_k(N)$ times, as $j$ is multiplied by $k$ at the end of each iteration, where $k$ is a constant in the range $[2, 6]$, meaning that the loop runs at most $\log(N)$ times.  

Since the loops are nested, the fragment's complexity is in $\mathcal{O}(N \log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.10: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 1; i < N; i++) {
  for (int j = 0; j < 10; j++) {
    for (int k = N - j; k >= 0; k--) {
      s += i + j + k;
    }
  }
}
```

The outer loop runs $N-1$ times, and the innermost loop runs $10\cdot (N-j+1)$ times, where $j$ lies in the range $[0, 9]$. In fact, the only purpose of the middle loop is to make the innermost loop run $10$ times, and the fact that $j$ is subtracted from the initial value of the loop index $k$ at each iteration is irrelevant for the complexity analysis. The middle loop can therefore be ignored, and the fragment's complexity is determined by the product of the number of iterations of the outer and innermost loops, which is $N^2$.

The fragment's overall complexity is therefore in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.11: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int i = 0, j = 0, s = 0;
while (i * j < 2 * N) {
  i = i + 1;
  j = j + 2;
  s = s + i + j;
}
```

The loop will terminate when $i \cdot j \geq 2N$, which is equivalent to $i \cdot (2i) \geq 2N$, or $i^2 \geq N$. The loop will therefore run $\sqrt{N}$ times, and the fragment's complexity is in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.12: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 1, s = 0;
while (i * i < N) {
  i = 2 * i;
}
while (i > 0) {
  for (int j = 0; j < i; j++) {
    s += i + j;
  }
  i--;
}
```

The first loop terminates when $i$ is the smallest power of $2$ such that $i^2 \geq N$, which is equivalent to $i \geq \sqrt{N}$. A tight upper bound for the final value of $i$ is $2\sqrt{N}$, so that in the worst case the first loop runs $\log(2\sqrt{N}) = (1/2)\log(N) + 1$ times.

The second while loop is nested. The outer loop runs $\sqrt{N}$ times, while the inner loop runs $i$ times, for each value of $i$ in the range $[1, 2\sqrt{N}]$, so that the total number of iterations can be computed as follows:

$$
\begin{align*}
& \space \sum_{i=1}^{2\sqrt{N}} i \\
=& \space \frac{2\sqrt{N}(2\sqrt{N}+1)}{2} \\
=& \space 2N + \sqrt{N} \\
=& \space \mathcal{O}(N)
\end{align*}
$$

Since the two while loops are not nested, the most expensive one, the second one in this case, determines the fragment's overall time complexity, which is thus in $\mathcal{O}(N)$.

<br/>

--------
 <sub><sup>Kindly note that, here and elsewhere, I left out ceilings and/or floors as they are not relevant for the complexity analysis, and only serve to complicate the expressions.</sup></sub>

<br/>