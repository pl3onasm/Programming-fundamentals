# $\color{cadetblue}{\text{Problem 1}}$

For each of the following annotations determine which choice fits on the empty line (.....). The
variables x, y, and z are of type int. Note that A and B (capital letters!) are specification
constants (so not program variables).

## $\color{darkkhaki}\text{Prob 1.1}$

```dafny
// x == y + 7 
??
// x == 11
```

${\color{peru}(a)} \quad y := 4;$  
${\color{peru}(b)} \quad x := x - y + 4;$  
${\color{peru}(c)} \quad x := 11 - (x + y + 7);$  

&nbsp;

## $\color{darkkhaki}\text{Prob 1.2}$

```dafny
// x == A && y == B 
??
// x == B - A && y == A + B 
```

${\color{peru}(a)} \quad x := y - x; \space y := x + y;$  
${\color{peru}(b)} \quad y := x + y; \space x := x - 2 * y;$  
${\color{peru}(c)} \quad y := x + y; \space x := y - 2 * x;$  

&nbsp;

## $\color{darkkhaki}\text{Prob 1.3}$

```dafny
// x == A && y == B 
??
// x - y == A - B
```

${\color{peru}(a)} \quad x := x + y; \space y := y + x;$  
${\color{peru}(b)} \quad x := x + 1; \space y := y + 1;$  
${\color{peru}(c)} \quad x := y; \space y := x;$  

&nbsp;

## $\color{darkkhaki}\text{Prob 1.4}$

```dafny
// .....
y := x - y; x := x - y;
// x == A - B && y == B
```

${\color{peru}(a)} \quad // \quad x == A \space \land \space y == A - B$  
${\color{peru}(b)} \quad // \quad x == 2 * A - 3 * B \space \land \space y == A - 2 * B$  
${\color{peru}(c)} \quad // \quad x == B \space \land \space y == A$  

&nbsp;

## $\color{darkkhaki}\text{Prob 1.5}$

```dafny
// ..... 
x := x + 3*y + 5;
// 10 < x <= 16
```

${\color{peru}(a)} \quad // \quad 10 < 2 * x + 6 * y < 20$  
${\color{peru}(b)} \quad // \quad 0 < x + 3 * y < 6$  
${\color{peru}(c)} \quad // \quad 10 <= x + 3 * y + 5 < 16$  

&nbsp;

## $\color{darkkhaki}\text{Prob 1.6}$

```dafny
// .....
z, x, y := x - y, x + y + z, z - y; 
//  x == A + B && y == 3 * B - A
```

${\color{peru}(a)} \quad // \quad x + y + z == A + B \space \land \space z - y == 3 * B - A$  
${\color{peru}(b)} \quad // \quad 3 * x - 3 * y == A + B \space \land \space x - 2 * y == 3 * B - A$  
${\color{peru}(c)} \quad // \quad x + 2 * y == 2 * A - 2 * B \space \land \space z == y - A + 3 * B$  