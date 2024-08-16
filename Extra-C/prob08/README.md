$\huge\color{cadetblue}{\text{Segments}}$

<br/>

The input for this problem is a positive integer $n$ indicating a certain number of segments. This is followed by a colon and a series of $n$ half-open segments. For each $a < b$, the half open segment $[a, b)$ represents the set of numbers $\lbrace \space x \space \vert \space a \leq x < b \space \rbrace$.  

An example of a valid input would be:  
$$6:[1,5),[7,8),[8,10),[12,15),[2,3),[4,6)$$  

Clearly, some of these segments overlap, and can therefore be fused. For example, the segments $[1,5)$, $[2,3)$, and $[4,6)$ can be fused into the segment $[1,6)$. Also, the segments $[7,8)$ and $[8,10)$ can be fused into $[7,10)$.  

You are asked to write a program that reads the segments from the input, and outputs an equivalent series of segments in which all overlapping and touching input segments have been fused. The segments must be printed on the output in ascending order of the lower bounds of the segments. For the above example, the output should thus be $[1,6),[7,10),[12,15)$.  

<br/>

$\Large\color{darkseagreen}{\text{Examples}}$

```text
input:
  6:[1,5),[2,3),[4,6),[7,8),[8,10),[12,15)
output:
  [1,6),[7,10),[12,15)

input:
  6:[1,5),[7,8),[8,10),[12,15),[2,3),[4,6)
output:
  [1,6),[7,10),[12,15)

input:
  10:[1,2),[1,4),[0,5),[0,1),[1,7),[0,0),[2,9),[1,7),[2,7),[1,4)
output:
  [0,9)
```
