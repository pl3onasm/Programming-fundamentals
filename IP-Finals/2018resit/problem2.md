$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(\log{(N)})}}}$  

<br/>

```c
int i = N, s = 0;
while (i > 1) {
  i = i/2;
  s += i;
}
```

The variable $i$ is halved in each loop iteration, so that after $k$ iterations $i = N/2^k$. The loop terminates when $i \leq 1$, which happens when $k \geq \log(N)$. The loop therefore runs in $\mathcal{O}(\log(N))$ time.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i += 10) {
  s += i;
}
```

Since the loop variable $i$ is incremented by 10 in each iteration, the loop runs $N/10$ times. The fragment's time complexity is therefore in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N) {
  i++;
  s = s + i;
}
```

The variable $s$ is incremented by $i$ in each iteration, while $i$ just counts the number of iterations. After $i$ iterations, $s = i(i+1)/2$ by Gauss' formula. The loop terminates when:

$$
\begin{align*}
& s \geq N \\
\Leftrightarrow \quad & \frac{i(i+1)}{2} \geq N \\
\Leftrightarrow \quad &  i^2 + i \geq 2N \\
\Leftrightarrow \quad & i^2 + i + \frac{1}{4} \geq 2N + \frac{1}{4} \\
\Leftrightarrow \quad & \left(i + \frac{1}{2}\right)^2 \geq 2N + \frac{1}{4} \\
\Leftrightarrow \quad & i + \frac{1}{2} \geq \sqrt{2N + \frac{1}{4}} \\
\Leftrightarrow \quad & i \geq \sqrt{2N + \frac{1}{4}} - \frac{1}{2} \approx \sqrt{2N}
\end{align*}
$$

The overall number of iterations is therefore in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0, k = N;
while (k > 0) {
  for (int i = k; i > 0; i--) {
    s += i;
  }
  k--;
}
```

The outer loop runs $N$ times: $k$ is initialized to $N$, decremented by $1$ in each iteration, and the loop terminates when $k = 0$. The inner loop runs $k$ times for each updated value of $k$, so that the fragment's total number of iterations is given by:

$$
\begin{align*}
\sum_{k=N}^1 k &= \sum_{k=1}^N k \\
&= \frac{N(N+1)}{2}
\end{align*}
$$

The fragment's time complexity is therefore in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int j = 0, s = 1;
while (s < N) {
  s = 2*s;
  for (int i = s; i > 0; i--) {
    j = j + i;
  }
}
```

The outer loop runs $\lceil\log(N)\rceil$ times: $s$ is initialized to $1$, updated to the next power of $2$ in each iteration, and the loop terminates when $s \geq N$, that is, when $s = 2^k$ with $k \geq \log(N)$, where $k \in \mathbb{N}$ is the number of iterations.
The inner loop runs $s$ times for each updated value of $s$, so that the total number of iterations is given by:

$$
\begin{align*}
&\quad \sum_{k=1}^{{\lceil\log(N)\rceil}} 2^k \\
=&\quad \sum_{k=0}^{{\lceil\log(N)\rceil}} 2^k - 1 &\color{peru}{(1)}\\
=&\quad 2^{{\lceil\log(N)\rceil} + 1} - 1 - 1 &\color{darkkhaki}{(2)}\\
\leq&\quad  2^{{\log(N)} + 2} - 1 - 1 \\
=&\quad 4N - 2\\
=&\quad \mathcal{O}(N)
\end{align*}
$$

In $\color{peru}{(1)}$ we rewrite the sum, so that the index $k$ starts at $0$ instead of $1$. This allows us to use the formula for the sum of a geometric series in $\color{darkkhaki}{(2)}$, which is:

$$
\sum_{k=0}^n a^k = \frac{a^{n+1} - 1}{a - 1} \quad \text{for} \quad a \neq 1
$$

From the above, we therefore have that the fragment's time complexity is in $\mathcal{O}(N)$.

Note that we could have run an argument for a complexity in $\mathcal{O}(N \log(N))$ by stating that the outer loop runs in logarithmic time and the inner loop runs $\color{orchid}{\text{at most}}$ $N$ times (or $N$ times in the worst case), so that the nested loop's total complexity becomes linearithmic in $N$. This is not wrong, but an overestimate, as the tightest bound is $\mathcal{O}(N)$. It is testomony to the fact that rough reasoning does not always yield the tightest bound. The same situation arises in e.g. [Ex5 2013](https://github.com/pl3onasm/Imperative-programming/blob/main/IP-Finals/2013/problem3.md#ex5-colorrosybrownmathcalon), and [Ex1 2017 resit](https://github.com/pl3onasm/Imperative-programming/blob/main/IP-Finals/2017resit/problem2.md#ex1-colorrosybrownmathcalonlogn).

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int j = 0, s = 1;
while (s < N) {
  s = 2*s;
  for (int i = s; i < N; i++) {
    j = j + i;
  }
}
```

Just like in the previous example, the outer loop runs $\lceil\log(N)\rceil$ times. The inner loop runs $N - s$ times for each updated value of $s$, so that the total number of iterations is given by:

$$
\begin{align*}
&\quad\sum_{k=1}^{{\lceil\log(N)\rceil}} (N - 2^k) \\
=&\quad\sum_{k=1}^{{\lceil\log(N)\rceil}} (N) - \sum_{k=1}^{{\lceil\log(N)\rceil}} (2^k) \\
=&\quad N{\lceil\log(N)\rceil} - \sum_{k=0}^{{\lceil\log(N)\rceil}} (2^k) -1 &\color{peru}{(1)}\\
=&\quad N{\lceil\log(N)\rceil} - (2^{{\lceil\log(N)\rceil} + 1} - 1) - 1 &\color{darkkhaki}{(2)}\\
=&\quad N{\lceil\log(N)\rceil} - 2^{{\lceil\log(N)\rceil} + 1} \\
 \leq&\quad N(\log(N) + 1) - 2^{{\log(N)} + 2} \\
=&\quad N\log(N) - 3N \\
=&\quad \mathcal{O}(N\log(N))
\end{align*}
$$

Just like in the previous exercise, we rewrite the sum in $\color{peru}{(1)}$ so that the index $k$ starts at $0$ instead of $1$. This allows us to use the formula for the sum of a geometric series in $\color{darkkhaki}{(2)}$.

The fragment's time complexity is therefore in $\mathcal{O}(N \log(N))$.

<br/>