$\huge\color{cadetblue}{\text{Problem 1}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 1.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 0, s = N*N;
while (s > 0) {
  i++;
  s -= i;
}
```

After $n$ iterations, we have $s = N^2 - n(n+1)/2$. The loop will terminate when $N^2 - n(n+1)/2 \leq 0$, or $n(n+1)/2 \geq N^2$, which is equivalent to $n^2 + n \geq 2N^2$. The fragment's complexity is therefore in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.2: }}{\color{darkseagreen}{{\space \mathcal{O}(\log{N})}}}$  

<br/>

```c
int s = 0, i = N;
while (i > 0) {
  s += i;
  i = (i % 2 ? i - 1 : i / 2);
}
```

The variable $i$ starts at $N$. In the worst case, we are then halving it half of the time and decrementing it by $1$ the other half of the time. In this worst case, the loop roughly needs $2\log(N)$ iterations to terminate. The fragment's complexity is therefore in $\mathcal{O}(\log(N))$.

Note: It is crucial to see that decrements only occur when $i$ is odd in order to make it even and that they are applied to the updated value of $i$ after the halving operation, not to the original value of $i$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log{N})}}}$  

<br/>

```c
int bits = 0;
for (int i = 0; i < N; i++) {
  for (int j = i; j > 0; j /= 2) {
    bits += j % 2;
  }
}
```

For each value of $i$, the inner loop runs $\lfloor \log(i) \rfloor$ times, so that the total number of iterations approaches:

&nbsp; $\sum_{i=1}^{N-1} \log(i) $

&nbsp; $\quad = \log(1) + \log(2) + \ldots + \log(N-1)$

&nbsp; $\quad = \log(1 \cdot 2 \cdot \ldots \cdot (N-1))$

&nbsp; $\quad = \log((N-1)!) = \mathcal{O}(N \log{N})$

Therefore, the fragment's complexity is in $\mathcal{O}(N \log{N})$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 1; i < N; i += 2) {
  s = s + N;
}
while (s > 0) {
  s--;
}
```

The first loop runs $\lceil N/2 \rceil$ times, after which $s = N \cdot \lceil N/2 \rceil$ $\approx N^2/2$. Since the loops are not nested, the fragment's complexity is dominated by the most expensive one, which is the while loop which decrements $s$ by $1$ until it reaches $0$. The fragment's complexity is therefore in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log{N})}}}$  

<br/>

```c
int s = 0;
for (int i = 2*N; i > 0; i--) {
  for (int j = 1; j < N; j *= 2) {
    s++;
  }
}
```

The first loop runs $2N$ times, and the second loop runs $\log(N)$ times. The loops are nested, so that the fragment's complexity is in $\mathcal{O}(N \log{N})$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.6: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
for (int i = 1; i < 10; i++) {
  int j = 0, k = 0;
  while (j < N) {
    j += 2*k + 1;
    k++;
  }
}
```

The outer loop runs $9$ times, and merely adds a constant factor to the complexity, so we can completely ignore it. At the end of each iteration of the inner loop, we have $j = k^2$. The inner loop will terminate as soon as $j \geq N$, which is equivalent to $k^2 \geq N$. The fragment's complexity is therefore in $\mathcal{O}(\sqrt{N})$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.7: }}{\color{darkseagreen}{{\space \mathcal{O}(\log{N})}}}$  

<br/>

```c
int a = 0, b = N;
while (b - a > 1) {
  int c = (a + b)/2;
  a = (c*c > N ? a : c);
  b = (c*c > N ? c : b);
}
```

The fragment is a binary search algorithm, trying to find an integer $c$ such that $c^2 = N$. The algorithm will terminate after $\log(N)$ iterations, since the search space [a, b] is halved at each iteration. The fragment's complexity is therefore in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.8: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log{N})}}}$

<br/>

```c
int s = 0;
for (int i = 0; i < N; i += 2) {
  for (int j = 1; j < i; j *= 2) {
    s++;
  }
}
```

The first loop runs $N/2$ times, and the second loop runs $\lfloor \log(i) \rfloor$ times for each value of $i$. The loops are nested, so that the fragment's complexity becomes $\mathcal{O}(N \log{N})$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.9: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int d = 2, s = 0, n = N;
while (n > 1) {
  while (n % d == 0) {
    n = n / d;
    s++;
  }
  d++;
}
```

The fragment is a prime factorization algorithm. In the worst case, $N$ is a prime number, so that the outer loop will only terminate when $d = N$. Since $d$ is incremented by $1$ at each iteration of the outer loop, that loop will run $N$ times in that worst case scenario, so that the fragment's complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.10: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$

<br/>

```c
int i = 0, j = N, k = 1;
while (i < j) {
  i += k;
  j++;
  k++;
}
```

After $n$ iterations, we have $i = n(n+1)/2$, $j = N+n$, and $k = n+1$. The loop will terminate when $i \geq j$, which is equivalent to $n(n+1)/2 \geq N+n$, or $n^2 -n \geq 2N$. The fragment's complexity is therefore in $\mathcal{O}(\sqrt{N})$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.11: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$

<br/>

```c
int s = 0;
for (int i = 1; i < 10; i++) {
  for (int j = i; j < N; j++) {
    for (int k = j; k < N; k++) {
      s += i + j + k;
    }
  }
}
```

The outer loop runs $9$ times, and merely adds a constant factor to the complexity, so we can completely ignore it and set $i$ to $0$ for convenience. The middle loop then runs $N$ times, and the innermost loop runs $N-j$ times for each value of $j$, so that we get:

&nbsp;&nbsp; $\sum_{j=0}^{N-1} (N-j)$

&nbsp; $\quad = N + (N-1) + (N-2) + \ldots + 1$

&nbsp; $\quad = N(N+1)/2$

Therefore, the fragment's complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.12: }}{\color{darkseagreen}{{\space \mathcal{O}(\log{N})}}}$

<br/>

```c
int s = 0, i = N;
while (i > 2) {
  s++;
  i = 1 + i/2;
}
```

After $n$ iterations, the value of $i$ is roughly $N/2^n$. The loop will terminate when $N/2^n \leq 2$, or $2^n \geq N/2$, which is equivalent to $n \geq \log(N/2)$. The fragment's complexity is therefore in $\mathcal{O}(\log(N))$.

<br/>
