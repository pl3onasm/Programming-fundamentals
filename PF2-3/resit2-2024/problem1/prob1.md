$\huge\color{cadetblue}{\text{Problem 1}}$

<br/>

For each of the following annotations determine which choice fits on the empty line (.....). The variables x, y, and z are of type int. Note that A and B (capital letters!) are specification constants (so not program variables).

---------------

$\Large{\color{darkkhaki}\text{Prob 1.1}}$

```java
//  x = A 
.....
//  x = 3 * A + 18 
```

${\color{peru} (a) } \quad x := 3 * x + 18; $  
${\color{peru}(b)} \quad x := x/3 - 18; $  
${\color{peru}(c)} \quad x := (x - 18)/3; $  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.2}}$

```java
// 4 * x + 2 * y + 2 * z = 2 * A 
.....
// x = A 
```

${\color{peru}(a)} \quad x := x/2 + y; \space x := y/2 + z;$  
${\color{peru}(b)} \quad x := 2 * x - y; \space x := x + 2 * y + z;$  
${\color{peru}(c)} \quad x := 2 * x + z; \space x := x - y;$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.3}}$

```java
// 3 ≤ x + y * y < 12 
.....
// 5 ≤ y < 14
```

${\color{peru}(a)} \quad y := x + y * y + 2;$  
${\color{peru}(b)} \quad y := x + y * y - 2;$  
${\color{peru}(c)} \quad y := y * y; \space x := 2;$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.4}}$

```java
// x = A ∧ y = B 
x := 2 * x - y;  
y := y + x;  
x := x - y;  
// .....
```

${\color{peru}(a)} \quad x = -B \land y = 2 * A$  
${\color{peru}(b)} \quad x = B \land y = 2 * A$  
${\color{peru}(c)} \quad x = 2 * A \land y = -B$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.5}}$

```java
// 4 * x + 2 * y + 2 * z < 12 
y := y + z;  
x := 2 * x + y;  
// .....
```

${\color{peru}(a)} \quad 8 * x < 6$  
${\color{peru}(b)} \quad x \leq 5$  
${\color{peru}(c)} \quad x < 5$  

<br/>

---------------

$\Large{\color{darkkhaki}\text{Prob 1.6}}$

```java
// x = A ∧ y = B 
x := 2 * x + 2 * y;  
y := x - 2 * y;  
x := (x - y)/2;  
// .....
```

${\color{peru}(a)} \quad x = A \land y = 2 * B$  
${\color{peru}(b)} \quad x = B \land y = A$  
${\color{peru}(c)} \quad x = B \land y = 2 * A$  

&nbsp;
