$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{b}}$

```java
// x = X
.....
// x = 42 * X + 21
```

$\quad \lbrace \space x = X \space \rbrace \space$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 42 * x + 21 \space)$  
$\qquad \color{darkseagreen} (\space \text{multiply both sides by 42} \space)$  
$\quad \lbrace \space 42 * x = 42 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add 21 to both sides} \space)$  
$\quad \lbrace \space 42 * x + 21 = 42 * X + 21 \space \rbrace$  
$\space \color{cornflowerblue} x := 42 * x + 21;$  
$\quad \lbrace \space x = 42 * X + 21 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{c}}$

```java
// x = 42 * X + 21
.....
// x = X
```

$\quad \lbrace \space x = 42 * X + 21 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (x - 21)/42 \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract 21 from both sides} \space)$  
$\quad \lbrace \space x - 21 = 42 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 42} \space)$  
$\quad \lbrace \space (x - 21)/42 = X \space \rbrace$  
$\space \color{cornflowerblue} x := (x - 21)/42;$  
$\quad \lbrace \space x = X \space \rbrace \space$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{b}}$

```java
// x = y * y
.....
// x = y * y
```

$\quad \lbrace \space x = y * y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y + 1 \space)$  
$\qquad \color{darkseagreen} (\space \text{use } (u + v)^2 = u^2 + 2uv + v^2 \space)$  
$\quad \lbrace \space x = (y+1) * (y+1) -2 * y - 1 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract and add 1} \space)$  
$\quad \lbrace \space x = (y+1) * (y+1) -2 * (y+1) + 1 \space \rbrace$  
$\space \color{cornflowerblue} y := y + 1;$  
$\quad \lbrace \space x = y * y - 2 * y + 1 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 2 * y - 1 \space)$  
$\quad \lbrace \space x + 2 * y - 1 = y * y \space \rbrace$  
$\space \color{cornflowerblue} x := x + 2 * y - 1;$  
$\quad \lbrace \space x = y * y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{c}}$

```java
// y + z > 4
x := z + 1; 
y := x + y;
// .....
```

$\quad \lbrace \space y + z \space > \space 4 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := z + 1 \space)$  
$\quad \lbrace \space z + 1 + y \space > \space 5 \space \rbrace$  
$\space \color{cornflowerblue} x := z + 1;$  
$\quad \lbrace \space x + y \space > \space 5 \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space y \space > \space 5 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{b}}$

```java
// x = X ∧ y = Y 
x := x + y; 
y := 2 * x - y;
x := y - 2 * x; 
y := x + y;
// .....
```

$\quad \lbrace \space x = X \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space x + y = X + Y \space \land \space y = Y \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = X + Y \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 2 * x - y \space)$  
$\quad \lbrace \space x = X + Y \space \land \space - y = -Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = X + Y \space \land \space 2 * x - y = 2 * X + Y \space \rbrace$  
$\space \color{cornflowerblue} y := 2 * x - y;$  
$\quad \lbrace \space x = X + Y \space \land \space y = 2 * X + Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := y - 2 * x \space)$  
$\quad \lbrace \space - 2 * x = -2 * X - 2 * Y$  
$\qquad \land \space y = 2 * X + Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space y - 2 * x = - Y \space \land \space y = 2 * X + Y \space \rbrace$  
$\space \color{cornflowerblue} x := y - 2 * x;$  
$\quad \lbrace \space x = - Y \space \land \space y = 2 * X + Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x + y \space)$  
$\quad \lbrace \space x = - Y \space \land \space x + y = 2 * X \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space x = - Y \space \land \space y = 2 * X \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{ a}}$

```java
// x = X ∧ y = X + Y ∧ z = X + Y + Z
z := z - y; 
y := y - x; 
x := x - z;
// .....
```

$\quad \lbrace \space x = X \space \land \space y = X + Y$  
$\qquad \land \space z = X + Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := z - y \space)$  
$\quad \lbrace \space x = X \space \land \space y = X + Y \space \land \space z - y = Z \space \rbrace$  
$\space \color{cornflowerblue} z := z - y;$  
$\quad \lbrace \space x = X \space \land \space y = X + Y \space \land \space z = Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y - x \space)$  
$\quad \lbrace \space x = X \space \land \space y - x = Y \space \land \space z = Z \space \rbrace$  
$\space \color{cornflowerblue} y := y - x;$  
$\quad \lbrace \space x = X \space \land \space y = Y \space \land \space z = Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - z \space)$  
$\quad \lbrace \space x - z = X - Z \space \land \space y = Y \space \land \space z = Z \space \rbrace$  
$\space \color{cornflowerblue} x := x - z;$  
$\quad \lbrace \space x = X - Z \space \land \space y = Y \space \land \space z = Z \space \rbrace$  

<br/>

