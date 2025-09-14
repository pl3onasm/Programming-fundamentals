$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{c}}$

```java
// x = A ∧ y = B
.....
// x = A + B ∧ y = A - B
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space x + y = A + B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = A + B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - 2 * y \space)$  
$\quad \lbrace \space x = A + B \space \land \space -2 * y = -2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A + B \space \land \space x -2 * y = A - B \space \rbrace$  
$\space \color{cornflowerblue} y :=  x - 2 * y;$  
$\quad \lbrace \space x = A + B \space \land \space y = A - B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{a}}$

```java
// x = A + B ∧ y = A - B
.....
// x = B ∧ y = A
```

$\quad \lbrace \space x = A + B \space \land \space y = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (x - y)/2 \space)$  
$\quad \lbrace \space x - y = 2 * B \space \land \space y = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 2} \space)$  
$\quad \lbrace \space (x - y)/2 = B \space \land \space y = A - B \space \rbrace$  
$\space \color{cornflowerblue} x := (x - y)/2;$  
$\quad \lbrace \space x = B \space \land \space y = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace \space x = B \space \land \space x + y = A \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = B \space \land \space y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{c}}$

```java
// x + y = A ∧ 2 * x + y = B
.....
// x + y = A ∧ 2 * x + y - 1 = B
```

$\quad \lbrace \space x + y = A \space \land \space 2 * x + y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 1 \space)$  
$\quad \lbrace \space (x + 1) - 1 + y = A$  
$\qquad \land \space 2 * (x + 1) - 2 + y = B \space \rbrace$  
$\space \color{cornflowerblue} x{\scriptsize \text{++}};$  
$\quad \lbrace \space x + y - 1 = A \space \land \space 2 * x + y - 2 = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y - 1 \space)$  
$\quad \lbrace \space x + (y - 1) = A$  
$\qquad \land \space 2 * x + (y - 1) - 1 = B \space \rbrace$  
$\space \color{cornflowerblue} y{\small \text{-}\text{-}};$  
$\quad \lbrace \space x + y = A \space \land \space 2 * x + y - 1 = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{b}}$

```java
// x = 2 * A - B ∧ y = A + B
y := x + y; 
x := x + y;
// .....
```

$\quad \lbrace \space x = 2 * A - B \space \land \space y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y\space)$  
$\quad \lbrace \space x = 2 * A - B\space \land \space x + y = 3 * A \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y = 3 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y\space)$  
$\quad \lbrace \space x + y = 5 * A - B \space \land \space y = 3 * A \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = 5 * A - B \space \land \space y = 3 * A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{a}}$

```java
// x = 2 * A - B ∧ y = A + B
x := x + y; 
y := x + y;
// .....
```

$\quad \lbrace \space x = 2 * A - B \space \land \space y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y\space)$  
$\quad \lbrace \space x + y = 3 * A \space \land \space y = A + B \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = 3 * A \space \land \space y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y\space)$  
$\quad \lbrace \space x = 3 * A \space \land \space x + y = 4 * A + B \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = 3 * A \space \land \space y = 4 * A + B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{b}}$

```java
// x = A ∧ y = B
x := x + 2 * y; 
y := x - y; 
x := x - y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 2 * y \space)$  
$\quad \lbrace \space x + 2 * y = A + 2 * B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x + 2 * y;$  
$\quad \lbrace \space x = A + 2 * B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y\space)$  
$\quad \lbrace \space x = A + 2 * B \space \land \space - y = -B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A + 2 * B \space \land \space x - y = A + B \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = A + 2 * B \space \land \space y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y\space)$  
$\quad \lbrace \space x - y = B \space \land \space y = A + B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = B \space \land \space y = A + B \space \rbrace$  

<br/>
