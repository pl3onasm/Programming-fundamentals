$\huge\color{cadetblue}{\text{Problem 3}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 3.1: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int i = 0, j = N;
while (i < j) {
  i++;
  j /= 2;
}
```

The variable $i$ is incremented by $1$ and the variable $j$ is divided by $2$ in each iteration. The loop terminates when $i \geq j$, and so the total number of iterations is less than $\log(N)$. The fragment's time complexity is therefore in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.2: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int i, j, s = 0;
for (i = 0; i < N; i++) {
  for (j = i; j < N - i; j++) {
    s += i + j;
  }
}
```

The outer loop runs $N$ times, whereas the inner loop runs $N - 2i$ times, where $i$ ranges from $0$ to $N - 1$. However, for a correct computation of the total number of iterations, we also need to take into account that both the lower and upper bound of the inner loop depend on $i$. That is, the lower bound increases by $i$, while at the same time the upper bound decreases by $i$ for each iteration of the outer loop. So after $i = \frac{N}{2}$, there are no more iterations. Thus, the total number of iterations is given by:

$$
\begin{align*}
  & \quad \sum_{i=0}^{N/2} (N - 2i) \\
  =& \quad \sum_{i=0}^{N/2} N - \sum_{i=0}^{N/2} 2i \\
  =& \quad (\frac{N}{2} + 1) \cdot N - 2\sum_{i=0}^{N/2} i \\
  =& \quad \frac{N^2}{2} + N - 2\frac{\frac{N}{2}(\frac{N}{2} + 1)}{2} &\color{peru}{(1)}\\
  =& \quad \frac{N^2}{2} + N - \frac{N^2}{4} - \frac{N}{2} \\
  =& \quad \frac{N^2}{4} + \frac{N}{2} \\
  =& \quad \mathcal{O}(N^2)
\end{align*}
$$

In $\color{peru}{(1)}$, we used Gauss' formula to compute the sum of the first $\frac{N}{2}$ positive integers. Also note that just like in the code fragments, the division always is integer division, so that e.g. $N/2 = \lfloor N/2 \rfloor$.  
From the calculations above, we conclude that the fragment's time complexity is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.3: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt N)}}}$  

<br/>

```c
int i = 0, j = 0;
while (i < N) {
  i += 2*j + 1;
  j++;
}
```

The variable $j$ keeps track of the number of iterations. Use is made of Gauss' formula for the sum of the first $j$ integers, but modified such that $i$ is the exact square of $j$: so we have $i = j^2$, and not $i = j(j+1)/2$, at the end of each loop iteration. The loop terminates when $i \geq N$, so we have $j \geq \sqrt{N}$. The fragment's time complexity is therefore in $\mathcal{O}(\sqrt{N})\space$.  

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.4: }}{\color{darkseagreen}{{\space \mathcal{O}(\log (N))}}}$  

<br/>

```c
int i = 1, j = N;
while (i < j) {
  i += i;
  j--;
}
```

The variable $i$ is doubled and the variable $j$ is decremented by $1$ in each iteration. The loop terminates when $i \geq j$. The total number of iterations is therefore less than $\log(N)$, and so the fragment's time complexity is in $\mathcal{O}(\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int i, j, s = 0;
for (i = 1; i < N; i *= 3) {
  for (j = 1; j < i; j++) {
    s += j;
  }
}
```

The outer loop runs $\log_3(N)$ times, since $i$ is multiplied by 3 at the end of each iteration. The inner loop runs $i - 1$ times, where $i$ ranges from $1$ to $N - 1$ in steps of factor 3. The total number of iterations is therefore given by:

$$
\begin{align*}
&\quad \sum_{i=1}^{\lfloor\log_3(N)\rfloor} (3^i - 1) \\
=&\quad \sum_{i=0}^{\lfloor\log_3(N)\rfloor} (3^i) - 1 - \sum_{i=1}^{\lfloor\log_3(N)\rfloor} 1 &\color{peru}{(1)} \\
=&\quad \frac{3^{\lfloor\log_3(N)\rfloor + 1} - 1}{3 - 1} - 1 - \lfloor\log_3(N)\rfloor &\color{darkkhaki}{(2)} \\
\leq &\quad\frac{3^{\log_3(N) + 1} - 1}{3 - 1} - 1 - \log_3(N) \\
=&\quad \frac{3N - 1}{2} - 1 - \log_3(N) \\
=&\quad \mathcal{O}(N)
\end{align*}
$$

In $\color{peru}{(1)}$ we rewrite the first sum, so that the index $i$ starts at $0$ instead of $1$. This allows us to use the formula for the sum of a geometric series in $\color{darkkhaki}{(2)}$, which is:

$$
\sum_{k=0}^n a^k = \frac{a^{n+1} - 1}{a - 1} \quad \text{for} \quad a \neq 1
$$

Thus, the fragment's time complexity is in $\mathcal{O}(N)$.

Note that we could have run an argument for a complexity in $\mathcal{O}(N \log(N))$ by stating that the outer loop runs in logarithmic time and the inner loop runs $\color{orchid}{\text{at most}}$ $N$ times (or $N$ times in the worst case), so that the nested loop's total complexity becomes linearithmic in $N$. This is not wrong, but an overestimate, as the tightest bound is in $\mathcal{O}(N)$. It is testomony to the fact that rough reasoning does not always yield the tightest bound. The same situation arises in e.g. [Ex5 2018 resit](https://github.com/pl3onasm/Imperative-programming/blob/main/IP-Finals/2018resit/problem2.md#ex5-colorrosybrownmathcalonlogn), and [Ex2 2017 resit](https://github.com/pl3onasm/Imperative-programming/blob/main/IP-Finals/2017resit/problem2.md#ex1-colorrosybrownmathcalon).

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 3.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int i, j, s = 0, t = 0;
for (i = 1; i < N; i++) {
  s += i;
  for (j = 1; j < s; j *= 2) {
    t += j;
  }
}
```

The outer loop runs $N - 1$ times. The variable $s$ takes the running sum of the first $i$ integers, so $s = i(i+1)/2$ $\approx i^2/2$ before the inner loop starts. The inner loop runs $\log(s) \approx \log(i^2/2) = 2\log(i) -1$  times. The total number of iterations is therefore given by:

$$
\begin{align*}
&\quad\sum_{i=1}^{N-1} (2\log(i) - 1) \\
= &\quad 2\sum_{i=1}^{N-1} \log(i) - \sum_{i=1}^{N-1} 1 \\
=&\quad 2\log\left(\prod_{i=1}^{N-1} i\right) - (N-1) \\
=&\quad 2\log((N-1)!) - (N-1) \\
< &\quad 2\log(N!) \\
=&\quad \mathcal{O}(N \log(N)) \\
\end{align*}
$$

The fragment's time complexity is therefore in $\mathcal{O}(N \log(N))$.

<br/>