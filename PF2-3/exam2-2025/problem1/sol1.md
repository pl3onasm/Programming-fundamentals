$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\Large\color{olive}\text{c}}$

```java
// true 
.....
// x + y = 42 
```

$\quad \lbrace \space \text{true} \space \rbrace$  
$\space \color{cornflowerblue} y := 14$  
$\quad \lbrace \space y = 14 \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * y$  
$\quad \lbrace \space y = 14 \space \land \space x = 28 \space \rbrace$  
$\quad \lbrace \space x + y = 42 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\Large\color{olive}\text{a}}$

```java
// x = A ∧ y = B 
.....
// x = B ∧ y = A 
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := y - 2 * x \space)$  
$\quad \lbrace\space y - 2* x = B - 2 * A \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := y - 2 * x;$  
$\quad \lbrace\space x = B - 2 * A \space \land \space y = B \space\rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y - x \space)$  
$\quad \lbrace\space x = B - 2 * A \space \land \space y - x = 2 * A \space\rbrace$  
$\space \color{cornflowerblue} y := y - x;$  
$\quad \lbrace \space x = B - 2 * A \space \land \space y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space x + y = B \space \land \space y = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = B \space \land \space y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y / 2 \space)$  
$\quad \lbrace \space x = B \space \land \space y / 2 = A \space \rbrace$  
$\space \color{cornflowerblue} y := y / 2;$  
$\quad \lbrace \space x = B \space \land \space y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\Large\color{olive}\text{c}}$

```java
// x * y = A * B 
.....
// x * y = A * B 
```

$\quad \lbrace \space x * y = A * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 1 \space)$  
$\quad \lbrace \space (x + 1) * y - y = A * B \space \rbrace$  
$\space \color{cornflowerblue} x := x + 1;$  
$\quad \lbrace \space x * y - y = A * B \space \rbrace$  
$\space \color{cornflowerblue} y := x * y - y;$  
$\quad \lbrace \space y = A * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 1 \space)$  
$\quad \lbrace \space 1 * y = A * B \space \rbrace$  
$\space \color{cornflowerblue} x := 1;$  
$\quad \lbrace \space x * y = A * B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\Large\color{olive}\text{b}}$

```java
// ..... 
x := 2 * x; 
y := 3 * x - 20;
// x < y
```

$\quad \lbrace \space x > 5 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare }x := 2 * x \space)$  
$\quad \lbrace \space 2 * x > 10 \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x;$  
$\quad \lbrace \space x > 10 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare }y := 3 * x - 20 \space)$  
$\quad \lbrace \space 2 * x > 20 \space \rbrace$  
$\quad \lbrace \space 2 * x - 20 > 0 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add }  x \text{ to both sides} \space)$  
$\quad \lbrace \space 3 * x - 20 > x \space \rbrace$  
$\quad \lbrace \space x < 3 * x - 20 \space \rbrace$  
$\space \color{cornflowerblue} y := 3 * x - 20$  
$\quad \lbrace \space x < y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\Large\color{olive}\text{a}}$

```java
// ..... 
y := 3 * x - 20; 
x:= 2 * x;
// x < y
```

$\quad \lbrace \space x > 25 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 3 * x - 20 \space)$  
$\quad \lbrace \space 3 * x > 25 + 2 * x \space \rbrace$  
$\quad \lbrace \space 3 * x - 20 > 5 + 2 * x \space \rbrace$  
$\space \color{cornflowerblue} y := 3 * x - 20;$  
$\quad \lbrace \space y > 5 + 2 * x \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x;$  
$\quad \lbrace \space y > 5 + x \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{weakening of the postcondition} \space)$  
$\quad \lbrace \space x < y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\Large\color{olive}\text{b}}$

```java
// ..... 
x, y := 3 * x - 20, 2 * x;
// x < y
```

$\quad \lbrace \space \space x < 10 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare for post } x < y\space)$  
$\quad \lbrace \space \space 3 * x < 10 + 2 * x \space \rbrace$  
$\quad \lbrace \space \space 3 * x - 20 < 2 * x - 10 \space \rbrace$  
$\space \color{cornflowerblue} x, y := 3 * x - 20, 2 * x;$  
$\quad \lbrace \space x < y - 10 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{weakening of the postcondition} \space)$  
$\quad \lbrace \space x < y \space \rbrace$  

<br/>
