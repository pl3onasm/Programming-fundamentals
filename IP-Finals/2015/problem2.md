$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N) {
  s += i;
  i++;
}
```

The loop terminates when $s \geq N$, that is, when:

$$
\begin{align*}
&1 + 2 + \cdots + (i-1) \geq N \\
\Leftrightarrow \quad &\frac{i(i-1)}{2} \geq N \\
\Leftrightarrow \quad &i^2 - i \geq 2 N \\
\Leftrightarrow \quad &i^2 - i + \frac{1}{4} \geq 2 N + \frac{1}{4} \\
\Leftrightarrow \quad &(i - \frac{1}{2})^2 \geq 2 N + \frac{1}{4} \\
\Leftrightarrow \quad &i - \frac{1}{2} \geq \sqrt{2 N + \frac{1}{4}} \\
\Leftrightarrow \quad &i \geq \sqrt{2 N + \frac{1}{4}} + \frac{1}{2} \approx \sqrt{2 N}\\
\end{align*}
$$

Note that $i$ is incremented $\color{mediumorchid}{\text{after}}$ $s$ is updated, so that when the loop condition is checked, the value of $s$ is the sum of the first $i - 1$ integers. From the calculation above, we conclude that the fragment's time complexity is in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int i, j, s = 0;
for (i = 0; i < N; i++) {
  for (j = N; j > i; j--) {
    s += j;
  }
}
```

The inner loop is executed $N - i$ times for each value of $i$, so that the total number of times the body of the inner loop is executed is:

$$\begin{align*}
\sum_{i=0}^{N-1} (N-i) &= \sum_{i=0}^{N-1} N - \sum_{i=0}^{N-1} i \\
&= N^2 - \sum_{i=0}^{N-1} i\\
&= N^2 - \frac{N(N-1)}{2} &\color{peru}{(1)}\\
&= \frac{N(N+1)}{2}
\end{align*}
$$

In $\color{peru}{(1)}$, we used Gauss' formula to compute the sum of the first $N - 1$ positive integers. From the above, we conclude that the overall time complexity is in $\mathcal{O}(N^2)$.

Another, more intuitive way to reach the same conclusion is to note that the outer loop is executed $N$ times, whereas the inner loop is executed $\color{orchid}{\text{at most}}$  $N$ times, so that the nested loop's complexity becomes quadratic in $N$. However, these types of arguments do not always yield the tightest bound, and so it is better to stick to the more formal approach whenever the upper or lower bound of the inner loop depends on the outer loop's index. A case in point is [ex5 from 2013](https://github.com/pl3onasm/Imperative-programming/blob/main/IP-Finals/2013/problem3.md#ex5-colorrosybrownmathcalon), where you would expect from an intuitive argument that the complexity is in $\mathcal{O}(N \log(N))$, which is not wrong, but not tight either, as the tight bound is $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int i = 0, j = N, s = 0;
while (j - i > 1) {
  int k = (i + j)/2;
  if (i % 2 == 0) {
    i = k;
  } else {
    j = k;
  }
  s++;
}
```

The fragment is a binary search algorithm. The indices $i$ and $j$ indicate the range of the search, and each iteration of the loop reduces the size of the search range by half. The loop terminates when the two indices are adjacent, that is, when $j - i = 1$. The number of iterations is therefore given by the number of times $N$ can be divided by $2$ before reaching $1$, which is $\log(N)$. Thus, the fragment's time complexity is in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int i, j = 0, s = 0;
for (i = 0; i < N; i++) {
  j += i;
}
while (j > 0) {
  s += j;
  j--;
}
```

The first loop computes $j = N(N-1)/2$ in $N$ steps. After that, the second loop is executed $j$ times. The loops are not nested, which means that the most expensive one, the second loop, determines the overall complexity. Thus, the fragment's time complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 0, s = 1;
for (i = 0; i < N; i += 2) {
  s = 2*s;
}
```

The loop is executed $N/2$ times, so that the fragment's time complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int i, j, s = 0;
for (i = 0; i < N; i++) {
  for (j = i*i; j > 0; j = j/2) {
    s++;
  }
}
```

The inner loop is executed $\log(i^2) = 2\log(i)$ times for each value of $i$ ranging from $1$ to $N-1$, so that the total number of iterations is given by:

$$\begin{align*}
\sum_{i=1}^{N-1} 2\log(i) &= 2\sum_{i=1}^{N-1} \log(i) \\
&= 2\log\left(\prod_{i=1}^{N-1} i\right) \\
&= 2\log\left((N-1)!\right) \\
&< 2\log(N!) \\
&= \mathcal{O}(N \log(N)) \\
\end{align*}
$$

Thus, the fragment's time complexity is in $\mathcal{O}(N \log(N))$.

<br/>