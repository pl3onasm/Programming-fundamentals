/* file: prob03.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob03
   This is exercise 9.4 from the PC reader
*/

ghost predicate DecrAsc(f:(int,int) -> int) 
{
    // Expresses the property that f is decreasing in its first 
    // argument and ascending in its second argument, i.e. 
    // ∀ i,j,k ∈ ℤ:
    //   if i < j then f(i,k) > f(j,k)
    //   if j ≤ k then f(i,j) ≤ f(i,k)
  (forall i,j,k:: i <  j  ==>  f(i,k) >  f(j,k)) &&
  (forall i,j,k:: j <= k  ==>  f(i,j) <= f(i,k))
}

ghost function F(h:(int,int) -> int, x:nat, y:nat, w:int): int
requires DecrAsc(h)
{
  ??
}

method problem03(h:(int,int) -> int, m:nat, n:nat, w:int) 
returns (r: int)
requires DecrAsc(h)
ensures r == F(h, m ,n, w)
{
  /* 
    Given is a function h: ℤ × ℤ → ℤ that is strictly decreasing in its 
    first argument and ascending in its second argument. We define
    a function F that counts the number of points (i,j) such that
    h(i,j) = w:

      F(h,x,y,w) = #{ (i,j) | i,j: 0 ≤ i < x ∧ 0 ≤ j < y ∧ h(i,j) = w }
    
    Derive a command sequence T that satisfies the following 
    specification:
  
      const m,n: ℕ
      const w: ℤ
      var   r: ℤ

        {P: Z = F(h,m,n,w)}
      T
        {Q: r = Z}
     
    The time complexity of T should be in O(m + n).
  */
}