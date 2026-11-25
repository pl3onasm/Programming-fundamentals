$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\Large\color{olive}\text{c}}$

```java
// x = A ∧ y = B
.....
// x = 2 * A + B ∧ y = A - B
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare parallel assignment} \space)$  
$\quad \lbrace \space 2 * x + y = 2 * A + B \space \land \space x - y = A - B \space \rbrace$  
$\space \color{cornflowerblue} x,\space y := 2 * x + y,\ x - y;$  
$\quad \lbrace \space x = 2 * A + B \space \land \space y = A - B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\Large\color{olive}\text{a}}$

```java
// x = A ∧ y = B
.....
// x = B ∧ y = A
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = A - B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = A - B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace \space x = A - B \space \land \space x + y = A \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = A - B \space \land \space y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := y - x \space)$  
$\quad \lbrace \space y - x = B \space \land \space y = A \space \rbrace$  
$\space \color{cornflowerblue} x := y - x;$  
$\quad \lbrace \space x = B \space \land \space y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\Large\color{olive}\text{c}}$

```java
// 3 * x - 2 * y = A
.....
// 3 * x - 2 * y = A
```

$\quad \lbrace \space 3 * x - 2 * y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 2 * y \space)$  
$\quad \lbrace \space 3 * (x + 2 * y) - 8 * y = A \space \rbrace$  
$\space \color{cornflowerblue} x := x + 2*y;$  
$\quad \lbrace \space 3 * x - 8 * y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 4 * y \space)$  
$\quad \lbrace \space 3 * x - 2 * (4 * y) = A \space \rbrace$  
$\space \color{cornflowerblue} y := 4 * y;$  
$\quad \lbrace \space 3 * x - 2 * y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\Large\color{olive}\text{a}}$

```java
// .....
x := 2 * x - y;
y := x + y;
// x > y
```

$\quad \lbrace \space y < 0 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract } y \text{ from } 2 * x \space)$  
$\quad \lbrace \space 2 * x - y > 2 * x \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x - y;$  
$\quad \lbrace \space x > x + y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x > y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\Large\color{olive}\text{b}}$

```java
// .....
y := x - 2 * y;
x := x + y;
// x < 2*y
```

$\quad \lbrace \space y < 0 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - 2 * y \space)$  
$\quad \lbrace \space x < x - 2 * y \space \rbrace$  
$\space \color{cornflowerblue} y := x - 2 * y;$  
$\quad \lbrace \space x < y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add } y \text{ to both sides} \space)$  
$\quad \lbrace \space x + y < 2 * y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x < 2 * y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\Large\color{olive}\text{b}}$

```java
// .....
x, y := x + 2 * y, 3 * x - y;
// x < y
```

$\quad \lbrace \space 2 * x > 3 * y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add x - y to both sides} \space)$  
$\quad \lbrace \space 3 * x - y > x + 2 * y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{rearrange the inequality} \space)$
$\quad \lbrace \space x + 2 * y < 3 * x - y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare parallel assignment} \space)$  
$\space \color{cornflowerblue} x, \space y := x + 2 * y,\ 3 * x - y;$  
$\quad \lbrace \space x < y \space \rbrace$  

<br/>
