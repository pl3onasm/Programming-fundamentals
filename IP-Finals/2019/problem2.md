$\huge\color{cadetblue}{\text{Problem 2}}$

----------------------

$\Large{\color{rosybrown}\text{Prob 2.1: }}{\color{darkseagreen}{{\space \mathcal{O}(\sqrt{N})}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < N; i += s) {
  s++;
}
```

After each iteration, the loop index $i$ is incremented by $s$, which is itself incremented by $1$ in each execution of the loop body. This means that $i$ is first incremented by $1$, then by $2$, then $3$, ..., so that after $k$ iterations $i = k(k+1)/2$. The loop terminates when $i \geq N$, which happens when $k \geq \sqrt{2N + 1/4} - 1/2$. The loop therefore runs in $\mathcal{O}(\sqrt{N})\space$ time.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.2: }}{\color{darkseagreen}{{\space \mathcal{O}(\log(N))}}}$  

<br/>

```c
int s = 0;
for (int i = 1; i < N*N; i *= 2) {
  s = s + i;
}
```

The loop index $i$ is multiplied by 2 at each iteration, so that after $k$ iterations $i = 2^k$. The loop terminates when $i \geq N^2$, which happens when $k \geq \log(N^2) = 2\log(N)$. The loop therefore runs in $\mathcal{O}(\log(N))$ time.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.3: }}{\color{darkseagreen}{{\space \mathcal{O}(N^2)}}}$  

<br/>

```c
int s = 0;
for (int i = 0; i < 2*N; i += 2) {
  for (int j = N; j > 0; j -= 3) {
    s += i + j;
  }
}
```

The outer loop runs $N$ times, and the inner loop runs $N/3$ times. This means that the loop body is executed $N^2/3$ times, so that the total running time is in $\mathcal{O}(N^2)$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.4: }}{\color{darkseagreen}{{\space \mathcal{O}(\log(N))}}}$  

<br/>

```c
int i = 0, s = 0;
while (s < N) {
  s = (i % 2 == 0 ? 2*s : s + 1);
  i++;
}
```

As the parity of $i$ flips each time the loop body is executed, the variable $s$ is doubled half of the time, and incremented by $1$ the other half of the time.  
After $k$ iterations, we have $s = 2^{\lfloor k/2 \rfloor} + \lfloor k/2 \rfloor$. The loop terminates when $s \geq N$, which happens for a value for $k$ that lies between $\log(N)$ and $2\log(N)$. The loop therefore runs in $\mathcal{O}(\log(N))$ time.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.5: }}{\color{darkseagreen}{{\space \mathcal{O}(N \log (N))}}}$  

<br/>

```c
int s = 0;
for (int i = N*N; i > 0; i = i/2) {
  for (int j = 0; j < N; j++) {
    s += i + j;
  }
}
```

The outer loop runs $\log(N^2) = 2\log(N)$ times, and the inner loop runs $N$ times. This means that the inner loop body is executed $2N\log(N)$ times, so that the fragment's overall time complexity is in $\mathcal{O}(N\log(N))$.

<br/>

----------------------

$\Large{\color{rosybrown}\text{Prob 2.6: }}{\color{darkseagreen}{{\space \mathcal{O}(N)}}}$  

<br/>

```c
int k = 0, s = 0;
for (int i = 0; i < N; i += k) {
  k++;
  for (int j = 0; j*j < N; j++) {
    s = s + j;
  }
}
```

The outer loop has an index $i$ which after each iteration is incremented by $k$, which is itself incremented by $1$ in each execution of the loop body. This means that $i$ is first incremented by $1$, then by $2$, then $3$, ..., so that after $k$ iterations $i = k(k+1)/2$. The loop terminates when $i \geq N$, which happens when $k \geq \sqrt{2N + 1/4} - 1/2$, so that $k\approx \sqrt{2N}$.  
The inner loop runs $\sqrt{N}$ times, so that the inner loop body is executed about $\sqrt{2}N$ times, and the fragment's total time complexity is in $\mathcal{O}(N)$.

<br/>