$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{a}}$

```java
// x = y * z
.....
// x = y * z 
```

$\quad \lbrace \space x = y * z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space x - z = y * z - z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y - 1 \space)$  
$\quad \lbrace \space x - z = z * (y - 1) \space \rbrace$  
$\space \color{cornflowerblue} y {\small \text{-}\text{-}};$  
$\qquad \color{darkseagreen} (\space \text{y-}\text{-}\text{ is the same as y := y - 1} \space)$  
$\quad \lbrace \space x - z = z * y \space \rbrace$  
$\space \color{cornflowerblue} x := x - z;$  
$\quad \lbrace \space x = z * y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{b}}$

```java
// 3 * x + 5 * y = A
.....
// y = A 
```

$\quad \lbrace \space 3 * x + 5 * y = A \space \rbrace$  
$\quad \lbrace \space 3 * x + 3 * y + 2 * y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space 3 * (x + y) + 2 * y = A \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space 3 * x + 2 * y = A \space \rbrace$  
$\space \color{cornflowerblue} y := 3 * x + 2 * y;$  
$\quad \lbrace \space y = A \space \rbrace$

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{a}}$

```java
// x * x ≤ A < (x + 1) * (x + 1)
.....
// x ≤ A < x + y
```

$\quad \lbrace \space x * x \space \leq \space A \space < \space (x + 1) * (x + 1) \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 2 * x + 1 \space)$  
$\qquad \color{darkseagreen} (\space \text{expand product} \space)$  
$\quad \lbrace \space x * x \space \leq \space A \space < \space x * x + 2 * x + 1 \space \rbrace$  
$\space \color{cornflowerblue} y := 2 * x + 1;$  
$\quad \lbrace \space x * x \space \leq \space A \space < \space x * x + y \space \rbrace \space$  
$\space \color{cornflowerblue} x := x * x;$  
$\quad \lbrace \space x \space \leq \space A \space < \space x + y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{a}}$

```java
// x = A ∧ y = B
x := x - y; 
y := x + y; 
x := 2 * x - y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y\space)$  
$\quad \lbrace \space x - y = A - B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = A - B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A - B \space \land \space x + y = A \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = A - B \space \land \space y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x - y \space)$  
$\quad \lbrace \space 2 * x = 2 * A - 2 * B \space \land \space y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space 2 * x - y = A - 2 * B \space \land \space y = A \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x - y;$  
$\quad \lbrace \space A - 2 * B \space \land \space y = A \space \rbrace$

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{b}}$

```java
// x = A ∧ y = B 
x := 3 * x + y; 
y := x - y; 
x := x - y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 3 * x + y \space)$  
$\quad \lbrace \space 3 * x = 3 * A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space 3 * x + y = 3 * A + B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := 3 * x + y;$  
$\quad \lbrace \space x = 3 * A + B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\quad \lbrace \space x = 3 * A + B \space \land \space -y = -B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = 3 * A + B \space \land \space x - y = 3 * A \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = 3 * A + B \space \land \space y = 3 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space x - y = B \space \land \space y = 3 * A \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = B \space \land \space y = 3 * A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{c}}$

```java
// x = A ∧ y = B
x := 2 * x + 2 * y; 
y := 2 * x - y; 
x := y - x;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x + 2 * y \space)$  
$\quad \lbrace \space 2 * x = 2 * A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space 2 * x + 2 * y = 2 * A + 2 * B\space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x + 2 * y;$  
$\quad \lbrace \space x = 2 * A + 2 * B\space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 2 * x - y \space)$  
$\quad \lbrace \space x = 2 * A + 2 * B\space \land \space -y = -B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = 2 * A + 2 * B$  
$\qquad \land \space 2 * x - y = 4 * A + 3 * B \space \rbrace$  
$\space \color{cornflowerblue} y := 2 * x - y;$  
$\quad \lbrace \space x = 2 * A + 2 * B\space \land \space y = 4 * A + 3 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := y - x \space)$  
$\quad \lbrace \space -x = -2 * A - 2 * B$  
$\qquad \land \space y = 4 * A + 3 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space y-x = 2 * A + B\space \land \space y = 4 * A + 3 * B \space \rbrace$  
$\space \color{cornflowerblue} x := y - x;$  
$\quad \lbrace \space x = 2 * A + B\space \land \space y = 4 * A + 3 * B \space \rbrace$  

<br/>
