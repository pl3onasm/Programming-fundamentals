$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{b}}$

```java
// x = y + 7
.....
// x = 11
```

$\quad \lbrace \space x = y + 7 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y + 4 \space)$  
$\quad \lbrace \space x - y = 7 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x - y + 4 = 11 \space \rbrace$  
$\space \color{cornflowerblue} x := x - y + 4;$  
$\quad \lbrace \space x = 11 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{c}}$

```java
// x = A ∧ y = B
.....
// x = A - B ∧ y = A + B
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace \space x = A \space \land \space x + y = A + B \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = A \space \land \space y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x - y \space)$  [^1]  
$\quad \lbrace \space 2 * x = 2 * A \space \land \space y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space 2 * x - y = A - B \space \land \space y = A + B \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x - y;$  
$\quad \lbrace \space x = A - B \space \land \space y = A + B \space \rbrace$  


[^1]: Note that the exam has a mistake here. It should be x := 2 * x - y instead of x := y - 2 * x.

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{b}}$

```java
// x = A ∧ y = B
.....
// x - y = A - B
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 1 \space)$  
$\quad \lbrace \space (x + 1) - 1 = A \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x + 1;$  
$\quad \lbrace \space x - 1 = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y + 1 \space)$  
$\quad \lbrace \space x - 1 = A \space \land \space (y+1) -1 = B \space \rbrace$  
$\space \color{cornflowerblue} y := y + 1;$  
$\quad \lbrace \space x - 1 = A \space \land \space y - 1 = B \space \rbrace$  
$\quad \lbrace \space x - y = A - B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{a}}$

```java
// x = A ∧ y = B
y := x - y; 
x := x - y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y\space)$  
$\quad \lbrace \space x = A \space \land \space - y = - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A \space \land \space x - y = A - B \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = A \space \land \space y = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y\space)$  
$\quad \lbrace \space x - y = B \space \land \space y = A - B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = B \space \land \space y = A - B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{a}}$

```java
// x = A ∧ y = B
z := x; 
y := x + y; 
x := x + y + z;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} z := x;$  
$\quad \lbrace \space x = A \space \land \space y = B \space \land \space z = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y\space)$  
$\quad \lbrace \space x = A \space \land \space x + y = A + B \space \land \space z = A \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = A \space \land \space y = A + B \space \land \space z = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y + z\space)$  
$\quad \lbrace \space x + y + z = 3 * A + B$  
$\qquad \land \space y = A + B \space \land \space z = A \space \rbrace$  
$\space \color{cornflowerblue} x := x + y + z;$  
$\quad \lbrace \space x = 3 * A + B \space \land \space y = A + B \space \land \space z = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{c}}$

```java
// x = A + B ∧ y = A - B
z := x - y; 
x := x + y + z; 
y := z - y;
// .....
```

$\quad \lbrace \space x = A + B \space \land \space y = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := x - y \space)$  
$\quad \lbrace \space x = A + B \space \land \space y = A - B$  
$\qquad \land \space x - y = 2 * B  \space \rbrace$  
$\space \color{cornflowerblue} z := x - y;$  
$\quad \lbrace \space x = A + B \space \land \space y = A - B \space \land \space z = 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y + z \space)$  
$\quad \lbrace \space x + y + z = 2 * A + 2 * B$  
$\qquad \land \space y = A - B \space \land \space z = 2 * B \space \rbrace$  
$\space \color{cornflowerblue} x := x + y + z;$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space y = A - B$  
$\qquad \land \space z = 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := z - y \space)$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space - y = B - A$  
$\qquad \land \space z = 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space z - y = 3 * B - A$  
$\qquad \land \space z = 2 * B \space \rbrace$  
$\space \color{cornflowerblue} y := z - y;$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space y = 3 * B - A \space \rbrace$  

<br/>
