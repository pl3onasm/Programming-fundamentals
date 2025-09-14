$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\Large\color{olive}\text{a}}$

```java
//  x = A 
.....
//  x = 3 * A + 18 
```

$\quad \lbrace \space x = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 3 * x + 18 \space)$  
$\quad \lbrace \space 3 * x = 3 * A  \space \rbrace$  
$\quad \lbrace \space 3 * x + 18 = 3 * A + 18 \space\rbrace$  
$\space \color{cornflowerblue} x := 3 * x + 18;$  
$\quad \lbrace \space x = 3 * A + 18 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\Large\color{olive}\text{b}}$

```java
// 4 * x + 2 * y + 2 * z = 2 * A 
.....
// x = A 
```

$\quad \lbrace \space 4 * x + 2 * y + 2 * z = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x - y \space)$  
$\quad \lbrace\space 2 * (2 * x - y ) + 4 * y + 2 * z = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x - y;$  
$\quad \lbrace\space 2 * x + 4 * y + 2 * z = 2 * A \space\rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 2 * y + z \space)$  
$\quad \lbrace\space x + 2 * y + z = A \space\rbrace$  
$\space \color{cornflowerblue} x := x + 2 * y + z;$  
$\quad \lbrace \space x = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\Large\color{olive}\text{a}}$

```java
// 3 ≤ x + y * y < 12 
.....
// 5 ≤ y < 14
```

$\quad \lbrace \space 3 \leq x + y * y < 12 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y * y + 2 \space)$  
$\quad \lbrace \space 5 \leq x + y * y + 2 < 14 \space \rbrace$  
$\space \color{cornflowerblue} y := x + y * y + 2;$  
$\quad \lbrace \space 5 \leq y < 14 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\Large\color{olive}\text{a}}$

```java
// x = A ∧ y = B 
x := 2 * x - y;  
y := y + x;  
x := x - y;  
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x - y \space)$  
$\quad \lbrace \space 2 * x = 2 * A \space \land \space y = B \space \rbrace$  
$\quad \lbrace \space 2 * x - y = 2 * A - B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x - y;$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare }y := y + x \space)$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y + x = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} y := y + x;$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare }x := x - y \space)$  
$\quad \lbrace \space x - y = - B \space \land \space y = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = - B \space \land \space y = 2 * A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\Large\color{olive}\text{b}}$

```java
// 4 * x + 2 * y + 2 * z < 12 
y := y + z;  
x := 2 * x + y;  
// .....
```

$\quad \lbrace \space 4 * x + 2 * y + 2 * z < 12  \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y + z \space)$  
$\quad \lbrace \space 4 * x + 2 * (y + z) < 12 \space \rbrace$  
$\space \color{cornflowerblue} y := y + z;$  
$\quad \lbrace \space 4 * x + 2 * y < 12 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x + y;  \space)$  
$\quad \lbrace \space 2 * x + * y < 6 \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x + y;$  
$\quad \lbrace \space x < 6 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{arithmetic} \space)$  
$\quad \lbrace \space x \leq 5 \space \rbrace$  
<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\Large\color{olive}\text{c}}$

```java
// x = A ∧ y = B 
x := 2 * x + 2 * y;  
y := x - 2 * y;  
x := (x - y)/2;  
// .....
```

$\quad \lbrace \space \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x + 2 * y \space)$  
$\quad \lbrace \space \space 2 * x = 2 * A \space \land \space y = B \space \rbrace$  
$\quad \lbrace \space \space 2 * x + 2 * y = 2 * A + 2 * B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x + 2 * y;$  
$\quad \lbrace \space \space x = 2 * A + 2 * B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - 2 * y \space)$  
$\quad \lbrace \space \space x = 2 * A + 2 * B \space \land \space - 2 * y = - 2 * B \space \rbrace$  
$\quad \lbrace \space \space x = 2 * A + 2 * B \space \land \space x - 2 * y = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} y := x - 2 * y;$  
$\quad \lbrace \space \space x = 2 * A + 2 * B \space \land \space y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (x - y)/2 \space)$  
$\quad \lbrace \space \space x - y = 2 * B \space \land \space y = 2 * A \space \rbrace$  
$\quad \lbrace \space \space (x - y) / 2 = B \space \land \space y = 2 * A \space \rbrace$  
$\space \color{cornflowerblue} x := (x - y)/2;$  
$\quad \lbrace \space \space x = B \space \land \space y = 2 * A \space \rbrace$  

<br/>
