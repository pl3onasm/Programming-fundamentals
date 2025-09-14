$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i, s = 0;
for (i = N; 2*i > 0; i--) {
  s += i;
}
```

The loop runs $N$ times, since the loop condition can be rewritten as $i > 0$. Hence, the fragment's time complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>


```c
int i, j, s=0;
for (i = 1; i < N; i *= 2) {
  for (j = i+1; j < N; j += 2) {
    s += j;
  }
}
```

The outer loop runs $\log(N)$ times, since it doubles $i$ at the end of each iteration. This means that $i$ is always a power of $2$, that is, $i = 2^k$ for $k \in \lbrace 0, 1, \ldots, \lfloor \log(N) - 1 \rfloor \rbrace$.  
The inner loop runs $(N - i + 1)/2$ times for each value of $i$. The total number of iterations is therefore:

$$
\begin{align*}
  & \quad \sum_{k=1}^{\lfloor \log(N) \rfloor} \frac{N - 2^k + 1}{2} \\
= & \quad \frac{1}{2} \sum_{k=1}^{\lfloor \log(N) \rfloor} (N+1) - \frac{1}{2} \sum_{k=1}^{\lfloor \log(N) \rfloor} 2^k \\
= & \quad \frac{1}{2} \lfloor \log(N) \rfloor (N+1) - \frac{1}{2} \sum_{k=0}^{\lfloor \log(N) \rfloor} (2^{k}) + \frac{1}{2} &\color{peru}{(1)}\\
= & \quad \frac{1}{2} \lfloor \log(N) \rfloor (N+1) - 2^{\lfloor \log(N) \rfloor} + 1 &\color{darkkhaki}{(2)} \\
\leq & \quad \frac{1}{2} \log(N) (N+1) - 2^{\log(N)} + 1 \\
= & \quad \mathcal{O}(N \log(N)) \\
\end{align*}
$$

In $\color{peru}{(1)}$ we rewrite the sum, so that the index $k$ starts at $0$ instead of $1$. This allows us to use the formula for the sum of a geometric series in $\color{darkkhaki}{(2)}$, with $a = 2$ and $n = \lfloor \log(N) \rfloor$:

$$
\sum_{k=0}^n a^k = \frac{a^{n+1} - 1}{a - 1} \quad \text{for} \quad a \neq 1
$$

From the above, we therefore have that the fragment's time complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int i = 0, s = 0, p = 1;
while (s < N) {
  i++;
  p = p*i;
  s += i;
}
```

At each iteration, $p$ equals the product of the first $i$ integers, so that $p = i!$, whereas $s$ equals the sum of the first $i$ integers, so that $s = i(i+1)/2$. The loop terminates when $s \geq N$, that is, when:

$$
\begin{align*}
&\frac{i (i+1)}{2} \geq N \\
\Leftrightarrow \quad &i^2 + i \geq 2 N \\
\Leftrightarrow \quad &i^2 + i + \frac{1}{4} \geq 2 N + \frac{1}{4} \\
\Leftrightarrow \quad &(i + \frac{1}{2})^2 \geq 2 N + \frac{1}{4} \\
\Leftrightarrow \quad &i + \frac{1}{2} \geq \sqrt{2 N + \frac{1}{4}} \\
\Leftrightarrow \quad &i \geq \sqrt{2 N + \frac{1}{4}} - \frac{1}{2} \approx \sqrt{2 N} \\
\end{align*}
$$

Hence, the fragment's time complexity is in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(\log(N))}}}$  

<br/>

```c
int i = N, s = 0;
while (i > 0) {
  s++;
  if (i % 2 == 1) {
    i = i - 1;
  }
  i = i/2;
}
```

The loop runs $\log(N)$ times, since $i$ is halved at each iteration. The *if* statement merely ensures that $i$ is always even before dividing it by $2$. Therefore, the fragment's time complexity is in $\mathcal{O}(\log N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int i = 0, s = 0;
while (2*i <= N*N) {
  s += i;
  i++;
}
```

At each iteration, $i$ is incremented by $1$, so that $i$ keeps track of the number of iterations. When the loop terminates, we have $2i > N^2$, that is, $i > N^2/2$. Hence, the fragment's time complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 0, s = 0;
while (s <= N*N) {
  s += i;
  i++;
}
```

The loop terminates when $s > N^2$, that is, when:

$$
\begin{align*}
&1 + 2 + \cdots + (i - 1) > N^2 \\
\Leftrightarrow \quad &\frac{i(i-1)}{2} > N^2 \\
\Leftrightarrow \quad &i^2 - i > 2 N^2 \\
\Leftrightarrow \quad &i^2 - i + \frac{1}{4} > 2 N^2 + \frac{1}{4} \\
\Leftrightarrow \quad &(i - \frac{1}{2})^2 > 2 N^2 + \frac{1}{4} \\
\Leftrightarrow \quad &i - \frac{1}{2} > \sqrt{2 N^2 + \frac{1}{4}} \\
\Leftrightarrow \quad &i > \sqrt{2 N^2 + \frac{1}{4}} + \frac{1}{2} \approx \sqrt{2} N \\
\end{align*}
$$

Note that $i$ is incremented $\color{mediumorchid}{\text{after}}$ $s$ is updated, so that when the loop condition is checked, the value of $s$ is the sum of the first $i - 1$ integers. From the calculation above, we conclude that the fragment's time complexity is in $\mathcal{O}(N)$.

<br/>