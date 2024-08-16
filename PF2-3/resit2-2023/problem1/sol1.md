$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{a}}$

```java
// x = 11 
.....
// x = y + 7 
```

$\quad \lbrace \space x = 11 \space \rbrace$  
$\quad \lbrace \space x = 4 + 7 \space \rbrace$  
$\space \color{cornflowerblue} y := 4;$  
$\quad \lbrace \space x = y + 7 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}{\Large\color{olive}\text{c}}$

```java
// x = B - A ∧ y = A + B 
.....
// (x + y)/2 = A + B 
```

$\quad \lbrace \space x = B - A \space \land \space y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace\space x = B - A \space\land\space x + y = 2 * B \space\rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace\space x = B - A \space\land\space y = 2 * B \space\rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := y - 2 * x \space)$  
$\quad \lbrace\space y - 2 * x = 2 * A \space \land y = 2 * B \space\rbrace$  
$\space \color{cornflowerblue} x := y - 2 * B;$  
$\quad \lbrace \space x = 2 * A \space \land \space y = 2 * B \space \rbrace$  
$\quad \lbrace \space ( \space x + y \space) / 2 = A + B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}{\Large\color{olive}\text{b}}$

```java
// x - y = A - B ∧ x + y = A + B 
.....
// x + y = A + B 
```

$\quad \lbrace \space x - y = A - B \space \land \space x + y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - 1 \space)$  
$\quad \lbrace \space (x - 1) - y = A - B - 1$  
$\qquad \land \space (x - 1) + y = A + B - 1 \space \rbrace$  
$\space \color{cornflowerblue} x := x - 1;$  
$\quad \lbrace \space x - y = A - B - 1$  
$\qquad \land \space x + y = A + B - 1 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y + 1 \space)$  
$\quad \lbrace \space x - (y + 1) = A - B - 2$  
$\qquad \land \space x + (y + 1) = A + B \space \rbrace$  
$\space \color{cornflowerblue} y := y + 1;$  
$\quad \lbrace \space x - y = A - B - 2 \space \land \space x + y = A + B \space \rbrace$  
$\quad \lbrace \space x + y = A + B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}{\Large\color{olive}\text{a}}$

```java
// .....
 y := y + x; 
 x := x - y;
// x + y = A ∧ y = B
```

$\quad \lbrace \space x = A \space \land \space y = B-A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y + x\space)$  
$\quad \lbrace \space x = A \space \land \space y + x = B \space \rbrace$  
$\space \color{cornflowerblue} y := y + x;$  
$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space (x - y) + y = A \space \land \space  y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x + y = A \space \land \space y = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}{\Large\color{olive}\text{b}}$

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
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace \space x = A \space \land \space x + y = B + A \space \land \space z = A \space\rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = A \space \land \space y = B + A \space \land \space z = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y + z \space)$  
$\quad \lbrace \space x + y + z = 3 * A + B \space \land \space y = B + A$  
$\qquad \land \space z = A \space \rbrace$  
$\space \color{cornflowerblue} x := x + y + z;$  
$\quad \lbrace \space x = 3 * A + B \space \land \space y = B + A \space \land \space z = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}{\Large\color{olive}\text{a}}$

```java
// x = A + B ∧ y = A - B 
z := x - y; 
x := x + y + z; 
y := z - y;
// .....
```

$\quad \lbrace \space x = A + B \space \land \space y = A - B \space \rbrace$  
$\space \color{cornflowerblue} z := x - y;$  
$\quad \lbrace \space x = A + B \space \land \space y = A - B \space \land \space z = 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y + z \space)$  
$\quad \lbrace \space x + y + z = 2 * A + 2 * B \space \land \space y = A - B$  
$\qquad \land \space z = 2 * B \space\rbrace$  
$\space \color{cornflowerblue} x := x + y + z;$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space y = A - B$  
$\qquad \land \space z = 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := z - y \space)$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space z - y = 3 * B - A \space \rbrace$  
$\space \color{cornflowerblue} y := z - y;$  
$\quad \lbrace \space x = 2 * A + 2 * B \space \land \space y = 3 * B - A \space \rbrace$  

<br/>
