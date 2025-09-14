$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{b}}$

```java
// x = X
.....
// x = 3 * X + 1
```

$\quad \lbrace \space x = X \space \rbrace \space$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 3 * x + 1 \space)$  
$\qquad \color{darkseagreen} (\space \text{multiply both sides by 3 and add 1} \space)$  
$\quad \lbrace \space 3 * x + 1 = 3 * X + 1 \space \rbrace$  
$\space \color{cornflowerblue} x := 3 * x + 1;$  
$\quad \lbrace \space x = 3 * X + 1 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{c}}$

```java
// x = 3 * X + 1
.....
// x = X
```

$\quad \lbrace \space x = 3 * X + 1 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (x - 1)/3 \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract 1 from both sides} \space)$  
$\quad \lbrace \space x - 1 = 3 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 3} \space)$  
$\quad \lbrace \space (x - 1)/3 = X \space \rbrace$  
$\space \color{cornflowerblue} x := (x - 1)/3;$  
$\quad \lbrace \space x = X \space \rbrace \space$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{b}}$

```java
// x = y * y + X ∧ y + 1 = Y
.....
// x = y * y + X ∧ y = Y
```

$\quad \lbrace \space x = y * y + X \space \land \space y + 1 = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := y + 1 \space)$  
$\qquad \color{darkseagreen} (\space \text{use } (u + v)^2 = u^2 + 2uv + v^2 \space)$  
$\quad \lbrace \space x = (y + 1) * (y + 1) - 2 * (y + 1) $  
$\qquad \qquad + 1 + X \space \land \space y + 1 = Y \space \rbrace$  
$\space \color{cornflowerblue} y := y + 1;$  
$\quad \lbrace \space x = y * y - 2 * y + 1 + X \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 2 * y - 1 \space)$  
$\quad \lbrace \space x + 2 * y - 1 = y * y + X \space \land \space y = Y \space \rbrace$  
$\space \color{cornflowerblue} x := x + 2 * y - 1;$  
$\quad \lbrace \space x = y * y + X \space \land \space y = Y \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{c}}$

```java
// x = X ∧ y = Y
x := x + 2 * y; 
y := x - 2 * y;
x := x - y;
// .....
```

$\quad \lbrace \space x = X \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 2 * y \space)$  
$\quad \lbrace \space x + 2 * y = X + 2 * Y \space \land \space y = Y \space \rbrace$  
$\space \color{cornflowerblue} x := x + 2 * y;$  
$\quad \lbrace \space x = X + 2 * Y \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - 2 * y \space)$  
$\quad \lbrace \space x = X + 2 * Y \space \land \space - 2* y = -2 * Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = X + 2 * Y \space \land \space x - 2* y = X \space \rbrace$  
$\space \color{cornflowerblue} y := x - 2 * y;$  
$\quad \lbrace \space x = X + 2 * Y \space \land \space y = X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y \space)$  
$\quad \lbrace \space x - y = 2 * Y \space \land \space y = X \space \rbrace$  
$\space \color{cornflowerblue} x := x - y;$  
$\quad \lbrace \space x = 2 * Y \space \land \space y = X \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{c}}$

```java
// x = X + Y ∧ y = X + Z ∧ z = Y + Z
y := (y + z - x)/2; 
z := x - z + y;
x := x - z;
// .....
```

$\quad \lbrace \space x = X + Y \space \land \space y = X + Z$  
$\qquad \land \space z = Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := (y + z - x)/2 \space)$  
$\quad \lbrace \space x = X + Y \space \land \space y + z - x = 2 * Z$  
$\qquad \land \space z = Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 2} \space)$  
$\quad \lbrace \space x = X + Y \space \land \space (y + z - x)/2 = Z$  
$\qquad \land \space z = Y + Z \space \rbrace$  
$\space \color{cornflowerblue} y := (y + z - x)/2;$  
$\quad \lbrace \space x = X + Y \space \land \space y = Z \space \land \space z = Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := x - z + y \space)$  
$\quad \lbrace \space x = X + Y \space \land \space y = Z$  
$\qquad \land \space -z = -Y - Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = X + Y \space \land \space y = Z$  
$\qquad \land \space x - z + y = X \space \rbrace$  
$\space \color{cornflowerblue} z := x - z + y;$  
$\quad \lbrace \space x = X + Y \space \land \space y = Z \space \land \space z = X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - z \space)$  
$\quad \lbrace \space x - z = Y \space \land \space y = Z \space \land \space z = X \space \rbrace$  
$\space \color{cornflowerblue} x := x - z;$  
$\quad \lbrace \space x = Y \space \land \space y = Z \space \land \space z = X \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{b}}$

```java
// x = X + Y + Z ∧ y = Y ∧ z = Z
y := x - y - z; 
z := x - y - z; 
x := x - y - z;
// .....
```

$\quad \lbrace \space x = X + Y + Z \space \land \space y = Y \space \land \space z = Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y - z \space)$  
$\quad \lbrace \space x = X + Y + Z$  
$\qquad \land \space x - y - z = X \space \land \space z = Z \space \rbrace$  
$\space \color{cornflowerblue} y := x - y - z;$  
$\quad \lbrace \space x = X + Y + Z \space \land \space y = X \space \land \space z = Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := x - y - z \space)$  
$\quad \lbrace \space x = X + Y + Z \space \land \space y = X$  
$\qquad \land \space x - y - z = Y \space \rbrace$  
$\space \color{cornflowerblue} z := x - y - z;$  
$\quad \lbrace \space x = X + Y + Z \space \land \space y = X \space \land \space z = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - y - z \space)$  
$\quad \lbrace \space x - y - z = Z \space \land \space y = X \space \land \space z = Y \space \rbrace$  
$\space \color{cornflowerblue} x := x - y - z;$  
$\quad \lbrace \space x = Z \space \land \space y = X \space \land \space z = Y \space \rbrace$  

<br/>
