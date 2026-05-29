/* file: prob02.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob02
   This is exercise 9.3 from the PC reader
*/

ghost predicate DescAsc(f:(int,int) -> int) 
{
    // Expresses the property that f is descending in its first 
    // argument and ascending in its second argument, i.e. 
    // ∀ i,j,k ∈ ℕ:
    //   if i ≤ j then f(i,k) ≥ f(j,k)
    //   if j ≤ k then f(i,j) ≤ f(i,k)
  (forall i,j,k:: i <= j  ==>  f(i,k) >= f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

ghost function F(g:(int,int) -> int, x:nat, y:nat): int
requires DescAsc(g)
{   
  ??
}

method problem02(g:(int,int) -> int, m:nat, n:nat) 
returns (r: int)
requires DescAsc(g)
ensures r == g(m,n)
{
  /* 
    Given is a function g: ℤ × ℤ → ℤ that is descending in its 
    first argument and ascending in its second argument. We define
    a function F that counts the number of points (i,j) such that
    g(i,j) ≤ 0:

      F(g,x,y) = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ g(i,j) ≤ 0 }
    
    Derive a command sequence T that satifies the following 
    specification:
  
      const m,n: ℕ
      var   r: ℤ

        {P: Z = F(g,m,n)}
      T
        {Q: r = Z}
     
    The time complexity of T should be in O(m + n).
  */
}