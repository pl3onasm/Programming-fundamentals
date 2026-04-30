$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\Large\color{olive}\text{b}}$

```java
// x = y + 7  
.....
// x = 11  
```

$\quad \lbrace \space x = y + 7 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y + 4\space)$  
$\quad \lbrace \space x - y = 7 \space \rbrace$  
$\quad \lbrace \space x - y + 4 = 11 \space\rbrace$  
$\space \color{cornflowerblue} x := x - y + 4;$  
$\quad \lbrace \space x = 11 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\Large\color{olive}\text{c}}$

```java
// x = A ∧ y = B 
......
// x = B - A ∧ y = A + B 
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace\space x = A \space\land\space x + y = A + B \space\rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace\space x = A \space\land\space y = A + B \space\rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := y - 2 * x \space)$  
$\quad \lbrace\space y - 2 * x = A + B - 2 * A \space \land y = A + B \space\rbrace$  
$\space \color{cornflowerblue} x := y - 2 * x;$  
$\quad \lbrace \space x = B - A \space \land \space y = A + B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\Large\color{olive}\text{b}}$

```java
// x = A ∧ y = B 
.....
// x - y = A - B 
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 1 \space)$  
$\quad \lbrace \space x + 1 = A + 1 \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x + 1;$  
$\quad \lbrace \space x = A + 1 \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y + 1 \space)$  
$\quad \lbrace \space x = A + 1 \space \land \space y + 1 = B + 1 \space \rbrace$  
$\space \color{cornflowerblue} y := y + 1;$  
$\quad \lbrace \space x = A + 1 \space \land \space y = B + 1 \space \rbrace$  
$\quad \lbrace \space x - y = A - B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\Large\color{olive}\text{a}}$

```java
// .....
y := x - y; 
x := x - y;
// x = A - B ∧ y = B
```

$\quad \lbrace \space x = A \space \land \space y = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\quad \lbrace \space x = A \space \land \space x - y = A - (A - B) \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = A - B \space \land \space  y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = A - B \space \land \space y = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\Large\color{olive}\text{a}}$

```java
// .....
x := x + 3 * y + 5;
// 10 < x ≤ 16
```

$\quad \lbrace \space 10 \space <\space 2 * x + 6 * y \space <\space 20 \space \rbrace $  
$\qquad  \color{darkseagreen} (\space \text{divide all sides by 2} \space)$  
$\quad \lbrace \space 5 \space <\space x + 3 * y \space <\space 10 \space \rbrace $  
$\qquad \color{darkseagreen} (\space \text{add 5 to all sides} \space)$  
$\quad \lbrace \space 10 \space <\space x + 3 * y + 5 \space <\space 15 \space \rbrace $  
$\space \color{cornflowerblue} x := x + 3 * y + 5;$  
$\quad \lbrace \space 10 \space <\space x \space <\space 15 \space \rbrace $  
$\qquad \color{darkseagreen} (\space \text{weakening of the postcondition} \space)$  
$\quad \lbrace \space 10 \space <\space x \space \leq \space 16 \space \rbrace $  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\Large\color{olive}\text{a}}$

```java
// .....
z, x, y := x - y, x + y + z, z - y; 
//  x = A + B ∧ y = 3 * B - A
```

$\quad \lbrace \space  x + y + z = A + B \space \land z - y = 3 * B - A \space \rbrace$  
$\space \color{cornflowerblue} z, \space x, \space y := x - y, \space x + y + z,\space z - y;$  
$\quad \lbrace \space x = A + B \space \land \space y = 3 * B - A \space \rbrace$  

<br/>
