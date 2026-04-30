$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{c}}$

```java
// 10 < 2 * x + 6 * y < 20
.....
// 10 < x < 15
```

$\quad \lbrace \space 10 \space < \space 2 * x + 6 * y \space < \space 20 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 3 * y + 5 \space)$  
$\qquad \color{darkseagreen} (\space \text{divide all sides by 2} \space)$  
$\quad \lbrace \space 5 \space < \space  x + 3 * y \space < \space 10 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add 5 to all sides} \space)$  
$\quad \lbrace \space 10 \space < \space x + 3 * y + 5 \space < \space 15 \space \rbrace$  
$\space \color{cornflowerblue} x := x + 3 * y + 5;$  
$\quad \lbrace \space 10 \space < x \space < 15 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{b}}$

```java
// x = A + B ∧ y = A - B
.....
// x = A ∧ y = B
```

$\quad \lbrace \space x = A + B \space \land \space y = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := (x - y)/2 \space)$  
$\quad \lbrace \space x = A + B \space \land \space -y = B - A \space \rbrace \space$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A + B \space \land \space x - y = 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 2} \space)$  
$\quad \lbrace \space x = A + B \space \land \space (x - y)/2 = B \space \rbrace$  
$\space \color{cornflowerblue} y := (x - y)/2;$  
$\quad \lbrace \space x = A + B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = A \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{c}}$

```java
// x = A ∧ y = B
.....
// x - 2 * B = A
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space x + y = A + B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = A + B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space x + y = A + 2 * B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = A + 2 * B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{move 2 * B to the lhs} \space)$  
$\quad \lbrace \space x - 2 * B = A \space \land \space y = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{b}}$

```java
// x = A ∧ y = B
y := 2 * (x + y); 
x := 2 * (x + y);
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 2 * (x + y)\space)$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A \space \land \space x + y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{multiply both sides by 2} \space)$  
$\quad \lbrace \space x = A \space \land \space 2 * (x + y) = 2 * A + 2 * B \space \rbrace$  
$\space \color{cornflowerblue} y := 2 * (x + y);$  
$\quad \lbrace \space x = A \space \land \space y = 2 * A + 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * (x + y)\space)$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x + y = 3 * A + 2 * B$  
$\qquad \land \space y = 2 * A + 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{multiply both sides by 2} \space)$  
$\quad \lbrace \space 2 * (x + y) = 6 * A + 4 * B$  
$\qquad \land \space y = 2 * A + 2 * B \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * (x + y);$  
$\quad \lbrace \space x = 6 * A + 4 * B \space \land \space y = 2 * A + 2 * B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{a}}$

```java
// x = A ∧ y = B
z := x; 
x := y; 
y := z;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} z := x;$  
$\quad \lbrace \space x = A \space \land \space y = B \space \land \space z = A \space \rbrace$  
$\space \color{cornflowerblue} x := y;$  
$\quad \lbrace \space x = B \space \land \space y = B \space \land \space z = A \space \rbrace$  
$\space \color{cornflowerblue} y := z;$  
$\quad \lbrace \space x = B \space \land \space y = A \space \land \space z = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{b}}$

```java
// y = A ∧ x = z = B
z := x - y; 
x := x + y + z; 
y := z - y;
// .....
```

$\quad \lbrace \space x = B \space \land \space y = A \space \land \space z = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := x - y \space)$  
$\quad \lbrace \space x = B \space \land \space y = A$  
$\qquad \land \space x - y = B - A  \space \rbrace$  
$\space \color{cornflowerblue} z := x - y;$  
$\quad \lbrace \space x = B \space \land \space y = A \space \land \space z = B - A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y + z\space)$  
$\quad \lbrace \space x + y + z = 2 * B \space \land \space y = A$  
$\qquad \land \space z = B - A  \space \rbrace$  
$\space \color{cornflowerblue} x := x + y + z;$  
$\quad \lbrace \space x = 2 * B \space \land \space y = A \space \land \space z = B - A  \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := z - y\space)$  
$\quad \lbrace \space x = 2 * B \space \land \space -y = -A \space \land \space z = B - A  \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = 2 * B \space \land \space z - y = B - 2 * A$  
$\qquad \land \space z = B - A  \space \rbrace$  
$\space \color{cornflowerblue} y := z - y;$  
$\quad \lbrace \space x = 2 * B \space \land \space y = B - 2 * A \space \land \space z = B - A  \space \rbrace$  

<br/>
