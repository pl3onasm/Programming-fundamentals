/* file: prob13.dfy
   author: your name
   description: extra practice in Dafny, invariants, prob13
   This is exercise 7.15 from the PC reader
*/

ghost function S(a: array<real>, x: real, k: nat): real
requires ??
reads a
{
  ??
}

method problem13(a: array<real>, x: real) returns (r: real)
ensures  r == S(a, x, 0)
{
  /* 
    A polynomial can be represented as an array of its coefficients,
    where the coefficient of x^i is stored at index i. For example,
    the polynomial 3 + 2x + 5x^3 can be represented as the array 
    [3, 2, 0, 5]. The value of the polynomial at a given point x can
    be computed using the formula:

      p(x) = ∑(a[i] * x^i | 0 ≤ i < n)

    where a is the array of coefficients and n is its length. 

    Derive a command sequence T that computes the value of the 
    polynomial at a given point x in linear time, i.e., in O(n).

    The specification of T is as follows:

      const n: ℕ
      const x: ℝ
      const a: array [0..n) of ℝ
      var   r: ℝ
        
        {P: true}
      T
        {Q: r = ∑(a[i] * x^i | 0 ≤ i < n)}
    
  
    You should work with the following function S:

      S(a, x, k) = ∑(a[i] * x^{i-k} | k ≤ i < n)
  
  */
}