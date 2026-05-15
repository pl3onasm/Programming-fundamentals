/* file: prob08.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob08
   This is exercise 7.10b from the PC reader
*/
ghost function Max(a: array<int>, k: nat := a.Length): int
requires ??
reads a
{
  ??
}

method problem08(a: array<int>) returns (r:int)
requires a.Length > 0
ensures r == Max(a)
{  
  /* 
    Derive a command sequence T that satisfies the below
    specification:

    const n: ℕ
    const a: array [0..n) of ℤ
    var   r: ℤ
      
      {P: n > 0}
    T
      {Q: r = Max(a[i] | 0 ≤ i < n)}
  */
  
}