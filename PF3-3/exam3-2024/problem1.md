$\huge\color{cadetblue}{\text{Problem 1}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 1.1: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N) {
  i++;
  s += 2*i + 1;
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
& s \geq N \\
\Leftrightarrow \quad  &i^2 + 2i \geq N \\
\Leftrightarrow \quad &i^2 + 2i + 1 \geq N + 1 \\
\Leftrightarrow \quad &(i + 1)^2 \geq N + 1 \\
\Leftrightarrow \quad &i + 1 \geq \sqrt{N + 1} \\
\Leftrightarrow \quad &i \geq \sqrt{N + 1} - 1
\end{align*}
$$

Thus, the number of iterations is $\sqrt{N + 1} - 1$, and the fragment's complexity is in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.2: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i++) {
  for (int j = N - i; j > 0; j--) {
    s += j;
  }
}
```

The inner loop is executed $N - i$ times for each value of $i$. So, the total number of iterations is:

$$\begin{align*}
\sum_{i=0}^{N-1} (N-i) &= \sum_{i=0}^{N-1} N - \sum_{i=0}^{N-1} i \\
&= N^2 - \sum_{i=0}^{N-1} i\\
&= N^2 - \frac{N(N-1)}{2}\\
&= \frac{N(N+1)}{2}
\end{align*}
$$

Hence, the fragment's complexity is in $\mathcal{O}(N^2)$.

Another, more intuitive way to reach the same conclusion is to note that the outer loop is executed $N$ times, whereas the inner loop is executed $\color{orchid}{\text{at most}}$ $N$ times, so that the nested loop's complexity becomes quadratic in $N$. However, these types of arguments do not always yield the tightest bound, and so it is better to stick to the more formal approach whenever the upper or lower bound of the inner loop depends on the outer loop's index. A case in point is [prob 3.5 from 2013](https://github.com/pl3onasm/Imperative-programming/blob/main/IP-Finals/2013/problem3.md), where you would expect from an intuitive argument that the complexity is in $\mathcal{O}(N \log(N))$, which is not wrong, but not tight either, as the tightest bound is actually $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 1, t = 0;
while (s*s < N) {
  s = 2*s;
}
for (int i = 0; i < s; i++) {
  for (int j = 0; j < s; j++) {
    t += i + j;
  }
}
```

The first loop computes $s \approx \sqrt{N}$ in $\log(\sqrt{N}) = 1/2 \log(N)$ steps. The second loop, on the other hand, runs a total number of $s^2 \approx N$ times. Thus, the nested loop dominates the fragment's total complexity, which is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log(N))}}}$  

<br/>

```c
int s = 0;
for (int j = N*N; j > 0; j /= 3) {
  for (int i = 0; i < N; i += 3) {
    s += i + j;
  }
}
```

The inner loop runs $N/3$ times. The number of iterations of the outer loop is given by the number of times $N^2$ can be divided by $3$ before reaching $0$, which is $\log_3(N^2)$. We can rewrite this as:

$$
\begin{align*}
\log_3(N^2) &= \frac{\log(N^2)}{\log(3)} \\
&= \frac{2}{\log(3)}\log(N) \\
&= \mathcal{O}(\log(N))
\end{align*}
$$

The loops are nested, and so the fragment's total time complexity is in $\mathcal{O}(N \log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0, i = N*N, j = 0;
while (i > 0) {
  s += i + j;
  j++;
  i -= j;
}
```

The variable $i$ starts at $N^2$ and is decremented by $j$ at each iteration. The variable $j$ starts at $0$ and is updated to the next integer at each iteration. The loop terminates when $i \leq 0$, which is equivalent to $N^2 - (k(k+1))/2 \leq 0$, where $k\in \mathbb{N}$ is the number of iterations, i.e. the value of $j$ at termination. So we have:

$$
\begin{align*}
& i \leq 0 \\
\Leftrightarrow \quad &N^2 - \frac{k(k+1)}{2} \leq 0 \\
\Leftrightarrow \quad &2N^2 \leq k^2 +k \\
\Leftrightarrow \quad &2N^2 + \frac{1}{4}\leq k^2 + k + \frac{1}{4}\\
\Leftrightarrow \quad &2N^2 + \frac{1}{4} \leq (k + \frac{1}{2})^2 \\
\Leftrightarrow \quad &\sqrt{2N^2 + \frac{1}{4}} \leq k + \frac{1}{2} \\
\Leftrightarrow \quad &k \geq \sqrt{2N^2 + \frac{1}{4}} - \frac{1}{2} \approx \sqrt{2} N
\end{align*}
$$

The fragment's time complexity is therefore in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.6: }}{\color{darkseagreen}{{\space \mathcal{O}(\log(N))}}}$  

<br/>

```c
int s = 0;
for (int i = N*N; i > 0; i /= 2) {
  s = s + i;
}
```

The loop index $i$ is divided by $2$ at each iteration, so that the loop runs $\log(N^2) = 2 \log(N)$ times. The fragment's complexity is therefore in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.7: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0, j = 0;
for (int i = 0; i < N; i++) {
  j += i;
}
while (j > 0) {
  s += j;
  j -= 2;
}
```

The first loop runs $N$ times, computing the sum of the integers from $0$ to $N-1$, so that at termination $j = N(N-1)/2$. The second loop subtracts $2$ from $j$ at each iteration, so that the loop runs $N(N-1)/4$ times. The loops are not nested, and so the fragment's complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.8: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0, j = 0;
for (int i = 0; i < N; i++) {
  j += i;
}
while (j > 0) {
  s += j;
  j /= 2;
}
```

The first loop runs $N$ times, computing the sum of the integers from $0$ to $N-1$, so that at termination $j = N(N-1)/2$. The second loop divides $j$ by $2$ at each iteration, so that the loop runs $\log(N(N-1)/2) = \log(N(N-1)) - \log(2)$ $= \log(N) + \log(N-1) - 1$ times.  
The loops are not nested, and so the most expensive one, the for loop in this case, determines the fragment's overall time complexity, which is thus in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.9: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int s = 0, i = 1;
while (i <= N/i) {
  s++;  
  i++;
}
```

The variable $i$ is incremented by $1$ at each iteration, and the termination condition can be rewritten as $i^2 \leq N$, which is equivalent to $i \leq \sqrt{N}$. Therefore, the fragment's complexity is in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.10: }}{\color{darkseagreen}{{\space \mathcal{O}(\log(N))}}}$  

<br/>

```c
int s = 0, i = N;
while (i > 0) {
  s++;
  i = (i % 2 ? i - 1 : i/2);
}
```

The variable $i$ starts at $N$. In the worst case, we are then halving it half of the time and decrementing it by $1$ the other half of the time. In this case, the loop needs less than $2\log(N)$ iterations to terminate.
The fragment's complexity is therefore in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.11: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log(N))}}}$  

<br/>


```c
int s = 0, i = N;
while (i > 0) {
  i = (i % 2 == 0 ? i/2 : i - 1);
  for (int j = 0; j < 2*N; j += 2) {
    s += i + j;
  }
}
```

The first loop will behave just like the previous exercise, taking less than $2 \log(N)$ iterations to reach $0$. The second loop runs $N$ times, and is nested inside the first loop, so that the fragment's total complexity is in $\mathcal{O}(N \log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.12: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

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

The innermost loop runs $N-j$ times, the middle loop runs $N-i$ times, where $i$ is at most $9$, and the outer loop runs $9$ times. The outer loop merely adds a constant factor to the complexity, and so we can completely ignore it, and set $i$ to $0$ for convenience. With $i$ set to $0$, the middle loop then runs $N$ times, and the innermost loop runs $N-j$ times for each value of $j$, so that we get the exact same number of iterations as in prob 1.2, which is $N(N+1)/2$.

Therefore, the fragment's complexity is in $\mathcal{O}(N^2)$.

<br/>
