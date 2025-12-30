$\huge\color{cadetblue}{\text{Counting cards}}$

<br/>

Consider a standard deck of playing cards containing $52$ cards. If we only distinguish between red (R) and black (B) cards and draw $5$ cards, there are $6$ possible distinct hands (RRRRR, RRRRB, RRRBB, RRBBB, RBBBB, and BBBBB). If we distinguish the four suits hearts, diamonds, clubs, and spades instead, there are $56$ distinct possible hands of $5$ cards. If we consider each card to be unique, there are $2\,598\,960$ distinct hands of $5$ cards.

The input for this exercise consists of two lines. The ﬁrst line contains the number of cards $h$ in a hand and the number $d$ of distinct labels. The second line lists how many cards exist for each label. The output should be the number of distinct hands of size $h$ that are possible given the description. Example 1 below corresponds to the color example above, stating that if you have a deck of cards with $2$ distinct labels (red and black) with $26$ repetitions each, there are $6$ distinct hands of size $5$ possible.

<br/>

$\Large\color{darkseagreen}{\text{Examples}}$

```text
input:
  5 2
  26 26
output:
  6

input:
  5 4
  13 13 13 13
output:
  56

input:
  5 5
  1 2 3 4 5
output:
  71
```
