$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{b}}$

```java
// x + 2 * y = A ∧ x + y = 2 * A
.....
// y = A
```

$\quad \lbrace \space x + 2 * y = A \space \land \space x + y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := - y \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract 1st equality from the 2nd} \space)$  
$\quad \lbrace \space  -y = A \space \rbrace$  
$\space \color{cornflowerblue} y := - y;$  
$\quad \lbrace \space y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{b}}$

```java
// 2 * x + y = A + B ∧ x + y = 2 * B
.....
// x = A ∧ y = B
```

$\quad \lbrace \space 2 * x + y = A + B \space \land \space  x + y = 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (3 * x + y)/2 \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract 2nd equality from the 1st} \space)$  
$\quad \lbrace \space x = A - B \space \land \space  x + y = 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{substitute x in 2nd equality} \space)$  
$\quad \lbrace \space x = A - B \space \land \space A - B + y = 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{multiply by 3 and isolate y} \space)$  
$\quad \lbrace \space 3 * x = 3 * A - 3 * B \space \land \space y = 3 * B - A\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space 3 * x + y = 2 * A \space \land \space y = 3 * B - A\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide by 2} \space)$  
$\quad \lbrace \space (3 * x + y)/2 = A \space \land \space y = 3 * B - A \space \rbrace$  
$\space \color{cornflowerblue} x := (3 * x + y)/2;$  
$\quad \lbrace \space x = A \space \land \space y = 3 * B - A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := (x + y)/3 \space)$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A \space \land \space x + y = 3 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 3} \space)$  
$\quad \lbrace \space x = A \space \land \space (x + y)/3 = B \space \rbrace$  
$\space \color{cornflowerblue} y := (x + y)/3;$  
$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{c}}$

```java
// x + A = B ∧ y + B = 2 * A
.....
// x = 2 * A - B ∧ y = 2 * B - 3 * A
```

$\quad \lbrace \space x + A = B \space \land \space y + B = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\quad \lbrace \space x = B - A \space \land \space -y = B - 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = B - A \space \land \space x - y = 2 * B - 3 * A \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = B - A \space \land \space y = 2 * B - 3 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = 2 * A - B \space \land \space y = 2 * B - 3 * A \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = 2 * A - B \space \land \space y = 2 * B - 3 * A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{a}}$

```java
// x = A + 2 * B ∧ y = A + B
y := x - y; 
x := x - y;
// .....
```

$\quad \lbrace \space x = A + 2 * B \space \land \space y = A + B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\quad \lbrace \space x = A + 2 * B \space \land \space -y = -A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A + 2 * B \space \land \space x-y = B \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = A + 2 * B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = A + B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = A + B \space \land \space y = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{c}}$

```java
// x = A ∧ y = 2 * B
z := x; 
x := y; 
y := z;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = 2 * B \space \rbrace$  
$\space \color{cornflowerblue} z := x;$  
$\quad \lbrace \space x = A \space \land \space y = 2 * B \space \land \space z = A \space \rbrace$  
$\space \color{cornflowerblue} x := y;$  
$\quad \lbrace \space x = 2 * B \space \land \space y = 2 * B \space \land \space z = A \space \rbrace$  
$\space \color{cornflowerblue} y := z;$  
$\quad \lbrace \space x = 2 * B \space \land \space y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{a}}$

```java
// x + z = A ∧ y + z = A - B
x := x - y; 
z := y + z; 
y := x + z;
// .....
```

$\quad \lbrace \space x + z = A \space \land \space y + z = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract 2nd equality from the 1st} \space)$  
$\quad \lbrace \space x - y = B \space \land \space y + z = A - B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = B \space \land \space y + z = A - B \space \rbrace$  
$\space \color{cornflowerblue} z := y + z;$  
$\quad \lbrace \space x = B \space \land \space z = A - B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + z \space)$  
$\quad \lbrace \space x = B \space \land \space x + z = A \space \rbrace$  
$\space \color{cornflowerblue} y := x + z;$  
$\quad \lbrace \space x = B \space \land \space y = A \space \rbrace$  

<br/>
