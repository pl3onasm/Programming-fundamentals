$\huge\color{cadetblue}{\text{Problem 1}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 1.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i++) {
  for (int j = 0; j < N; j++) {
    s = s + i * j;
  }
}
```

The outer loop runs $N$ times, and for each iteration of the outer loop the inner loop also runs $N$ times. Since the loops are nested, the fragment's complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.2: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int s1 = 0, s2 = 0, p = N;
while (p > 0) {
  s1 += (p % 10) * (1 - p % 2);
  s2 += (p % 10) * (p % 2);
  p /= 10;
}
```

The loop index $p$ is divided by $10$ at each iteration, so that the loop runs $\log_{10}(N)$ times. The operations inside the loop all run in constant time. Thus, the fragment's complexity is in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0, p = 0;
for (int i = 0; i * i < N; i++) {
  for (int j = 0; j * j < N; j++) {
    s++;
  }
}
while (s > 0) {
  p += s;
  s--;
}
```

The outer loop runs $\sqrt{N}$ times, as it terminates when $i^2 \geq N$. Similarly, the inner loop also runs $\sqrt{N}$ times. Since the loops are nested, their combined complexity is in $\mathcal{O}(N)$. The while loop runs $s$ times, where $s$ is equal to the total number of iterations of the nested loops, which is in $\mathcal{O}(N)$. Thus, the fragment's overall complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 3, j = N;
while (i < j) {
  if (N % i == 0) {
    i *= 2;
  }
  j--;
  i++;
}
```

In the worst case scenario, $N$ is prime so that the condition $N \space \% \space i = 0$ is never satisfied. In that case, $j$ is decremented by $1$ and $i$ is incremented by $1$ at each iteration, making the loop run $(N - 3) / 2$ times. Therefore, the fragment's complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.5: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
int i = 1, s = 0;
while (i < N / i) {
  s += i;
  i++;
}
```

The loop will terminate when $i$ is the smallest integer such that $i^2 \geq N$, which is equivalent to $i \geq \sqrt{N}$. Therefore, the loop runs $\sqrt{N}$ times, and the fragment's complexity is in $\mathcal{O}(\sqrt{N})\space$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log(N))}}}$  

<br/>

```c
int s = 0;
for (int i = N; i >= 0; i--) {
  for (int j = i; j > 0; j /= 2) {
    s++;
  }
}
```

The outer loop runs $N+1$ times, while the inner loop runs $\log(i)$ times for each value of $i$ ranging from $N$ down to $1$, as $j$ is divided by $2$ at each iteration. The total number of iterations of the inner loop can therefore be computed as follows:

&nbsp; $\sum_{i=N}^{1} \log(i)$ [^1]

&nbsp; $\quad = \log(N) + \log(N-1) + \ldots + \log(2) + \log(1)$

&nbsp; $\quad = \log(N!)$

&nbsp; $\quad = \mathcal{O}(N \log(N))$

Therefore, the fragment's complexity is in $\mathcal{O}(N \log(N))$.

[^1]: Note that the log of 0 is undefined, so we start the sum from i = N down to 1. This does not affect the overall complexity, because the inner loop does not run when i = 0.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.7: }}{\color{darkseagreen}{{\space \mathcal{O}(\log(N))}}}$  

<br/>

```c
int s = 0, i = 0, j = N;
while (i < j) {
  if (s % 2 == 0) {
    i = 2 * i + 1;
  } else {
    j = j / 2 - 1;
  }
  s++;
}
```

At each loop iteration, either $i$ grows exponentially or $j$ decreases logarithmically, depending on the parity of $s$. The loop terminates when $i \geq j$. Seeing that the distance between $i$ and $j$ equals $N$ at the beginning, and is halved in each iteration, the loop runs $\log(N)$ times. Therefore, the fragment's complexity is in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.8: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
int s = 0, i = 0;
while (s < N) {
  s += i;
  i++;
}
```

At each iteration, $s$ is incremented by $i$, which itself is incremented by $1$. This means that $s$ tracks the sum of the first $i$ integers, which is equal to $i \cdot (i + 1) / 2$. The loop terminates when this sum is greater than or equal to $N$, which happens when $i \cdot (i + 1) / 2 \geq N$. Solving for $i$, we find that the loop runs approximately $\sqrt{2N}$ times. Therefore, the fragment's complexity is in $\mathcal{O}(\sqrt{N})\space$.


<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.9: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int n = 0, d = 0;
while (d < N * N) {
  d = d + 2 * n + 1;
  n++;
}
```

The loop invariant is that at the start of each iteration, $d = n^2$. This is achieved because $d$ is incremented by $2n + 1$ at each iteration, which is the difference between $(n+1)^2$ and $n^2$.

The loop terminates when $d \geq N^2$. Given the invariant, this occurs when $n^2 \geq N^2$, or equivalently when $n \geq N$. Therefore, the loop runs $N$ times, and the fragment's complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.10: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log(N))}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < 2 * N; i += 2) {
  for (int j = i * i; j > 0; j /= 2) {
    s++;
  }
}
```

The outer loop runs $N$ times, as it increments $i$ by $2$ until it reaches $2N$. The inner loop runs $\log(i^2)$ times for each value of $i$ in the range $[0, 2N]$, since $j$ is divided by $2$ at each iteration. The total number of iterations of the inner loop can therefore be computed as follows:

&nbsp; $\sum_{i=1}^{N} \log(i^2) $

&nbsp; $\quad = 2 \cdot \sum_{i=1}^{N} \log(i) $

&nbsp; $\quad = 2 \cdot \log(N!) $

&nbsp; $\quad = \mathcal{O}(N \log(N))$

Therefore, the fragment's complexity is in $\mathcal{O}(N \log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.11: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0, t = 0;
for (int i = 0; i < N; i += 2) {
  s += i;
}
while (s > 0) {
  t += s;
  s -= 2;
}
```

In the for loop, $i$ takes on the even values from $0$ to $N-1$. The sum of the first $k$ even numbers is given by the formula $k(k + 1) / 4$. So, the value of $s$ after the for loop is approximately $N^2 / 4$.

Next, the while loop decrements $s$ by $2$ at each iteration until $s$ reaches $0$. Since $s$ starts at approximately $N^2 / 4$, the while loop will run about $N^2 / 8$ times. Therefore, the fragment's complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.12: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0, t = 0;
for (int i = 0; i < N; i += 2) {
  s += i;
}
while (s > 0) {
  t += s;
  s /= 2;
}
```

The variable $s$ is updated in the same way as in Problem 1.11, so after the for loop, $s$ is approximately $N^2 / 4$. However, in the while loop, $s$ is now halved at each iteration. This means that the while loop will run $\log(N^2 / 4)$ times, which simplifies to $2 \log(N) - 2$. 

The two loops are not nested, so the overall complexity is dominated by the loop with the highest complexity, which is the for loop. Therefore, the fragment's complexity is in $\mathcal{O}(N)$.

<br/>
