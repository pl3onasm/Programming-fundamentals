$\huge\color{cadetblue}{\text{Suitcase packing}}$

<br/>

A recurring struggle when going on vacation is what to pack in the limited amount of space in your suitcase. The goal of this exercise is to pack a suitcase so that the satisfaction value the owner gets from the items inside the suitcase is as high as possible without exceeding the volume of the suitcase.

The input for this exercise consists of multiple lines. The ﬁrst line holds two numbers $n$ and $v$, which represent the number $n$ of items that the owner considers packing, and the volume $v$ of the suitcase. The next $n$ lines each contain a word describing the item, the item’s size, and its satisfaction value (which may be negative). The output should be the optimal satisfaction value that can be achieved from a set of items that fit inside the suitcase.

<br/>

$\Large\color{darkseagreen}{\text{Examples}}$

```text
input:
  3 100
  Umbrella 50 10
  Stove 51 100
  Bowtie 50 95
output:
  105

input:
  3 100
  Textbook 10 100
  Fan 10 100
  Trouble 0 -100
output:
  200

input:
  3 2
  Jeans 3 500
  Cardigan 3 9001
  Flipflops 3 42
output:
  0
```
