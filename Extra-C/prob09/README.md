$\huge\color{cadetblue}{\text{Maze runner}}$

<br/>

The goal of this exercise is to ﬁnd the longest uninterrupted sequence of pellets that pacman can eat given a maze. The input for this exercise consists of two integers $m$ and $n$, representing the number of rows and columns of the maze, respectively, followed by $m$ lines, each terminated with an empty line. Each line consists of a number of characters that are either #, representing a wall, ., representing a pellet, @ representing the pacman character, and spaces representing empty cells.

Each maze will have exactly one pacman character. The pacman character can move single steps in the four directions up, down, left, or right. However, the pacman character cannot enter cells that are ﬁlled with walls (#). Additionally,
whenever the pacman character enters a cell with a pellet, the pellet is consumed. That is, whenever pacman moves, it leaves behind an empty cell.

The goal of the exercise is to ﬁnd the longest uninterrupted sequence of pellets that pacman can consume that is. For example, in the input below, pacman can move up and left to eat 2 pellets, up and right to eat 3 pellets, or go down and each 5 pellets before having to enter an empty space. The output for this maze should therefore be 5.

```text
  5 7
  #######
  #.... #
  ##@##.#
  # ....#
  #######
```

Mind that the input mazes can be irregular in shape, meaning that not all rows need to have the same number of columns. Any missing cells should be treated as walls. Below you can find an example of such an irregular maze.

<br/>

$\Large\color{darkseagreen}{\text{Example}}$

```text
input:

  6 9
  #########
  #. ..  .#
  ##@#.####
  #....#
  #.## #
  ######
  
output:
  6
  
```
