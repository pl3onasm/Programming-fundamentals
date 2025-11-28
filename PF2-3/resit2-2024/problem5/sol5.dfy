/* file: sol4.dfy
   author: David De Potter
   description: 2-3rd resit 2024, solution to problem 5
*/

ghost function f(x: nat): int {
  // you are not allowed to remove 'ghost'.
  if x <= 2 then 1
  else if x % 3 == 0 then 3*f(x/3 + 1) + 1
  else if x % 3 == 1 then 2*f(x/3) - 1
  else 2*f(x/3 + 1) - 1
}
// Note that:
// f(1)==f(3*0+1)=2*f(0)-1=2-1=1
// f(2)==f(3*0+2)=2*f(0+1)-1=2*f(1)-1=2-1=1

method problem5(n: nat) returns (x: int)
  ensures x == f(n)
{
  var y: int, k: nat;

  /* 
    We want to compute f(n) iteratively. The function f is defined
    recursively with a base case and three recurrence cases, 
    depending on n % 3:

      • if n <= 2:     f(n) = 1
      • if n % 3 == 0: f(n) = 3 * f(n/3 + 1) + 1
      • if n % 3 == 1: f(n) = 2 * f(n/3) - 1
      • if n % 3 == 2: f(n) = 2 * f(n/3 + 1) - 1

    Thus, each evaluation of f(n) involves a single recursive call
    to f with argument n/3 or n/3 + 1.

    To simulate this computation iteratively, we keep track of:
      • k : the current argument of the remaining call f(k).
            We start with k = n and, in each step, replace k by
            either m or m + 1, where m = k / 3, according to the
            recurrence.
      • x : a scaling factor that tells us by how much f(k)
            is multiplied in the current expansion
      • y : an accumulated offset that collects all constant
            terms produced along the way

    Thus, the invariant we maintain is:

      x * f(k) + y == f(n)

    Intuitively:
      • x * f(k) is the part of f(n) that is still "unexpanded"
        (the remaining recursive call)
      • y collects everything we have already unfolded

    Initially, we set:
      x := 1;
      y := 0;
      k := n;

    For these initial values, the invariant gives:
      x*f(k) + y = 1 * f(n) + 0 = f(n),
    so it holds initially.

    In each iteration, we compute m = k/3 and distinguish three
    cases based on k % 3. In each case we rewrite f(k) using the
    corresponding branch of the definition of f, and update
    (x, y, k) so that x*f(k) + y remains equal to f(n).
  */

  x, y, k := 1, 0, n;
  while k > 0
    invariant 0 <= k && x*f(k) + y == f(n)
    decreases k
  {
    var m := k / 3; 
    match k % 3 {
      case 0 => assert 3*m == k;
        /* Here k % 3 == 0, so k = 3*m
           For such k > 2 we have:
             f(k) = 3*f(k/3 + 1) + 1 = 3*f(m+1) + 1

           Using the invariant, we get:
             f(n) = x*f(k) + y
                  = x * (3*f(m+1) + 1) + y
                  = 3*x * f(m+1) + (x + y)

           So if we set:
             y' = x + y
             x' = 3*x
             k' = m + 1

           then:
             x'*f(k') + y'
               = 3*x * f(m+1) + (x + y)
               = f(n)
           and the invariant is preserved.
        */
                y := y + x;
                x := 3*x;
                k := m + 1;
                
      case 1 => assert 3*m + 1 == k;
        /* Here k % 3 == 1, so k = 3*m + 1
           For such k we have:
             f(k) = 2*f(k/3) - 1 = 2*f(m) - 1

           Using the invariant:
             f(n) = x*f(k) + y
                  = x * (2*f(m) - 1) + y
                  = 2*x * f(m) + (y - x)

           So if we set:
              y' = y - x
              x' = 2*x
              k' = m
  
           then:
              x'*f(k') + y'
                = 2*x * f(m) + (y - x)
                = f(n)
           and the invariant is preserved.
        */
                y := y - x;
                x := 2*x;
                k := m;

      case 2 => assert 3*m + 2 == k;
        /* Here k % 3 == 2, so k = 3*m + 2.
           For such k we have:
             f(k) = 2*f(k/3 + 1) - 1 = 2*f(m+1) - 1.

           Using the invariant:
             f(n) = x*f(k) + y
                  = x * (2*f(m+1) - 1) + y
                  = 2*x * f(m+1) + (y - x).

           So if we set:
              y' = y - x
              x' = 2*x
              k' = m + 1
  
           then:
              x'*f(k') + y'
                = 2*x * f(m+1) + (y - x)
                = f(n)
           and the invariant is preserved.
        */
                y := y - x;
                x := 2*x;
                k := m + 1;                
    }
  }

  /* At loop exit we have k == 0.
     The invariant then says:
       x * f(0) + y == f(n)

     From the definition of f: f(0) = 1  
     So: f(n) = x * 1 + y = x + y

     The "active finalization" step below sets x to x + y,
     so we obtain x == f(n), as required.
  */

  x := x + y;   // active finalization
}

