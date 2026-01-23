$\huge\color{cadetblue}{\text{Problem 1}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 1.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i += 3) {
  for (int j = 3 * N; j > 0; j /= 2) {
    s += i * j;
  }
}
```

The outer loop runs $N/3$ times, as it increments $i$ by $3$ until it reaches $N$. The inner loop runs $\log(3N)$ times for each value of $i$, since $j$ starts at $3N$ and is divided by $2$ at each iteration. Therefore, the total number of iterations of the inner loop can be computed as follows:

&nbsp; $\sum_{i=0}^{N/3} \space \log(3N)$  

&nbsp; $\quad = (N/3) \cdot \log(3N)$  

&nbsp; $\quad = (N/3) \cdot \left( \log(N) + \log(3) \right)$

&nbsp; $\quad = \mathcal{O}(N \log(N))$  

Thus, the fragment's complexity is in $\mathcal{O}(N \log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.2: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int s = 0;
for (int i = 1; i < N * N; i *= 3)
  s += i * i;
```

The loop variable $i$ is multiplied by $3$ at each iteration, starting from $1$ and continuing until it reaches $N^2$. Therefore, the number of iterations is given by the smallest integer $k$ such that $3^k \geq N^2$. Taking the logarithm base $3$ of both sides, we find that $k \geq 2 \log_3(N)$. Since the inner operation is a constant-time operation, the overall complexity of the fragment is in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.3: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

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

The first loop runs until the sum of the first $i$ integers is at least $N$. The sum of the first $i$ integers is given by the formula $i \cdot (i + 1) / 2$. Therefore, we need to find the smallest integer $i$ such that $i \cdot (i + 1) / 2 \geq N$. Solving for $i$, we find that $i$ is approximately $\sqrt{2N}$. Thus, the first loop runs in $\mathcal{O}(\sqrt{N})$ time.

The second loop simply decrements $i$ from its final value back down to $0$, which also takes $\mathcal{O}(\sqrt{N})$ time. Since both loops run sequentially, the overall complexity of the fragment equals the sum of their complexities, which is $\mathcal{O}(\sqrt{N}) + \mathcal{O}(\sqrt{N}) = \mathcal{O}(\sqrt{N})$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.4: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i++) {
  for (int j = 0; j < 5 * i; j += 2) {
    s += i + j;
  }
}
```

The outer loop runs $N$ times, as it increments $i$ by $1$ until it reaches $N$. The inner loop runs approximately $5 \cdot i / 2$ times for each value of $i$, since $j$ starts at $0$ and is incremented by $2$ until it reaches $5 \cdot i$. Therefore, the total number of iterations of the inner loop can be computed as follows:

&nbsp; $\sum_{i=0}^{N} \space (5 \cdot i / 2)$

&nbsp; $\quad = (5/2) \cdot \sum_{i=0}^{N} i$

&nbsp; $\quad = (5/2) \cdot (N \cdot (N + 1) / 2)$

&nbsp; $\quad = (5/4) \cdot (N^2 + N)$

&nbsp; $\quad = \mathcal{O}(N^2)$

Thus, the fragment's complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log(N))}}}$  

<br/>

```c
int s = 0;
for (int i = N; i > 0; i--) {
  int d = 2 + i % 5;
  for (int j = 1; j < N; j *= d) {
    s += j * s;
  }
}
```

The outer loop runs $N$ times, as it decrements $i$ by $1$ until it reaches $0$. The inner loop runs $\log_d(N)$ times for each value of $i$, where $d$ is determined by the expression $2 + i \% 5$. Since $d$ can take on values from $2$ to $6$, we can consider the worst-case scenario where $d$ is at its minimum value of $2$. Therefore, the inner loop runs $\log(N)$ times for each value of $i$. Since the loops are nested, the fragment's complexity is the product of the complexities of the two loops, which is $\mathcal{O}(N) \cdot \mathcal{O}(\log(N)) = \mathcal{O}(N \log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N * N) {
  s += i;
  i++;
}
```

The variable $s$ accumulates the sum of the first $i$ integers, which is given by the formula $i \cdot (i + 1) / 2$. The loop continues until this sum is at least $N^2$. Therefore, we need to find the smallest integer $i$ such that $i \cdot (i + 1) / 2 \geq N^2$. Solving for $i$, we find that $i$ is approximately $\sqrt{2} \cdot N$. Thus, the fragment's complexity is in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.7: }}{\color{darkseagreen}{{\space \mathcal{O}(\log(N))}}}$  

<br/>

```c
int a = 0, b = N * N;
while (b - a > 1) {
  int c = (a + b) / 2;
  a = (c * c > N ? a : c);
  b = (c * c > N ? c : b);
}
```

This code fragment implements a binary search algorithm to find the largest integer $c$ such that $c^2 \leq N$, which is equivalent to finding the integer part of the square root of $N$. The variables $a$ and $b$ represent the lower and upper bounds of the search space, respectively. Initially, $a$ is set to $0$ and $b$ is set to $N^2$. At each iteration of the while loop, the midpoint $c$ is calculated as the average of $a$ and $b$. If $c^2$ is greater than $N$, then the upper bound $b$ is updated to $c$. Otherwise, the lower bound $a$ is updated to $c$. This process continues until the difference between $b$ and $a$ is less than or equal to $1$. At each iteration, the search space is halved, leading to a logarithmic number of iterations. Therefore, the fragment's complexity is in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.8: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 1; i < N; i++) {
  for (int j = 0; j < i; j += 10) {
    for (int k = 0; k < 10; k++) {
      s += i + j + k;
    }
  }
}
```

The outer loop runs $N$ times, as it increments $i$ by $1$ until it reaches $N$. The middle loop runs approximately $i / 10$ times for each value of $i$, since $j$ starts at $0$ and is incremented by $10$ until it reaches $i$. The innermost loop runs a constant $10$ times for each iteration of the middle loop. Therefore, the total number of iterations of the innermost loop can be computed as follows:

&nbsp; $\sum_{i=1}^{N} \space (i / 10) \cdot 10 $

&nbsp; $\quad = \sum_{i=1}^{N} i $

&nbsp; $\quad = N \cdot (N + 1) / 2 $

&nbsp; $\quad = \mathcal{O}(N^2)$

Thus, the fragment's complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.9: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
int s = 0;
for (int i = 1; i < N; i++) {
  if (i * i > N) {
    break;
  }
  s += i;
}
```

The loop iterates over the values of $i$ starting from $1$ and breaks as soon as the condition $i^2 > N$ is met, overriding the loop's upper limit of $N$. Therefore, the loop will run for all integer values of $i$ from $1$ to $\lfloor \sqrt{N} \rfloor$. Since the operation inside the loop (updating $s$) is a constant-time operation, the overall complexity of the fragment is in $\mathcal{O}(\sqrt{N})$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.10: }}{\color{darkseagreen}{{\space \mathcal{O}(\log(N))}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i += i) {
  s += i * i;
}
```

The loop variable $i$ is initialized to $0$ and is doubled at each iteration (since $i += i$ is equivalent to $i = i + i$). However, since $i$ starts at $0$, the update keeps $i$ at $0$ for all iterations. This means the loop runs forever, since the condition $i < N$ remains true for all iteratioins (because it is given that $N$ is a positive integer).

Arguably, this is a mistake in the exam and the intention was to start $i$ at $1$. Then the loop would double $i$ at each iteration until it reaches or exceeds $N$. Therefore, the number of iterations is given by the smallest integer $k$ such that $2^k \geq N$. Taking the logarithm base $2$ of both sides, we find that $k \geq \log_2(N)$. Since the inner operation is a constant-time operation, the overall intended complexity of the fragment is in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.11: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0, j = 1;
for (int i = 1; i <= N; i++) {
  while (j * j <= i) {
    j++;
  }
}
```

The outer loop runs $N$ times, as it increments $i$ by $1$ until it reaches $N$. The inner while loop increments $j$ as long as $j^2$ is less than or equal to $i$. However, note that $j$ is not reset for each iteration of the outer loop: it continues from its last value. Therefore, over the course of the entire execution of the outer loop, $j$ will be incremented from $1$ to approximately $\sqrt{N}$, since the largest value of $i$ is $N$. Thus, the total number of increments of $j$ across all iterations of the outer loop is in $\mathcal{O}(\sqrt{N})$.

Since the outer loop already performs $\mathcal{O}(N)$ iterations, the total work is $\mathcal{O}(N) + \mathcal{O}(\sqrt{N}) = \mathcal{O}(N)$. Therefore, the overall complexity of the fragment is in $\mathcal{O}(N)$.

Note: If $j$ were reset to $1$ at the start of each iteration of the outer loop, the inner loop would run in $\mathcal{O}(\sqrt{i})$ time for **each value** of $i$, leading to a total complexity of $\mathcal{O}(N) \cdot \mathcal{O}(\sqrt{N}) = \mathcal{O}(N^{\frac{3}{2}})$. However, since $j$ is not reset, the complexity is only in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 1.12: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
int s = 0, j = N;
for (int i = 1; j > 0; i++) {
  j -= i;
  s += j;
}
```

The loop continues as long as $j$ is greater than $0$. In each iteration, $j$ is decremented by the current value of $i$, which starts at $1$ and increments by $1$ in each iteration. The sum of the first $k$ integers is given by the formula $k \cdot (k + 1) / 2$. Therefore, we need to find the smallest integer $k$ such that $k \cdot (k + 1) / 2 \geq N$. Solving for $k$, we find that $k$ is approximately $\sqrt{2N}$. Thus, the fragment's complexity is in $\mathcal{O}(\sqrt{N})$.

<br/>
