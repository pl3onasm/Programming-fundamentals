$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{c}}$

```java
// x = A ∧ x + y = B
.....
// x - y = A ∧ x = B
```

$\quad \lbrace \space x = A \space \land \space x + y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract equality 1 from eq 2} \space)$  
$\quad \lbrace \space x = A \space \land \space y = B - A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x + y = B \space \land \space y = B - A \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = B \space \land \space y = B - A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{substitute B for x} \space)$  
$\quad \lbrace \space x = B \space \land \space y = x - A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{multiply both sides by -1} \space)$  
$\quad \lbrace \space x = B \space \land \space x - y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{b}}$

```java
// x - y = A ∧ x = B
.....
// x = A ∧ x + y = B 
```

$\quad \lbrace \space x - y = A \space \land \space x = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract equality 1 from eq 2} \space)$  
$\quad \lbrace \space x - y = A \space \land \space y = B - A \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = A \space \land \space y = B - A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{substitute A for x} \space)$  
$\quad \lbrace \space x = A \space \land \space x + y = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{c}}$

```java
// x = A + B ∧ y = A - B
.....
// x = 4 * A ∧ y = 5 * A - 3 * B
```

$\quad \lbrace \space x = A + B \space \land \space y = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 2 * y - x \space)$  
$\quad \lbrace \space x = A + B \space \land \space 2 * y = 2 * A - 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space x = A + B \space \land \space 2 * y - x = A - 3 * B \space \rbrace$  
$\space \color{cornflowerblue} y := 2 * y - x;$  
$\quad \lbrace \space x = A + B \space \land \space y = A - 3 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := y + 3 * x \space)$  
$\quad \lbrace \space 3 * x = 3 * A + 3 *  B \space \land \space y = A - 3 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space y + 3 * x = 4 * A \space \land \space y = A - 3 * B \space \rbrace$  
$\space \color{cornflowerblue} x := y + 3 * x;$  
$\quad \lbrace \space x = 4 * A \space \land \space y = A - 3 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace \space x = 4 * A \space \land \space x + y = 5 * A - 3 * B \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = 4 * A \space \land \space y = 5 * A - 3 * B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{b}}$

```java
// x = A ∧ y = B
x := 2 * x + y; 
y := 2 * x + y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x + y\space)$  
$\quad \lbrace \space 2 * x = 2 * A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space 2 * x + y = 2 * A + B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x + y;$  
$\quad \lbrace \space x = 2 * A + B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 2 * x + y\space)$  
$\quad \lbrace \space x = 2 * A + B$  
$\qquad \land \space 2 * x + y = 4 * A + 3 * B \space \rbrace$  
$\space \color{cornflowerblue} y := 2 * x + y;$  
$\quad \lbrace \space x = 2 * A + B \space \land \space y = 4 * A + 3 * B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{a}}$

```java
// x = A ∧ y = B
x := 2 * x + 2 * y; 
y := x - 2 * y; 
x := x - y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x + 2 * y\space)$  
$\quad \lbrace \space 2 * x = 2 * A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space 2 * x + 2 * y = 2 * A + 2 * B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x + 2 * y;$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - 2 * y\space)$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space - 2 * y = - 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space x - 2 * y = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} y := x - 2 * y;$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space y = 2 * A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{b}}$

```java
// x + y = A ∧ 2 * x + y = B
x := x + 1; 
y := y - 1;
// .....
```

$\quad \lbrace \space x + y = A \space \land \space 2 * x + y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 1 \space)$  
$\quad \lbrace \space (x + 1) -1 + y = A$  
$\qquad \land \space 2 * (x + 1) - 2 + y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x + 1;$  
$\quad \lbrace \space x -1 + y = A \space \land \space 2 * x + y - 2 = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y - 1 \space)$  
$\quad \lbrace \space x -1 + (y -1) + 1 = A$  
$\qquad \land \space 2 * x + (y-1) - 1 = B \space \rbrace$  
$\space \color{cornflowerblue} y := y - 1;$  
$\quad \lbrace \space x + y = A \space \land \space 2 * x + y - 1 = B \space \rbrace$  

<br/>
