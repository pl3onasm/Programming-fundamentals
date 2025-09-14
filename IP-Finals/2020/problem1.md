$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{a}}$

```java
// x = A
.....
// x = 3 * A + 18
```

$\quad \lbrace \space x = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 3 * x + 18 \space)$  
$\quad \lbrace \space 3 * x = 3 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space 3 * x + 18 = 3 * A + 18 \space \rbrace$  
$\space \color{cornflowerblue} x := 3 * x + 18;$  
$\quad \lbrace \space x = 3 * A + 18 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{b}}$

```java
// 4 * x + 2 * y + 2 * z = 2 * A
.....
// x = A 
```

$\quad \lbrace \space 4 * x + 2 * y + 2 * z = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x - y \space)$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 2} \space)$  
$\quad \lbrace \space 2 * x + y + z = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{split and regroup} \space)$  
$\quad \lbrace \space (2 * x - y) + 2 * y + z = A \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x - y;$  
$\quad \lbrace \space x + 2 * y + z = A \space \rbrace$  
$\space \color{cornflowerblue} x := x + 2 * y + z;$  
$\quad \lbrace \space x = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{a}}$

```java
// 3 ≤ x + y * y < 12
.....
// 5 ≤ y < 14
```

$\quad \lbrace \space 3 \space \leq \space  x + y * y \space < \space 12 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y * y + 2 \space)$  
$\qquad \color{darkseagreen} (\space \text{add 2 to all sides } \space)$  
$\quad \lbrace \space 5 \space \leq \space x + y * y + 2 \space <\space  14 \space \rbrace$  
$\space \color{cornflowerblue} x := x + y * y + 2;$  
$\quad \lbrace \space 5 \space \leq \space y \space < \space 14 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{a}}$

```java
// x = A ∧ y = B
x := 2 * x - y; 
y := y + x; 
x := x - y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x - y\space)$  
$\quad \lbrace \space 2 * x = 2 * A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space 2 * x - y = 2 * A - B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x - y;$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y + x \space)$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y + x =  2 * A \space \rbrace$  
$\space \color{cornflowerblue} y := y + x;$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space x - y = - B \space \land \space y = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = - B \space \land \space y = 2 * A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{b}}$

```java
// 4 * x + 2 * y + 2 * z < 12 
y := y + z; 
x := 2 * x + y;
// .....
```

$\quad \lbrace \space 4 * x + 2 * y + 2 * z \space < \space 12 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y + z \space)$  
$\qquad \color{darkseagreen} (\space \text{regroup terms} \space)$  
$\quad \lbrace \space 4 * x + 2 * (y + z) \space < \space 12 \space \rbrace$  
$\space \color{cornflowerblue} y := y + z;$  
$\quad \lbrace \space 4 * x + 2 * y \space < \space 12 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x + y \space)$  
$\qquad \color{darkseagreen} (\space \text{regroup terms} \space)$  
$\quad \lbrace \space 2 * (2 * x + y) \space < \space 12 \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x + y;$  
$\quad \lbrace \space 2 * x \space < \space 12 \space \rbrace$  
$\quad \lbrace \space x \space < \space 6 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{c}}$

```java
// x = A ∧ y = B
x := 2 * x + 2 * y; 
y := x - 2 * y; 
x := (x - y)/2;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x + 2 * y \space)$  
$\quad \lbrace \space 2 * x = 2 * A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space 2 * x + 2 * y = 2 * A + 2 * B\space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x + 2 * y;$  
$\quad \lbrace \space x = 2 * A + 2 * B\space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - 2 * y \space)$  
$\quad \lbrace \space x = 2 * A + 2 * B\space \land \space -2 * y = -2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = 2 * A + 2 * B\space \land \space x -2 * y = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} y := x - 2 * y;$  
$\quad \lbrace \space x = 2 * A + 2 * B\space \land \space y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (x - y)/2 \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space x - y = 2 * B\space \land \space y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 2} \space)$  
$\quad \lbrace \space (x - y)/2 = B\space \land \space y = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} x := (x - y)/2;$  
$\quad \lbrace \space x = B\space \land \space y = 2 * A \space \rbrace$  

<br/>
