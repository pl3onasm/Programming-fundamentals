$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i += 3) {
  for (int j = 3*N; j > 0; j /= 2) {
    s += i*j;
  }
}
```

The outer loop runs $N/3$ times, and the inner loop runs $\log(3N) = \log(3) + \log(N)$ times. Since the loops are nested, we obtain the total number of iterations by multiplying the number of iterations of the outer loop by the ones of the inner loop, and come to an overall time complexity of $\mathcal{O}(N\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int s = 0;
for (int i = 1; i < N*N; i *= 3) {
  s += i*i;
}
```

The number of iterations of the loop is given by the number of times $i$ can be multiplied by 3 before it exceeds $N^2$. This is equivalent to solving the equation $3^k = N^2$ for $k \in \mathbb{N}$, which yields $k = \log_3(N^2)$. We can rewrite this as:

$$
\begin{align*}
\log_3(N^2) &= \frac{\log(N^2)}{\log(3)} \\
&= \frac{2}{\log(3)}\log(N) \\
&= \mathcal{O}(\log(N))
\end{align*}
$$

Thus, the overall time complexity is in $\mathcal{O}(\log(N))\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N) {
  s += i;
  i++;
}
while (i > 0) {
  s += i;
  i--;
}
```

The first loop terminates when $s \geq N$. Since $s$ is incremented by $i$ in each iteration, we have $s = i(i-1)/2$ by Gauss' formula. Note that $i$ is incremented $\color{mediumorchid}{\text{after}}$ $s$ is updated, so that when the loop condition is checked, the value of $s$ equals the sum of the first $i - 1$ positive integers. Hence, the loop terminates when:

$$
\begin{align*}
&\frac{i (i-1)}{2} \geq N \\
\Leftrightarrow \quad &i^2 - i \geq 2 N \\
\Leftrightarrow \quad &i^2 - i + \frac{1}{4} \geq 2 N + \frac{1}{4} \\
\Leftrightarrow \quad &(i - \frac{1}{2})^2 \geq 2 N + \frac{1}{4} \\
\Leftrightarrow \quad &i - \frac{1}{2} \geq \sqrt{2 N + \frac{1}{4}} \\
\Leftrightarrow \quad &i \geq \sqrt{2 N + \frac{1}{4}} + \frac{1}{2} \approx \sqrt{2 N}
\end{align*}
$$

The second loop decrements $i$ until it reaches 0 in a total of about $\sqrt{2N}$ steps. The loops are not nested, so we obtain an overall time complexity of $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int i, j = 0, s = 0;
for (i = 0; i < N; i++) {
  for (j = 0; j < 5*i; j += 2) {
    s += i + j;
  }
}
```

The outer loop runs $N$ times, and the inner loop runs $5i/2$ times for each iteration of the outer loop. Thus, the total number of iterations is given by:

$$
\begin{align*}
\sum_{i=0}^{N-1} \frac{5i}{2} &= \frac{5}{2} \sum_{i=0}^{N-1} i \\
&= \frac{5}{2} \frac{N (N-1)}{2} &\color{peru}{(1)}\\
&= \mathcal{O}(N^2)
\end{align*}
$$

In $\color{peru}{(1)}$, we used Gauss' formula to compute the sum of the first $N - 1$ positive integers. From the above, we conclude that the overall time complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int s = 0;
for (int i = N; i > 0; i--) {
  int d = 2 + i % 5;
  for (int j = 1; j < N; j *= d) {
    s += j*s;
  }
}
```

The outer loop runs $N$ times. The inner loop runs $\log_d(N) = \log(N) / \log(d)$ times, where $d \in \left[2, 7\right)$, which is in $\mathcal{O}(\log(N))$. Since the loops are nested, we obtain an overall time complexity of $\mathcal{O}(N\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N*N) {
  s += i;
  i++;
}
```

This loop is the same as the first one in [ex3](https://github.com/pl3onasm/Imperative-programming/blob/main/IP-Finals/2017/problem2.md#ex3-colorrosybrownmathcalosqrtn), except that the loop condition here is $s < N^2$ instead of $s < N$. Following the same reasoning, we obtain that the loop terminates when $i \geq \sqrt{2 N^2 + 1/4} + 1/2 \approx \sqrt{2} N$. Thus, the overall time complexity is in $\mathcal{O}(N)$.

<br/>