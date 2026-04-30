$\huge\color{cadetblue}{\text{Columnar transposition}}$

<br/>

Columnar transposition is a simple form of encoding a piece of text. The general idea is to write down the text from left to right, top to bottom, in a grid. Then, the encoded text is read column by column (i.e. from top to bottom) in a particular order.  

For example, consider the text "A line of plain text." encoded with the column order $5726341$. Since the column order has $7$ digits, the text is written in a grid with $7$ columns, as shown below.


<div style="margin-left:3em">

| ${\color{peru}5}$ | ${\color{peru}7}$ | ${\color{peru}2}$ | ${\color{peru}6}$ | ${\color{peru}3}$ | ${\color{peru}4}$ | ${\color{peru}1}$ |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| A |   | l | i | n | e |   |
| o | f |   | p | l | a | i |
| n |   | t | e | x | t | . |

  </div>

<br/>

The columns are then read one by one in ascending numerical order to get the encoded text " i.l tnlxeatAonipe f ". The goal of this exercise is to implement such a columnar transposition. The input consists of two lines, the ﬁrst being the text to be encoded, and the second line being a sequence of the digits $1$ through $n$ that indicate in what order $n$ columns should be read to encode the text. The output should be the encoded text.

<br/>

$\Large\color{darkseagreen}{\text{Examples}}$

```text
input:
  It was the best of times, it was the worst of times.
  243156
output:
  we mttr .I e ,a m htii ofsttst swoea oe hstsbfsweti

input:
  Make sure your output ends with the newline character (\n).
  312
output:
  a ryruuesi eei acr\.kseo ttn tt wncrt nMeu uop dwhhnlehae()
```
