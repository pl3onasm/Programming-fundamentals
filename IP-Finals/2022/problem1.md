$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{\Large c}}$

```java
// x = A + 2
.....
// x = 3 * A + 1 
```

$\quad \lbrace \space x = A + 2 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 3 * (x - 2) + 1 \space)$  
$\qquad \color{darkseagreen} (\space \text{multiply both sides by 3} \space)$  
$\quad \lbrace \space 3 * x = 3 * A + 6 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{move constant term to lhs} \space)$  
$\quad \lbrace \space 3 * x - 6 = 3 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{regroup and add 1 to both sides} \space)$  
$\quad \lbrace \space 3 * (x - 2) + 1 = 3 * A + 1 \space \rbrace$  
$\space \color{cornflowerblue} x := 3 * (x - 2) + 1;$  
$\quad \lbrace \space x = 3 * A + 1 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{\Large Prob 1.2: }}\space{\color{olive}\text{\Large a}}$

```java
// 3 * x + 8 * y = A
.....
// 3 * x + 5 * y = A 
```

$\quad \lbrace \space 3 * x + 8 * y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y; \space)$  
$\quad \lbrace \space 3 * x + 3 * y + 5 * y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{regroup} \space)$  
$\quad \lbrace \space 3 * (x + y) + 5 * y = A \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space 3 * x + 5 * y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{\Large Prob 1.3: }}\space{\color{olive}\text{\Large b}}$

```java
// x + y = A ∧ x + z = B
x := x + y; 
y := y - z;
// .....
```

$\quad \lbrace \space x + y = A \space \land \space x + z = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\qquad \color{darkseagreen} (\space \text{substitute x for A - y in 2nd equality} \space)$  
$\quad \lbrace \space x + y = A \space \land \space A - y + z = B \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = A \space \land \space A - y + z = B \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y - z \space)$  
$\qquad \color{darkseagreen} (\space \text{multiply 2nd eq by -1, move A to rhs} \space)$  
$\quad \lbrace \space x = A \space \land \space y - z = A - B \rbrace$  
$\space \color{cornflowerblue} y := y - z;$  
$\quad \lbrace \space x = A \space \land \space y = A - B \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{\Large Prob 1.4: }}\space{\color{olive}\text{\Large a}}$

```java
// x = A ∧ y = B
x := x - y; 
y := y - x;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y\space)$  
$\quad \lbrace \space x - y = A - B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = A - B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y - x \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space x = A - B \space \land \space  y - x = B - (A - B) \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{simplify} \space)$  
$\quad \lbrace \space x = A - B \space \land \space  y - x = 2 * B - A \space \rbrace$  
$\space \color{cornflowerblue} y := y - x;$  
$\quad \lbrace \space x = A - B \space \land \space  y = 2 * B - A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{\Large Prob 1.5: }}\space{\color{olive}\text{\Large b}}$

```java
// x = B ∧ y = A 
x := x - y; 
y := x + y; 
x := y - x;
// .....
```

$\quad \lbrace \space x = B \space \land \space y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = B - A \space \land \space y = A \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = B - A \space \land \space y = A \space\rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace \space x = B - A \space \land \space x + y = B - A + A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{simplify} \space)$  
$\quad \lbrace \space x = B - A \space \land \space x + y = B \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = B - A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := y - x \space)$  
$\qquad \color{darkseagreen} (\space \text{multiply both sides by -1} \space)$  
$\quad \lbrace \space -x = A - B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space y-x = A \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := y - x;$  
$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{\Large Prob 1.6: }}\space{\color{olive}\text{\Large a}}$

```java
// x = A ∧ y = B
y := x - y; 
x := x + y; 
y := x + y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\qquad \color{darkseagreen} (\space \text{multiply both sides by -1} \space)$  
$\quad \lbrace \space x = A \space \land \space - y = -B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A \space \land \space x - y = A - B \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = A \space \land \space y = A - B \space\rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space x + y = 2 * A - B \space \land \space y = A - B \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace \space x = 2 * A - B \space \land \space x + y = 3 * A - 2 * B \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y = 3 * A - 2 * B \space \rbrace$  

<br/>
