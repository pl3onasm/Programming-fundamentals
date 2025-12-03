/* 
  file: sol5Annotated.dfy
  author: David De Potter
  description: 3-3rd exam 2025, solution to problem 5,
               with annotations
*/

function fac(n: nat): nat
  requires n >= 0
{   
    // Recursive definition of factorial
  if n == 0 then 1 else n * fac(n - 1)
}

method factorial(n: nat) returns (f: nat)
  ensures f == fac(n)
{
  f := 1;
  var i: nat := 0;

  /* 
    Idea:
    We want to compute n! iteratively. The factorial function fac(n),
    here only used in the specification, is defined recursively as:

      fac(0) = 1
      fac(n) = n * fac(n - 1)   for n > 0

    In order to simulate this definition iteratively, the key idea is
    to use multiplication by repeated addition. For this, we maintain
    an outer loop which keeps track of how many factors have been
    processed so far (using the counter i), and an inner loop which
    performs the multiplication of the current factorial value by
    (i+1) using repeated addition.

    We maintain the following outer invariant: 
      
        0 <= i <= n && f == fac(i)

    This invariant states that i is always a valid counter between
    0 and n, and that f holds the factorial of i at the start of each
    outer loop iteration. Initially, i = 0 and f = 1, so the invariant 
    holds because fac(0) = 1.

    The outer loop continues as long as i < n. In each iteration, we
    want to update f to fac(i+1). To do this, we store the current 
    value of f (which is fac(i)) in a temporary variable v, and then
    use an inner loop to add v to f exactly i times. This way,
    after the inner loop, f will equal (i+1) * fac(i) = fac(i+1).

    The inner loop maintains the following invariant:

        0 <= j <= i && f == v + j * v

    This invariant states that j counts how many times we have added
    v to f so far, and that f equals the initial value v plus j times
    v. Initially, j = 0 and f = v, so the invariant holds. Each 
    iteration of the inner loop adds one more copy of v to f and 
    increments j. When j reaches i, the inner loop stops, and we have
    f = v + i * v = (i + 1) * v, which equals (i + 1) * fac(i) = 
    fac(i + 1).
    After the inner loop completes, we increment i to move to the 
    next factor. This maintains the outer invariant for the next
    iteration.

    Note that we do not need to specify a variant for either loop,
    because Dafny can infer them here from the loop conditions and 
    the way the counters are updated. Should we wish to be explicit 
    about termination, however, we could specify variants for both 
    loops based on the difference between the counters and their 
    respective limits: decreases n - i for the outer loop and  
    decreases i - j for the inner loop.
  */

  while i < n
    invariant 0 <= i <= n && f == fac(i)
  {
    var v, j: nat := f, 0;

    while j < i
      invariant 0 <= j <= i && f == v + j * v
    {
      /* 
        In each iteration, we add one more copy of v to f,
        and increment j by 1, thereby maintaining the
        invariant, since:
          f = v + j * v  =>  f + v = v + (j + 1) * v

        Next, we set:
          f' := f + v
          j' := j + 1

        so that the invariant holds again for the updated
        values:  f' == v + j' * v
      */
      f := f + v;
      j := j + 1;
    }

    /* 
      At inner loop exit:
        j == i
        f == v + i * v = (i + 1) * v

      Since v == fac(i) (from the outer invariant at entry),
      we obtain:
        f == (i + 1) * fac(i) == fac(i + 1)

      We now increment i so that the outer invariant
      f == fac(i) holds again with the new value of i.
    */

    i := i + 1;       
  }

  /* 
    At outer loop exit, the guard i < n is false, so we have 
    i >= n. Together with the invariant 0 <= i <= n, this 
    implies i == n.

    From the outer invariant we then get:
      f == fac(i) == fac(n)
    
    Thus, the postcondition holds.
  */
}