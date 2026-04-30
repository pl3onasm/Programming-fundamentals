$\huge\color{cadetblue}{\text{Sum of multiples}}$

<br/>

Given are two positive integers $a$ and $b$. The output of your program should be the sum of all the multiples of $a$ and $b$ below a given positive integer $n \leq 10^{11}$.

For example, if $a = 5$, $b = 7$ and $n = 50$, then the output should be $386$, because the sum of all the multiples of $5$ and $7$ below $50$ is:  
  
  $\quad 5 + 7 + 10 + 14 + 15 + 20 + 21 + 25$  
  $\quad + 28 + 30 + 35 + 40 + 42 + 45 + 49 = 386$
  
For $a = 3$, $b = 2$ and $n = 30$, the output should equal $285$, since the sum of all the multiples of $3$ and $2$ below $30$ is:  
  
  $\quad 2 + 3 + 4 + 6 + 8 + 9 + 10 + 12 + 14$  
  $\quad + 15 + 16 + 18 + 20 + 21 + 22 + 24 $  
  $\quad + 26 + 27 + 28 = 285$
  
The input consists of three positive integers $a$, $b$ and $n$ separated by a space.
The output should be a single positive integer representing the sum of all the multiples of $a$ and $b$ below $n$.

Note that the numbers may become very large. You should use a data type that can handle numbers as large as $10^{19}$.
