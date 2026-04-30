$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i++) {
  for (int j = i; j > 0; j--) {
    s += i + j;
  }
}
```

The outer loop runs $N$ times, and the inner loop runs $i$ times for each iteration of the outer loop. Thus, the total number of iterations is given by:

$$
\begin{align*}
\sum_{i=0}^{N-1} i
&= \frac {N(N-1)}{2} &\color{peru}{(1)}\\
&= \mathcal{O}(N^2)
\end{align*}
$$

In $\color{peru}{(1)}$, we used Gauss' formula to compute the sum of the first $N - 1$ positive integers. From the above, we conclude that the overall time complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N) {
  i++;
  s = i*i;
}
```

The loop runs until $s = i^2 \geq N$. As $i$ keeps track of the number of iterations, the loop runs a total of approximately $\sqrt{N}$ times. Thus, the overall time complexity is in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int n = N, a = 2, p = 1;
while (n > 0) {
  if (n % 2 == 1) {
    p = p*a;
    n--;
  } else {
    a = a*a;
    n = n/2;
  }
}
```

This fragment computes $2^N$ by repeated squaring. The loop runs until $n = 0$. In the worst case, $n$ is halved only half of the time, and decremented by $1$ the other half of the time. In this case, the loop still needs less than $2\log(N)$ iterations to terminate. Thus, the overall time complexity is in $\mathcal{O}(\log (N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int i, j = 0, s = 0;
for (i = 0; i < N; i++) {
  s += i;
}
for (i = 0; i < s; i += 2) {
  j += i;
}
```

The first loop runs $N$ times and computes $s = N(N - 1)/2$ (by Gauss' formula). The second loop runs a total of $s/2$ $= N(N - 1)/4$ times. The loops are not nested and thus the second loop clearly dominates the time complexity as it is quadratic in $N$. Thus, the overall time complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 0, s = 1;
for (i = 0; i < 4*N; i += 2) {
  s = 2*s;
}
```

The loop runs $\frac{4N}{2} = 2N$ times. The overall time complexity is therefore in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int i, j, s = 0;
for (i = 0; i < N; i++) {
  for (j = N; j > i ; j /= 2) {
    s++;
  }
}
```

The outer loop runs $N$ times. For each iteration of the outer loop, the inner loop runs $\log(N - i)$ times. The loops are nested, and so the total number of iterations is given by:

$$
\begin{align*}
\sum_{i=0}^{N-1} \log(N - i) &= \sum_{i=1}^{N} \log(i) \\
&= \log\left(\prod_{i=1}^{N} i\right) \\
&= \log(N!)\\
&= \mathcal{O}(N\log(N))
\end{align*}
$$

Thus, the overall time complexity is in $\mathcal{O}(N\log(N))$.

<br/>