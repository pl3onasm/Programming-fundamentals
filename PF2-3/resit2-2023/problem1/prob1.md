$\huge\color{cadetblue}{\text{Problem 1}}$

<br/>

For each of the following annotations determine which choice fits on the empty line (.....). The
variables x, y, and z are of type int. Note that A and B (capital letters!) are specification
constants (so not program variables).

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1}}$

```java
// x = 11 
.....
// x = y + 7 
```

${\color{peru}(a)} \quad y := 4;$  
${\color{peru}(b)} \quad x := x - y + 4;$  
${\color{peru}(c)} \quad x := 11 - (x + y + 7);$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2}}$

```java
// x = B - A ∧ y = A + B 
.....
// (x + y)/2 = A + B 
```

${\color{peru}(a)} \quad x := y - 2 * x; \space y := x + y;$  
${\color{peru}(b)} \quad y := x + y; \space x := 2 * x - y;$  
${\color{peru}(c)} \quad y := x + y; \space x := y - 2  *  x;$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3}}$

```java
// x - y = A - B ∧ x + y = A + B 
.....
// x + y = A + B 
```

${\color{peru}(a)} \quad x := y + 1; \space y := 1 - x;$  
${\color{peru}(b)} \quad x := x - 1; \space y := y + 1;$  
${\color{peru}(c)} \quad x := 1 - x; \space y := 1 - y;$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4}}$

```java
// .....
 y := y + x; 
 x := x - y;
// x + y = A ∧ y = B
```

${\color{peru}(a)} \quad x = A \space \land \space y = B - A$  
${\color{peru}(b)} \quad 4 * x = 2 * B - A \space \land y = (A + B)/2$  
${\color{peru}(c)} \quad 2 * x - 3 * y = A  \space \land \space x - 2 * y = B$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5}}$

```java
// x = A ∧ y = B 
z := x; 
y := x + y; 
x := x + y + z;
// .....
```

${\color{peru}(a)} \quad x = 2 * A + B \space \land \space y = A + B$  
$\qquad \quad \land \space z = A$  
${\color{peru}(b)} \quad x = 3 * A + B \space \land \space y = B + A$  
$\qquad \quad \land \space z = A$  
${\color{peru}(c)} \quad  x = 2 * A + B \space \land \space y = A + B$  
$\qquad \quad \land \space z = B$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6}}$

```java
// x = A + B ∧ y = A - B 
z := x - y; 
x := x + y + z; 
y := z - y;
// .....
```

${\color{peru}(a)} \quad x = 2 * A \space \land \space y = 3 * B - A$  
${\color{peru}(b)} \quad x = 2 * B \space \land \space y = B - A$  
${\color{peru}(c)} \quad x = 2 * A + 2 * B \space \land \space y = 3 * B - A$  

<br/>