$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\Large\color{olive}\text{c}}$

```java
// y - 2*x = 104 
.....
// x + y = 100 
```

$\quad \lbrace \space y - 2 * x = 104 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 2\space)$  
$\quad \lbrace \space y - 2 * (x + 2) + 4 = 104 \space \rbrace$  
$\quad \lbrace \space y - 2 * (x + 2) = 100 \space\rbrace$  
$\space \color{cornflowerblue} x := x + 2;$  
$\quad \lbrace \space y - 2 * x = 100 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y - 3 * x\space)$  
$\quad \lbrace \space y - 3 * x + x = 100 \space \rbrace$  
$\space \color{cornflowerblue} y := y - 3 * x;$  
$\quad \lbrace \space y + x = 100 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\Large\color{olive}\text{a}}$

```java
// x = A ∧ y = B 
.....
// x = A - B ∧ y = A + B 
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace\space x - y = A - B \space\land\space y = B \space\rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace\space x = A - B \space\land\space y = B \space\rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + 2 * y \space)$  
$\quad \lbrace\space x = A - B \space \land x + 2 * y = A - B + 2*B \space\rbrace$  
$\quad \lbrace\space x = A - B \space \land x + 2 * y = A + B \space\rbrace$  
$\space \color{cornflowerblue}y := x + 2 * y;$  
$\quad \lbrace \space x = A - B \space \land \space y = A + B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\Large\color{olive}\text{c}}$

```java
// x = A ∧ y = B 
.....
// x + y = A - B 
```

$\quad \lbrace \space x = A \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - 3 * y \space)$  
$\quad \lbrace \space x - 3 * y = A - 3 * B \space \land \space y = B \space \rbrace$  
$\space \color{cornflowerblue} x := x - 3 * y;$  
$\quad \lbrace \space x = A - 3 * B \space \land \space y = B \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 2 * y \space)$  
$\quad \lbrace \space x = A - 3 * B \space \land \space 2 * y = 2 * B \space \rbrace$  
$\space \color{cornflowerblue} y := 2 * y;$  
$\quad \lbrace \space x = A - 3 * B \space \land \space y = 2 * B \space \rbrace$  
$\quad \lbrace \space x + y = A - B \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\Large\color{olive}\text{b}}$

```java
// .....
x := x - 2;
z := x + 1;
// z ≠ 0
```

$\quad \lbrace \space x \neq 1 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - 2 \space)$  
$\quad \lbrace \space x - 2 \neq -1 \space \rbrace$  
$\space \color{cornflowerblue} x := x - 2;$  
$\quad \lbrace \space x \neq -1 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare }z := x + 1 \space)$  
$\quad \lbrace \space x + 1 \neq 0 \space \rbrace$  
$\space \color{cornflowerblue} z := x + 1;$  
$\quad \lbrace \space z \neq 0 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\Large\color{olive}\text{a}}$

```java
// ..... 
x := 2*y;
z := x + y;
// z > 0
```

$\quad \lbrace \space y > 0 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * y \space)$  
$\quad \lbrace \space 2 * y > 0 \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * y;$  
$\quad \lbrace \space x > 0 \space \land \space y > 0 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := x + y \space)$  
$\quad \lbrace \space x + y > 0 \space \rbrace$  
$\space \color{cornflowerblue} z := x + y;$  
$\quad \lbrace \space z > 0 \space \rbrace$  
<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\Large\color{olive}\text{b}}$

```java
// .....
x := 3*(x + 2*y - 36);
y := 2*x - 10;
// y > 26
```

$\quad \lbrace \space  x + 2 * y > 42 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 3 * (x + 2 * y - 36) \space)$  
$\quad \lbrace \space  x + 2 * y - 36 > 42 - 36 \space \rbrace$  
$\quad \lbrace \space  3 * (x + 2 * y - 36) > 3 * 6 \space \rbrace$  
$\space \color{cornflowerblue} x := 3 * (x + 2 * y - 36);$  
$\quad \lbrace \space  x > 18 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 2 * x - 10 \space)$  
$\quad \lbrace \space  2 * x > 36 \space \rbrace$  
$\quad \lbrace \space  2 * x - 10 > 26 \space \rbrace$  
$\space \color{cornflowerblue} y := 2 * x - 10;$  
$\quad \lbrace \space y > 26 \space \rbrace$  

<br/>
