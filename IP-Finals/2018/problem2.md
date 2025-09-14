$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int j = 0, s = 0;
for (int i = N; i > 0; i--) {
  j = j + i;
}
while (j > 5) {
  s = s + j % 7;
  j--;
}
```

The first loop runs $N$ times, computing the sum of the first $N$ integers, so that after the loop has terminated, we have $j = N(N+1)/2$ by Gauss' formula. The second loop iterates a total number of $j - 5$ times. It is quadratic in $N$, since $j$ is decremented by $1$ at each iteration.  
The loops are not nested, so the most expensive one determines the fragment's time complexity, which is therefore in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int i = 1, s = 0;
while (i < N*N) {
  s = s + 3*i;
  i = 2*i;
}
```

The variable $i$ is doubled at each iteration, so that the loop runs $\log(N^2) = 2\log(N)$ times. The fragment's time complexity is therefore in $\mathcal{O}(\log N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int s = 0;
for (int i = 42; i < 7*N; i += 3) {
  s += i;
}
```

The variable $s$ does not affect the complexity of the fragment. The loop runs $(7N - 42)/3$ $= 7/3N - 14$ times. The fragment's time complexity is therefore in $\mathcal{O}(N)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N) {
  s = i*i;
  i++;
}
while (i > 0) {
  s += i;
  i--;
}
```

The first loop ends when $s = i^2 \geq N$, so that $i \geq \sqrt{N}$. In the second loop, $i$ is decremented until it reaches $0$, so that the loop runs $\sqrt{N}$ times. The loops are not nested, so the fragment's time complexity is therefore in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int s = 0;
for (int i = N; i > 0; i = i/2) {
  for (int j = i; j < N; j++) {
    s += i + j;
  }
}
```

The index $i$ is initialized to $N$ and is halved at the end of each iteration of the outer loop, which therefore runs a total number of $\log(N)$ times. The inner loop runs $N - i$ times for each value of $i$, which is $N/2^k$ for the $k$-th iteration of the outer loop, where $k \in \lbrace 1, \dots, \lfloor \log(N) \rfloor \rbrace$.[^1]
The total number of iterations of the inner loop is therefore given by:

$$
\begin{align*}
& \quad \sum_{k=1}^{\lfloor \log(N) \rfloor} \left( N - \frac{N}{2^k} \right) \\
= &\quad \sum_{k=1}^{\lfloor\log(N)\rfloor} N - N\sum_{k=1}^{\lfloor\log(N)\rfloor} \frac{1}{2^k} \\
= &\quad N\lfloor\log(N)\rfloor - N\left( 1 - \frac{1}{2^{\lfloor\log(N)\rfloor}} \right) \\
= &\quad N\lfloor\log(N)\rfloor - N + \frac{N}{2^{\lfloor\log(N)\rfloor}} \\
\leq &\quad N(\log(N)+1) - N + \frac{N}{2^{\log(N)}} \\
= &\quad N\log(N) + \frac{N}{2^{\log(N)}} \\
= &\quad \mathcal{O}(N\log(N))
\end{align*}
$$

From the above, we conclude that the fragment's time complexity is in $\mathcal{O}(N\log(N))$.

[^1]: Note that we let the index k start from 1, since the first iteration of the outer loop does not run the inner loop. This is because the inner loop's condition is j < N, which is not satisfied when i = N. The actual counting of the total number of iterations starts for i = N/2 which corresponds to k = 1. The expression still holds for k = 0, since the summand is 0, but the calculation is a little easier if we start from k = 1.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i, j = 0, s = 0;
for (i = 0; i < N; i++ ) {
  j = j + i;
}
for (i = 0; i*i < j; i++) {
  s = i + j;
}
```

The first loop runs $N$ times, computing the sum of the first $N - 1$ integers, so that in the end $j = N(N-1)/2$ by Gauss' formula. The second loop runs about $\sqrt{j}$ times, which is also linear in $N$. The loops are not nested, so the fragment's time complexity is therefore in $\mathcal{O}(N)$.

<br/>