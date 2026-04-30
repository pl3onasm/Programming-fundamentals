$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N\log{(N)})}}}$  

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

The outer loop runs $N$ times. The inner loop runs $\log_k{N}$ times, where $k$ is a constant in the interval $[2,7)$, meaning that it runs $\log_2{N}$ times in the worst case and $\log_6{N}$ times in the best case. Since the loops are nested, the fragment's overall time complexity is in $\mathcal{O}(N\log{N})$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int i = 0, j = 0, s = 0;
while (i*j < 2*N) {
  i = i + 1;
  j = j + 2;
  s = s + i + j;
}
```

In each iteration the variable $i$ is incremented by $1$ and the variable $j$ is incremented by $2$. The loop terminates when $i \cdot j \geq 2 N$ $\Leftrightarrow (i \cdot j)/2 \geq N$. Since we have $j  = 2 i$ at the end of each iteration, the satisfied loop condition becomes $i^2 \geq N \Leftrightarrow i \geq \sqrt{N}$. Hence, the fragment's overall time complexity is in $\mathcal{O}(\sqrt{N})\space$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0, i = 0;
while (s < N*N) {
  s = s + i;
  i++;
}
```

The loop terminates when $s \geq N^2$. Since $s$ is incremented by $i$ in each iteration, we have $s = i (i-1)/2$ by Gauss' formula. Note that $i$ is incremented $\color{mediumorchid}{\text{after}}$ $s$ is updated, so that when the loop condition is checked, the value of $s$ equals the sum of the first $i - 1$ positive integers. Hence, the loop terminates when:

$$
\begin{align*}
&\frac{i (i-1)}{2} \geq N^2 \\
\Leftrightarrow \quad &i^2 - i \geq 2 N^2 \\
\Leftrightarrow \quad &i^2 - i + \frac{1}{4} \geq 2 N^2 + \frac{1}{4} \\
\Leftrightarrow \quad &(i - \frac{1}{2})^2 \geq 2 N^2 + \frac{1}{4} \\
\Leftrightarrow \quad &i - \frac{1}{2} \geq \sqrt{2 N^2 + \frac{1}{4}} \\
\Leftrightarrow \quad &i \geq \sqrt{2 N^2 + \frac{1}{4}} + \frac{1}{2} \approx \sqrt{2} N
\end{align*}
$$

Therefore, the fragment's overall time complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(\log(N))}}}$  

<br/>

```c
int i = 1, s = 0;
while (s < N) {
  s = s + i;
  i += i + i % 2;
}
```

The loop terminates when $s \geq N$. The variable $s$ keeps the running sum of all consecutive values of $i$, which in turn is doubled and incremented by $1$ in each iteration, because $i$ remains odd at all times. This means that $s$ reaches $N$ in a little less than $\log{N}$ iterations. Hence, the fragment's overall time complexity is in $\mathcal{O}(\log{N})$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int i = 1, s = 0;
while (i < N*N) {
  i = 2*i;
}
while (i > 0) {
  s += i;
  i--;
}
```

By the end of the first loop, $i$ is the smallest power of $2$ that is greater than or equal to $N^2$. Since $i$ is doubled in each iteration, the first loop runs $\log(N^2) = 2\log{N}$ times. The second loop, on the other hand, runs $i$ times, which is in $\mathcal{O}(N^2)$. Since the loops are not nested, the fragment's overall time complexity is determined by the most complex loop, and is therefore in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 1, s = 0;
while (i*i < N) {
  i = 2*i;
}
while (i > 0) {
  for (int j = 0; j < i; j++) {
    s += i + j;
  }
  i--;
}
```

The first loop computes $i \approx \sqrt{N}$ in $\log{(\sqrt{N})} = (1/2)\log{(N)}$ steps. The second part of the fragment has an outer loop that runs $\sqrt{N}$ times and an inner loop that runs $i$ times for each consecutive value of $i$. The total number of iterations of the second loop is therefore:

$$
\begin{align*}
\sum_{i=1}^{\sqrt{N}} i &= \frac{\sqrt{N}(\sqrt{N}+1)}{2} \\
&= \frac{N + \sqrt{N}}{2}\\
&= \mathcal{O}(N)
\end{align*}
$$

Clearly, the second, nested loop is the most expensive and determines the overall time complexity of the fragment, which is in $\mathcal{O}(N)$.

<br/>