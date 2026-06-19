/* file: prob13.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob13
   This is exercise 9.15 from the PC reader
*/            

ghost predicate pos(f: (nat) -> nat)
{
    // Expresses the property that f is a positive function, 
    // i.e. f(k) > 0 for all k in the domain of f.
  (forall k:: f(k) > 0)
}

method problem13(f: (nat) -> nat, a: nat, n: nat)
returns (r: nat)
requires 0 < a && 0 < n
requires pos(f)
ensures r == ???
{
  /*
    Given is a function f: ℕ → ℕ₊. Derive a command sequence T that 
    satisfies the following specification:

      const a,n : ℕ₊;
      var   z   : ℕ;
      
        {P : Z = #{ (i,j) | i,j: 0 ≤ i ≤ j < n ∧ a = ∑( f(k) | k: i ≤ k < j ) }}
      T
        {Q : Z = z}
      
    In other words, the program should compute the total number of contiguous 
    subsequences taken from the sequence f(0), f(1), ..., f(n-2) that sum to a.
    Note that Z (uppercase) is a specification constant, not a program 
    variable, whereas z (lowercase) is a program variable.
    The time complexity of T should be in O(n).
  */
}