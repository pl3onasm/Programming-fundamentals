# $\color{cadetblue}{\text{Problem 2}}$

## Ex1: $\color{rosybrown}{{\mathcal{O}(\sqrt{N})}}$

```c
int i = 0, s = 0;
while (s < N) {
  i++;
  s = s + i;
}
```

In each loop iteration, the variable $i$ is incrememted by $1$, while the variable $s$ keeps track of the sum of the first $i$ integers. The loop terminates when $s = \frac{i(i+1)}{2} \geq N$. Therefore, the fragment's time complexity is in $\mathcal{O}(\sqrt{N})$.

## Ex2: $\color{rosybrown}{{\mathcal{O}(N^2)}}$

```c
int j = N * N, s = 0;
for (int i = 1; i < j; i += 2) {
  s = s + i;
}
```

The loop iterates $\frac{N^2 - 1}{2}$ times, and so the time complexity of the fragment is in $\mathcal{O}(N^2)$.

## Ex3: $\color{rosybrown}{{\mathcal{O}(N)}}$

```c
int s = 0;
for (int i = 0; i < N; i++) {
  for (int j = 5; j > 0; j--) {
    s += j;
  }
}
```

The outer loop iterates $N$ times, and the inner loop runs $5$ times. The loops are nested, so that the total number of iterations is $5N$. Therefore, the time complexity of the fragment is in $\mathcal{O}(N)$.

## Ex4: $\color{rosybrown}{{\mathcal{O}(N\log(N))}}$

```c
for (int i = 0; i < N; i++) {
  int j = i;
  while (j > 0) {
    j /= 2;
  }
}
```

The outer loop is linear in $N$, and the inner loop runs $\log(i)$ times for each iteration of the outer loop, so that the total number of iterations is given by

$$
\begin{align*}
\sum_{i=1}^N \log(i) &= \log\left(\prod_{i=1}^N i\right) \\
&= \log(N!) \\
&= \mathcal{O}(N\log(N))
\end{align*}
$$

Hence, the time complexity of the fragment is in $\mathcal{O}(N\log(N))$.

## Ex5: $\color{rosybrown}{{\mathcal{O}(\log(N))}}$

```c
int s = 0;
for (int i = 1; i < N * N; i = i * 3) {
  s++;
}
```

The loop condition is $i < N^2$, which means that the loop terminates when $i = 3^k$ for some $k$, so that $3^k \geq N^2$. Taking the logarithm of both sides, we find that $k \geq \log_3(N^2)$, and so the number of iterations is given by

$$
\begin{align*}
\log_3(N^2) &= \frac{\log(N^2)}{\log(3)} \\
&= \frac{2}{\log(3)} \log(N) \\
&= \mathcal{O}(\log(N))
\end{align*}
$$

Hence, the time complexity of the fragment is in $\mathcal{O}(\log(N))$.

## Ex6: $\color{rosybrown}{{\mathcal{O}(N)}}$

```c
int s = 0;
for (int i = N; i > N / 2; i = i - 2) {
  s = s + i;
}
```

The loop index is initialized to $N$, and decremented by $2$ at the end of each iteration. The loop thus terminates after a total number of $\frac{N}{4}$ iterations, and so the fragment's time complexity is in $\mathcal{O}(N)$.