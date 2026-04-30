$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{c}}$

```java
// 6 < x + 2 * y < 11
.....
// 5 < x < 10
```

$\quad \lbrace \space 6 \space < \space x + 2 * y \space < \space 11 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 2 * y - 1 \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract 1 from all sides} \space)$  
$\quad \lbrace \space 5 \space < \space x + 2 * y - 1 \space < \space 10 \space \rbrace$  
$\space \color{cornflowerblue} x := x + 2 * y - 1;$  
$\quad \lbrace \space 5 \space < \space x \space < \space 10 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{b}}$

```java
// 2 * x + 3 * y = X ∧ 2 * y = Y
.....
// z = X + Y
```

$\quad \lbrace \space 2 * x + 3 * y = X \space \land \space  2 * y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := 2 * x + 5 * y \space)$  
$\qquad \color{darkseagreen} (\space \text{add both equalities} \space)$  
$\quad \lbrace \space 2 * x + 5 * y = X + Y \space \rbrace$  
$\space \color{cornflowerblue} z := 2 * x + 5 * y;$  
$\quad \lbrace \space z = X + Y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{a}}$

```java
// x = X + Y ∧ y = 2 * X - 7
.....
// x = X + Y ∧ y = Y
```

$\quad \lbrace \space x = X + Y \space \land \space y = 2 * X - 7 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := (2 * x - y - 7)/2 \space)$  
$\quad \lbrace \space x = X + Y \space \land \space - y -7 = - 2 * X\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add 2 times 1st equality to 2nd} \space)$  
$\quad \lbrace \space x = X + Y \space \land \space 2 * x - y -7 = 2 * Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 2} \space)$  
$\quad \lbrace \space x = X + Y \space \land \space (2 * x - y -7) / 2 = Y \space \rbrace$  
$\space \color{cornflowerblue} y := (2 * x - y - 7)/2;$  
$\quad \lbrace \space x = X + Y \space \land \space y = Y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{a}}$

```java
// x = X ∧ y = Y
y := x + y; 
x := x * (y - x);
// .....
```

$\quad \lbrace \space x = X \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace \space x = X \space \land \space x + y = X + Y \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = X \space \land \space y = X + Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x * (y - x) \space)$  
$\quad \lbrace \space x * (y - x) = X * Y \space \land \space y = X + Y \space \rbrace$  
$\space \color{cornflowerblue} x := x * (y - x); \space$  
$\quad \lbrace \space x = X * Y \space \land \space y = X + Y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{b}}$

```java
// x = X ∧ y = Y
x := y; 
y := x;
// .....
```

$\quad \lbrace \space x = X \space \land \space y = Y \space \rbrace \space$  
$\space \color{cornflowerblue} x := y;$  
$\quad \lbrace \space x = Y \space \land \space y = Y \space \rbrace \space$  
$\space \color{cornflowerblue} y := x;$  
$\quad \lbrace \space x = Y \space \land \space y = Y \space \rbrace \space$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{c}}$

```java
// x = X ∧ y = Y
x := x + y; 
y := x - y; 
// .....
```

$\quad \lbrace \space x = X \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space x + y = X + Y \space \land \space y = Y \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = X + Y \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\quad \lbrace \space x = X + Y \space \land \space x - y = X \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = X + Y \space \land \space y = X \space \rbrace$  

<br/>
