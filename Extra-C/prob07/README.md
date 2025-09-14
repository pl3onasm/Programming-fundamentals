$\huge\color{cadetblue}{\text{Matching Bitstrings}}$

<br/>

A binary string is a sequence of 0s and 1s. In this problem you are asked to generate all bitstrings under the following constraints:

1. no more than two 0s or 1s are allowed directly next to each other,
2. some positions in the string are prefilled by 0s and 1s which cannot be altered,
3. the other positions are wildcards indicated with an `?` in which you can pick a 0 or 1 as long as the first constraint is met.

An example of such a bitstring that satisfies the first condition is `1100101` as there are no more than two 0s or 1s directly next to each other.  
Now consider the bitstring `0??010`. There are three different options to fill the `?` slots, namely: `001010`, `010010` and `011010`.

Write a program that accepts on the input two lines. The first line is a single integer $n$ indicating the length of the constrained bitstring. The second line provides the bitstring itself. Your program should compute all the possible combinations under the provided constraints and output them in lexicographical ordering (i.e. in increasing binary order).

<br/>

$\Large\color{darkseagreen}{\text{Example}}$

Input:

```text
8
0?1?01?0
```

Output:

```text
00100100
00100110
00110100
00110110
01100100
01100110
```
