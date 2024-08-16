$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0;
for (int i = N; i > 0; i /= 2) {
  for (int j = i; j > 0; j--) {
    s += i*i;
  }
}
```

The outer loop runs $\log(N)$ times, since $i$ starts at $N$ and is then halved after each iteration. The inner loop runs $i$ times for each value of $i$, which is $N/2^k$ for $k \in \lbrace 0, 1, \dots, \lceil \log(N) \rceil \rbrace$. The total number of iterations of the inner loop is therefore given by:

$$
\begin{align*}
& \quad \sum_{k=0}^{\lceil \log(N) \rceil} \frac{N}{2^k} \\
= & \quad N \sum_{k=0}^{\lceil \log(N) \rceil} \frac{1}{2^k} \\
= & \quad N \left( \frac{\frac{1}{2^{\lceil \log(N) \rceil + 1}} -1}{\frac{1}{2} - 1} \right) &\color{peru}{(1)} \\
= & \quad N \left(1 - \frac{1}{2^{\lceil \log(N) \rceil}} \right) \\
= & \quad \mathcal{O}(N)
\end{align*}
$$

In $\color{peru}{(1)}$ we use the formula for the sum of a geometric series, with $a = 1/2$ and $n = \lceil \log(N) \rceil$:

$$
\sum_{k=0}^n a^k = \frac{a^{n+1} - 1}{a - 1} \quad \text{for} \quad a \neq 1
$$

From the above, we therefore have that the fragment's time complexity is in $\mathcal{O}(N)$.

Note that we could have run an argument for a complexity in $\mathcal{O}(N \log(N))$ by stating that the outer loop runs in logarithmic time and the inner loop runs $\color{orchid}{\text{at most}}$ $N$ times (or $N$ times in the worst case), so that the nested loop's total complexity becomes linearithmic in $N$. This is not wrong, but an overestimate, as the tight bound is $\mathcal{O}(N)$. It is testomony to the fact that rough reasoning does not always yield the tightest bound. The same situation arises in [Ex5 2013](https://github.com/pl3onasm/Imperative-programming/blob/main/IP-Finals/2013/problem3.md#ex5-colorrosybrownmathcalon), and [Ex5 2018 resit](https://github.com/pl3onasm/Imperative-programming/blob/main/IP-Finals/2018resit/problem2.md#ex5-colorrosybrownmathcalon).

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int s = 0;
for (int i = N; i > 0; i--) {
  for (int j = i; j > 0; j /= 2) {
    s += i*i;
  }
}
```

The fragment is similar to the previous one, but the loops are nested in the opposite order. The outer loop runs $N$ times, and the inner loop runs $\log(i)$ times for each value of $i$. The total number of iterations of the inner loop is therefore given by:

$$
\begin{align*}
\sum_{i=N}^1 \log(i)\quad 
= & \quad \sum_{i=1}^N \log(i) \\
= & \quad \log \left( \prod_{i=1}^N i \right) \\
= & \quad \log(N!) \\
= & \quad \mathcal{O}(N\log(N))
\end{align*}
$$

Therefore, the fragment's time complexity is in $\mathcal{O}(N\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = N; i > 0; i--) {
  for (int j = i; j > 0; j -= 2) {
    s += i*i;
  }
}
```

The outer loop runs $N$ times, and the inner loop runs $i/2$ times for each value of $i$. The total number of iterations of the inner loop is therefore given by:

$$
\begin{align*}
 \sum_{i=N}^1 \frac{i}{2}\quad
= & \quad \frac{1}{2} \sum_{i=1}^N i \\
= & \quad \frac{1}{2} \cdot \frac{N(N+1)}{2} \\
= & \quad \mathcal{O}(N^2)
\end{align*}
$$

Therefore, the fragment's time complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N/i; i++) {
  s += i;
}
```

The loop condition is $i < N/i$, which is equivalent to $i^2 < N \Leftrightarrow i < \lfloor \sqrt{N} \rfloor$. Therefore, the loop runs about $\sqrt{N}$ times, and the fragment's time complexity is in $\mathcal{O}(\sqrt{N})\space$.  
To be fair, though, the program fragment will actually result in undefined behavior as the initial value of the loop condition is undefined, with $i$ being initialized to 0.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int s = 0, i = N;
while (i >= 0) {
  int d = 1 + i % 5;
  s += d;
  i = (i % d == 0 ? i - 1 : i/d);
}
```

The variable $i$ is initialized to $N$, and is either decremented by $1$ or divided by $d$ in each iteration. The value of $d$ is always between $1$ and $5$. Only when $i$ is evenly divisible by $d$ is it decremented by $1$, otherwise it is integer divided by $d$. This means that each iteration has a one in five chance that $i$ is decremented by $1$, and a four in five chance that $i$ is divided by $d$. Clearly, the division is the dominant operation. The fragment's time complexity is therefore in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int j = 0, s = 0;
for (i = 1; i < N; i *= 2) {
  while (j < i) {
    s += (i + j);
    j++;
  }
}
```

The outer loop runs $\log(N)$ times, since $i$ is doubled after each iteration. This means that $i$ will always be a power of two. For each iteration of the outer loop, the inner one makes $j$ catch up to the current value of $i$. This is because $j$ is not reset to 0, but its end value from the previous iteration (a power of two preceding the current power of two held by $i$) is instead incremented until it equals $i$ again. This means that the inner loop runs $i - j$ times for each value of $i$. The total number of iterations of the inner loop is therefore given by:

$$
\begin{align*}
& \quad \sum_{k=1}^{\lceil \log(N) \rceil} (2^k - 2^{k-1}) \\
= & \quad \sum_{k=1}^{\lceil \log(N) \rceil} 2^{k-1} \\
= & \quad \sum_{k=0}^{\lceil \log(N) \rceil - 1} 2^k &\color{peru}{(1)}\\
= & \quad 2^{\lceil \log(N) \rceil} - 1 &\color{darkkhaki}{(2)}\\
\leq & \quad 2^{\log(N) + 1} - 1 \\
= & \quad 2N - 1 \\
= & \quad \mathcal{O}(N)
\end{align*}
$$

In $\color{peru}{(1)}$ we rewrite the sum, so that the index $k$ starts at $0$ instead of $1$. This allows us to use the formula for the sum of a geometric series in $\color{darkkhaki}{(2)}$, with $a = 2$ and $n = \lceil \log(N) \rceil - 1$:

$$
\sum_{k=0}^n a^k = \frac{a^{n+1} - 1}{a - 1} \quad \text{for} \quad a \neq 1
$$

From the above, we therefore have that the fragment's time complexity is in $\mathcal{O}(N)$.

<br/>