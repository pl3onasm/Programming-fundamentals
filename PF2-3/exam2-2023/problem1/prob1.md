$\huge\color{cadetblue}{\text{Problem 1}}$

<br/>

For each of the following annotations determine which choice fits on the empty line (.....). The
variables x, y, and z are of type int. Note that A and B (capital letters!) are specification
constants (so not program variables).

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1}}$

```java
// x = y + 7 
.....
// x = 11
```

${\color{peru}(a)} \quad y := 4;$  
${\color{peru}(b)} \quad x := x - y + 4;$  
${\color{peru}(c)} \quad x := 11 - (x + y + 7);$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2}}$

```java
// x = A ∧ y = B 
.....
// x = B - A ∧ y = A + B 
```

${\color{peru}(a)} \quad x := y - x; \space y := x + y;$  
${\color{peru}(b)} \quad y := x + y; \space x := x - 2 * y;$  
${\color{peru}(c)} \quad y := x + y; \space x := y - 2 * x;$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3}}$

```java
// x = A ∧ y = B 
.....
// x - y = A - B
```

${\color{peru}(a)} \quad x := x + y; \space y := y + x;$  
${\color{peru}(b)} \quad x := x + 1; \space y := y + 1;$  
${\color{peru}(c)} \quad x := y; \space y := x;$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4}}$

```java
// .....
y := x - y; 
x := x - y;
// x = A - B ∧ y = B
```

${\color{peru}(a)} \quad x = A \space \land \space y = A - B$  
${\color{peru}(b)} \quad x = 2 * A - 3 * B \space \land \space y = A - 2 * B$  
${\color{peru}(c)} \quad x = B \space \land \space y = A$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5}}$

```java
// ..... 
x := x + 3 * y + 5;
// 10 < x ≤ 16
```

${\color{peru}(a)} \quad 10 \space < \space 2 * x + 6 * y \space < \space 20$  
${\color{peru}(b)} \quad 0 \space < \space x + 3 * y \space < \space 6$  
${\color{peru}(c)} \quad 10 \space \leq \space x + 3 * y + 5 \space < \space 16$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6}}$

```java
// .....
z, x, y := x - y, x + y + z, z - y; 
//  x = A + B ∧ y = 3 * B - A
```

${\color{peru}(a)} \quad x + y + z = A + B \space \land \space z - y = 3 * B - A$  
${\color{peru}(b)} \quad 3 * x - 3 * y = A + B$  
$\qquad \quad \land \space x - 2 * y = 3 * B - A$  
${\color{peru}(c)} \quad x + 2 * y = 2 * A - 2 * B$  
$\qquad \quad \land \space z = y - A + 3 * B$  

&nbsp;
