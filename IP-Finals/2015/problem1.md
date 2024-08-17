$\huge\color{cadetblue}{\text{Problem 1}}$

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1: }}\space{\color{olive}\text{c}}$

```java
// 2 * y + x > 12
.....
// x > 11
```

$\quad \lbrace \space 2 * y + x \space > \space 12  \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * y + x - 1 \space)$  
$\quad \lbrace \space 2 * y + x - 1 \space > \space 11 \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * y + x - 1;$  
$\quad \lbrace \space x \space > \space 11 \space \rbrace \space$

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2: }}\space{\color{olive}\text{a}}$

```java
// 6 * x + 3 * y + z = 3 * X - 2 * z
.....
// z = X
```

$\quad \lbrace \space 6 * x + 3 * y + z = 3 * X - 2 * z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := 2 * x + y \space)$  
$\quad \lbrace \space 3 * ( 2 * x + y) + z = 3 * X - 2 * z \space \rbrace$  
$\space \color{cornflowerblue} x := 2 * x + y;$  
$\quad \lbrace \space 3 * x + z = 3 * X - 2 * z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := z + x \space)$  
$\quad \lbrace \space 3 * z + 3 * x = 3 * X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide all sides by 3} \space)$  
$\quad \lbrace \space z + x = X \space \rbrace$  
$\space \color{cornflowerblue} z := z + x;$  
$\quad \lbrace \space z = X \space \rbrace \space$

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3: }}\space{\color{olive}\text{b}}$

```java
// 7 * X - 3 ≤ x < 7 * X + 4
.....
// x = X
```

$\quad \lbrace \space 7 * X - 3 \space \leq \space x \space < \space 7 * X + 4  \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (x + 3)/7 \space)$  
$\qquad \color{darkseagreen} (\space \text{add 3 to all sides} \space)$  
$\quad \lbrace \space 7 * X \space \leq \space x + 3 \space < \space 7 * X + 7  \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide all sides by 7} \space)$  
$\quad \lbrace \space X \space \leq \space (x + 3)/7 \space < \space X + 1  \space \rbrace$  
$\space \color{cornflowerblue} x := (x + 3)/7;$  
$\quad \lbrace \space X \space \leq \space x \space < \space X + 1  \space \rbrace$  
$\qquad \color{darkseagreen} (\space x \text{ is of type {\it int}, hence } x = X\space)$  
$\quad \lbrace \space x = X \space \rbrace \space$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4: }}\space{\color{olive}\text{c}}$

```java
// z + y > 4
x := z + 1; 
y := x + y;
// .....
```

$\quad \lbrace \space z + y \space > \space 4  \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := z + 1 \space)$  
$\quad \lbrace \space z + 1 + y \space > \space 5  \space \rbrace$  
$\space \color{cornflowerblue} x := z + 1;$  
$\quad \lbrace \space x + y \space > \space 5  \space \rbrace$  
$\space \color{cornflowerblue} y := x + y;$  
$\quad \lbrace \space y \space > \space 5  \space \rbrace \space$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5: }}\space{\color{olive}\text{b}}$

```java
// x = X ∧ y = Y ∧ z = Z
z := x + y + z; 
x := z - x - y; 
y := z - x;
// .....
```

$\quad \lbrace \space x = X \space \land \space y = Y \space \land \space z = Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } z := x + y + z \space)$  
$\quad \lbrace \space x = X \space \land \space y = Y$  
$\qquad \land \space x + y + z = X + Y + Z \space \rbrace$  
$\space \color{cornflowerblue} z := x + y + z;$  
$\quad \lbrace \space x = X \space \land \space y = Y \space \land \space z = X + Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := z - x - y \space)$  
$\quad \lbrace \space z - x - y = Z \space \land \space y = Y$  
$\qquad \land \space z = X + Y + Z \space \rbrace$  
$\space \color{cornflowerblue} x := z - x - y;$  
$\quad \lbrace \space x = Z \space \land \space y = Y \space \land \space z = X + Y + Z \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := z - x \space)$  
$\quad \lbrace \space x = Z \space \land \space z - x = X + Y$  
$\qquad \land \space z = X + Y + Z \space \rbrace$  
$\space \color{cornflowerblue} y := z - x;$  
$\quad \lbrace \space x = Z \space \land \space y = X + Y \space \land \space z = X + Y + Z \space \rbrace \space$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6: }}\space{\color{olive}\text{a}}$

```java
// x = 3 * X - 2 * Y + 1 ∧ y = X
y := (3 * y - x + 1)/2; 
x := (x + 2 * y - 1)/3; 
// .....
```

$\quad \lbrace \space x = 3 * X - 2 * Y + 1 \space \land \space y = X \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } y := (3 * y - x + 1)/2 \space)$  
$\quad \lbrace \space x = 3 * X - 2 * Y + 1$  
$\qquad \land \space 3 * y + 1 = 3 * X + 1\space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{subtract equal term from both sides} \space)$  
$\quad \lbrace \space x = 3 * X - 2 * Y + 1$  
$\qquad \land \space 3 * y - x + 1 = 2 * Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 2} \space)$  
$\quad \lbrace \space x = 3 * X - 2 * Y + 1$  
$\qquad \land \space (3 * y - x + 1)/2 = Y \space \rbrace$  
$\space \color{cornflowerblue} y := (3 * y - x + 1)/2;$  
$\quad \lbrace \space x = 3 * X - 2 * Y + 1 \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{prepare } x := (x + 2 * y - 1)/3 \space)$  
$\quad \lbrace \space x + 2 * y - 1 = 3 * X \space \land \space y = Y \space \rbrace$  
$\qquad \color{darkseagreen} (\space \text{divide both sides by 3} \space)$  
$\quad \lbrace \space (x + 2 * y - 1)/3 = X \space \land \space y = Y \space \rbrace$  
$\space \color{cornflowerblue} x := (x + 2 * y - 1)/3;$  
$\quad \lbrace \space x = X \space \land \space y = Y \space \rbrace \space$  

<br/>
