/* file: prob12.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob12
   This is exercise 7.14 from the PC reader
*/

function B(a: array<int>, k: nat := a.Length): int
requires ??
reads a
{
  ??
}

function C(a: array<int>, k: nat := a.Length): int
requires ??
reads a
{
  ??
}

method problem12(a: array<int>) returns (r: int)
ensures  r == B(a)
{
  /* 
    Derive a command sequence T that satisfies the below
    specification:

    const n: ℕ
    const a: array [0..n) of ℤ
    var   r: ℤ
      
      {P: true}
    T
      {Q: r = ∑(a[i] * a[j] | 0 ≤ i < j < n)}
  
  
    The algorithm should run in linear time, i.e., in O(n).
    To achieve this, you should work with functions B and C
    that satisfy the following recursive definitions:

      B(a, k) = ∑(a[i] * a[j] | 0 ≤ i < j < k)
      C(a, k) = ∑(a[i] | 0 ≤ i < k)
  
  */
}