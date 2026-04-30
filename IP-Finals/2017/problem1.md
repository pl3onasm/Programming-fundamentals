$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{c}}$

```java
// x + 2 * y = A ∧ x + y = 2 * A
.....
// x = -y
```

$\quad \lbrace \space x + 2 * y = A \space \land \space x + y = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x/3 \space)$  
$\qquad \color{darkseagreen} (\space \text{substitute A in 2nd equality} \space)$  
$\quad \lbrace \space x + y = 2 * (x + 2 * y) \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{simplify} \space)$  
$\quad \lbrace \space -x = 3 * y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by -3} \space)$  
$\quad \lbrace \space x / 3 = -y \space \rbrace$  
$\space \color{cornflowerblue} x := x/3;$  
$\quad \lbrace \space x = -y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{b}}$

```java
// 2 * x + 3 * y = A ∧ x + y = B
.....
// x = B ∧ y = A
```

$\quad \lbrace \space 2 * x + 3 * y = A \space \land \space  x + y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space 2 * (x + y) + y = A \space \land \space  x + y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space 2 * x + y = A \space \land \space  x = B \space \rbrace$  
$\space \color{cornflowerblue} y := y + 2 * x;$  
$\quad \lbrace \space y = A \space \land \space  x = B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{a}}$

```java
// x + A = B ∧ y + B = 2 * A
.....
// x = B ∧ y = A
```

$\quad \lbrace \space x + A = B \space \land \space y + B = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\qquad \color{darkseagreen} (\space \text{substitute B in 2nd equality} \space)$  
$\quad \lbrace \space x + A = B \space \land \space y + x + A = 2 * A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{simplify} \space)$  
$\quad \lbrace \space x + A = B \space \land \space x + y = A \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x + A = B \space \land \space y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\qquad \color{darkseagreen} (\space \text{substitute A in 1st equality} \space)$  
$\quad \lbrace \space x + y = B \space \land \space y = A \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = B \space \land \space y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{a}}$

```java
// x = A + B ∧ y = B
y := x - y; 
x := x - y;
// .....
```

$\quad \lbrace \space x = A + B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\quad \lbrace \space x = A + B \space \land \space -y = -B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = A + B \space \land \space x - y = A \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space x = A + B \space \land \space y = A \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = B \space \land \space y = A \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = B \space \land \space y = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{b}}$

```java
// x = A ∧ y = 2 * B
y := x; 
z := x; 
x := y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = 2 * B \space \rbrace$  
$\space \color{cornflowerblue} y := x;$  
$\quad \lbrace \space x = A \space \land \space y = A \space \rbrace$  
$\space \color{cornflowerblue} z := x;$  
$\quad \lbrace \space x = A \space \land \space y = A \space \land \space z = A \space \rbrace$  
$\space \color{cornflowerblue} x := y;$  
$\quad \lbrace \space x = A \space \land \space y = A \space \land \space z = A \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{c}}$

```java
// x = A ∧ y = B
x := x - y; 
z := x - y; 
y := z - y;
// .....
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = A - B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = A - B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := x - y \space)$  
$\quad \lbrace \space x = A - B \space \land \space y = B$  
$\qquad \land \space x - y = A - 2 * B \space \rbrace$  
$\space \color{cornflowerblue} z := x - y;$  
$\quad \lbrace \space x = A - B \space \land \space y = B \space \land \space z = A - 2 * B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := z - y \space)$  
$\quad \lbrace \space x = A - B \space \land \space z - y = A - 3 * B \space \rbrace$  
$\space \color{cornflowerblue} y := z - y;$  
$\quad \lbrace \space x = A - B \space \land \space y = A - 3 * B \space \rbrace$  

<br/>
