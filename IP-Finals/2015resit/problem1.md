$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{b}}$

```java
// x = A ∧ y = B
.....
// x = A - B ∧ y = 2 * B - A
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = A - B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = A - B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y - x \space)$  
$\quad \lbrace \space x = A - B \space \land \space y - x = 2 * B - A \space \rbrace$  
$\space \color{cornflowerblue} y := y - x;$  
$\quad \lbrace \space x = A - B \space \land \space y = 2 * B - A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{a}}$

```java
// 4 * x + 5 * y = A
.....
// x + y = A
```

$\quad \lbrace \space 4 * x + 5 * y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 4 * (x + y) \space)$  
$\quad \lbrace \space 4 * (x + y) + y = A \space \rbrace$  
$\space \color{cornflowerblue} x := 4 * (x + y);$  
$\quad \lbrace \space x + y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{b}}$

```java
// x = A * A * A ∧ y = A * A ∧ z = A
.....
// x = (A + 1)*(A + 1)*(A + 1)
```

$\quad \lbrace \space x = A * A * A \space \land \space y = A * A$  
$\qquad \land \space z = A\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 3 * y + 3 * z + 1 \space)$  
$\quad \lbrace \space x + 3 * y + 3 * z + 1$  
$\qquad = A * A * A + 3 * A * A + 3 * A + 1\space$  
$\qquad \land \space y = A * A \space \land \space z = A\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{use } (u + v)^3 = u^3 + 3u^2v + 3uv^2 + v^3 \space$  
$\qquad \color{darkseagreen} \space \space\space \text{with } u = A, v = 1 \space)$  
$\quad \lbrace \space x + 3 * y + 3 * z + 1$  
$\qquad = (A + 1) * (A + 1) * (A + 1) \space$  
$\qquad \land \space y = A * A \space \land \space z = A\space \rbrace$  
$\space \color{cornflowerblue} x := x + 3 * y + 3 * z + 1;$  
$\quad \lbrace \space x = (A + 1) * (A + 1) * (A + 1)$  
$\qquad \land \space y = A * A \space \land \space z = A\space \rbrace$  
$\quad \lbrace \space x = (A + 1) * (A + 1) * (A + 1)\space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{b}}$

```java
// x = B ∧ y = A
x := y; 
y := x;
// .....
```

$\quad \lbrace \space x = B \space \land \space y = A \space \rbrace$  
$\space \color{cornflowerblue} x := y;$  
$\quad \lbrace \space x = A \space \land \space y = A \space \rbrace$  
$\space \color{cornflowerblue} y := x;$  
$\quad \lbrace \space x = A \space \land \space y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{c}}$

```java
// x = A + 2 ∧ y = 2 * A
x := 3 * x - 4; 
y := x - y;
// .....
```

$\quad \lbrace \space x = A + 2 \space \land \space y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 3 * x - 4 \space)$  
$\quad \lbrace \space 3 * x = 3 * A + 6 \space \land \space y = 2 * A \space \rbrace$  
$\quad \lbrace \space 3 * x - 4 = 3 * A + 2 \space \land \space y = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} x := 3 * x - 4;$  
$\quad \lbrace \space x = 3 * A + 2 \space \land \space y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\quad \lbrace \space x = 3 * A + 2 \space \land \space x - y = A + 2 \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = 3 * A + 2 \space \land \space y = A + 2 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{a}}$

```java
// y = A ∧ z = A + B ∧ x = A + B + C
z := z - y; 
y := x - y; 
x := x - z; 
// .....
```

$\quad \lbrace \space y = A \space \land \space z = A + B \space \land \space x = A + B + C\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := z - y \space)$  
$\quad \lbrace \space y = A \space \land \space z - y = B \space \land \space x = A + B + C\space \rbrace$  
$\space \color{cornflowerblue} z := z - y;$  
$\quad \lbrace \space y = A \space \land \space z = B \space \land \space x = A + B + C\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\quad \lbrace \space x - y = B + C \space \land \space z = B$  
$\qquad \land \space x = A + B + C\space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space y = B + C \space \land \space z = B \space \land \space x = A + B + C\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - z \space)$  
$\quad \lbrace \space y = B + C \space \land \space z = B \space \land \space x - z = A + C\space \rbrace$  
$\space \color{cornflowerblue} x := x - z;$  
$\quad \lbrace \space y = B + C \space \land \space z = B \space \land \space x = A + C\space \rbrace$  

<br/>
