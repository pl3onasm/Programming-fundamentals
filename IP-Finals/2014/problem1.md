$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{b}}$

```java
// x = 2 * X
.....
// x = 42 * X + 21
```

$\quad \lbrace \space x = 2 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 21 * x + 21 \space)$  
$\qquad \color{darkseagreen} (\space \text{multiply both sides by 21} \space)$  
$\quad \lbrace \space 21 * x = 42 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add 21 to both sides} \space)$  
$\quad \lbrace \space 21 * x + 21 = 42 * X + 21 \space \rbrace$  
$\space \color{cornflowerblue} x := 21 * x + 21;$  
$\quad \lbrace \space x = 42 * X + 21 \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{c}}$

```java
// x = 42 * X + 21
.....
// x = 2 * X
```

$\quad \lbrace \space x = 42 * X + 21 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (x - 21)/21 \space)$  
$\qquad \color{darkseagreen} (\space \text{subtract 21 from both sides} \space)$  
$\quad \lbrace \space x - 21 = 42 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 21} \space)$  
$\quad \lbrace \space (x - 21)/21 = 2 * X \space \rbrace$  
$\space \color{cornflowerblue} x := (x - 21)/21;$  
$\quad \lbrace \space x = 2 * X \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{b}}$

```java
// x = X * X * X, y = X * X, z = X
.....
// x = (X + 1) * (X + 1) * (X + 1)  
```

$\quad \lbrace \space x = X * X * X \space \land \space y = X * X$  
$\qquad \land \space z = X\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + 3 * y + 3 * z + 1 \space)$  
$\quad \lbrace \space x + 3 * y + 3 * z + 1$  
$\qquad = X * X * X + 3 * X * X + 3 * X + 1\space$  
$\qquad \land \space y = X * X \space \land \space z = X\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{use } (u + v)^3 = u^3 + 3u^2v + 3uv^2 + v^3 \space$  
$\qquad \color{darkseagreen} \space \space\space \text{with } u = X, v = 1 \space)$  
$\quad \lbrace \space x + 3 * y + 3 * z + 1$  
$\qquad = (X + 1) * (X + 1) * (X + 1) \space$  
$\qquad \land \space y = X * X \space \land \space z = X\space \rbrace$  
$\space \color{cornflowerblue} x := x + 3 * y + 3 * z + 1;$  
$\quad \lbrace \space x = (X + 1) * (X + 1) * (X + 1)$  
$\qquad \land \space y = X * X \space \land \space z = X\space \rbrace$  
$\quad \lbrace \space x = (X + 1) * (X + 1) * (X + 1)\space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{a}}$

```java
// x = X + Y ∧ y = 2 * X - 7
x := 2 * x - y; 
y := (x - 7)/2;
// .....
```

$\quad \lbrace \space x = X + Y \space \land \space y = 2 * X - 7 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x - y \space)$  
$\quad \lbrace \space 2 * x = 2 * X + 2 * Y \space \land \space y = 2 * X - 7 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space 2 * x - y = 2 * Y + 7 \space \land \space y = 2 * X - 7 \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x - y;$  
$\quad \lbrace \space x = 2 * Y + 7 \space \land \space y = 2 * X - 7 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := (x - 7)/2 \space)$  
$\quad \lbrace \space x - 7 = 2 * Y \space \land \space y = 2 * X - 7 \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 2} \space)$  
$\quad \lbrace \space (x - 7)/2 = Y \space \land \space y = 2 * X - 7 \space \rbrace$  
$\space \color{cornflowerblue} y := (x - 7)/2;$  
$\quad \lbrace \space y = Y \space \rbrace$

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{b}}$

```java
// x = X ∧ y = Y 
x := x + y; 
y := 2 * (x - y);
x := (2 * x - y)/2;
// .....
```

$\quad \lbrace \space x = X \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x + y \space)$  
$\quad \lbrace \space x + y = X + Y \space \land \space y = Y \space \rbrace$  
$\space \color{cornflowerblue} x := x + y;$  
$\quad \lbrace \space x = X + Y \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := 2 * (x - y) \space)$  
$\quad \lbrace \space x = X + Y \space \land \space - 2 * y = -2 * Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x = X + Y \space \land \space 2*(x - y) = 2 * X \space \rbrace$  
$\space \color{cornflowerblue} y := 2 * (x - y);$  
$\quad \lbrace \space x = X + Y \space \land \space y = 2 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (2 * x - y)/2 \space)$  
$\quad \lbrace \space 2 * x = 2 * X + 2 * Y \space \land \space y = 2 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract equal terms from both sides} \space)$  
$\quad \lbrace \space 2 * x - y = 2 * Y \space \land \space y = 2 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 2} \space)$  
$\quad \lbrace \space (2 * x - y)/2 = Y \space \land \space y = 2 * X \space \rbrace$  
$\space \color{cornflowerblue} x := (2 * x - y)/2;$  
$\quad \lbrace \space x = Y \space \land \space y = 2 * X \space \rbrace$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{a}}$

```java
// y = X ∧ z = X + Y ∧ x = X + Y + Z
z := z - y; 
y := x - y; 
x := x - z;
// .....
```

$\quad \lbrace \space y = X \space \land \space z = X + Y \space \land \space x = X + Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := z - y \space)$  
$\quad \lbrace \space y = X \space \land \space z - y = Y \space \land \space x = X + Y + Z \space \rbrace$  
$\space \color{cornflowerblue} z := z - y;$  
$\quad \lbrace \space y = X \space \land \space z = Y \space \land \space x = X + Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := x - y \space)$  
$\quad \lbrace \space -y = -X \space \land \space z = Y \space \land \space x = X + Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{add equal terms to both sides} \space)$  
$\quad \lbrace \space x - y = Y + Z \space \land \space z = Y$  
$\qquad \land \space x = X + Y + Z \space \rbrace$  
$\space \color{cornflowerblue} y := x - y;$  
$\quad \lbrace \space y = Y + Z \space \land \space z = Y \space \land \space x = X + Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := x - z \space)$  
$\quad \lbrace \space y = Y + Z \space \land \space z = Y \space \land \space x - z = X + Z \space \rbrace$  
$\space \color{cornflowerblue} x := x - z;$  
$\quad \lbrace \space y = Y + Z \space \land \space z = Y \space \land \space x = X + Z \space \rbrace$  

<br/>
