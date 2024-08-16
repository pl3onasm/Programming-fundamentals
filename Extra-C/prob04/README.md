$\huge\color{cadetblue}{\text{Binary Palindromes}}$

<br/>

A palindrome is a symmetrical string, that is, a string that reads identically from left to right as well as from right to left. Thus, `abcba` is a palindrome, but `abab` is not. In this problem we consider binary palindromes, which are binary strings (sequences of 0s and 1s) that are palindromes. For instance, the following strings are binary palindromes: 101, 11011, 100001.

Given are two non-negative decimal integers $a$ and $b$ ($0 \leq a \leq b < 2147483647$). You have to find all binary palindromes $p$ such that $a \leq p \leq b$ and $p$ has an odd number of 1s. Your program should output these palindromes in ascending order, one per line. Each palindrome should be preceded by its decimal value, a colon and a space. If there are no binary palindromes in the specified interval, your program should output a single line containing the single integer 0. The intervals are chosen such that the output does not exceed 1200 lines.

<br/>

$\Large\color{darkseagreen}{\text{Example}}$

Input:

```text
0 50
```

Output:

```text
1: 1
7: 111
21: 10101
31: 11111
```
