/* file: sol22Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob22, with annotations
*/

function mxm(x: int, y: int): int
{
  if x >= y then x else y
}

ghost function S(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a 
{
    // We define
    //   S(a, x) = ∑( Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ h) | h: 0 ≤ h < x)
    // Base case: 
    //   S(a, 1) = ∑( Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ h) | h: 0 ≤ h < 1)
    //           = Max(a[0] + a[0]) = 2 * a[0]
    // For x > 1:
    // S(a, x)
    //   = ∑( Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ h) | h: 0 ≤ h < x)
    //     ( split domain into h < x - 1 and h = x - 1 )
    //   = ∑( Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ h) | h: 0 ≤ h < x - 1) 
    //     + Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ x - 1)
    //     ( apply definition of S to first sum; 
    //       rewrite second sum to comply with definition of U )
    //   = S(a, x - 1) + Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j < x)
    //     ( apply definition of U )
    //   = S(a, x - 1) + U(a, x)
  if x == 1 then 2 * a[0] else S(a, x - 1) + U(a, x)
}

ghost function U(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
    // We define 
    //   U(a, x) = Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j < x)
    // Base case: 
    //   U(a, 1) = Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j < 1) 
    //           = Max(a[0] + a[0]) = 2 * a[0] 
    // For x > 1:
    // U(a, x)
    //   = Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j < x)
    //     ( split domain into j < x - 1 and j = x - 1 )
    //   = mxm(Max(a[i] + a[j] | i,j: 0 ≤ i ≤ j < x - 1), 
    //         Max(a[i] + a[x - 1] | i: 0 ≤ i ≤ x - 1))
    //     ( apply definition of U to first Max;
    //       factor out constant a[x - 1] from second Max )
    //   = mxm(U(a, x - 1), a[x - 1] + Max(a[i] | i: 0 ≤ i ≤ x - 1))
    //     ( rewrite to comply with definition of Z; use half-open range )
    //   = mxm(U(a, x - 1), a[x - 1] + Max(a[i] | i: 0 ≤ i < x))
    //     ( apply definition of Z )
    //   = mxm(U(a, x - 1), a[x - 1] + Z(a, x))
  if x == 1 then 2 * a[0] else mxm(U(a, x - 1), a[x - 1] + Z(a, x))
}

ghost function Z(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{    
    // We define 
    //   Z(a, x) = Max(a[i] | i: 0 ≤ i < x)
    // Base case: 
    //   Z(a, 1) = Max(a[i] | i: 0 ≤ i < 1) = a[0]
    // For x > 1:
    // Z(a, x)
    //   = Max(a[i] | i: 0 ≤ i < x)
    //     ( split domain into i < x - 1 and i = x - 1 )
    //   = mxm(Max(a[i] | i: 0 ≤ i < x - 1), a[x - 1])
    //     ( apply definition of Z to first Max )
    //   = mxm(Z(a, x - 1), a[x - 1])
  if x == 1 then a[0] else mxm(Z(a, x - 1), a[x - 1])
}

method problem22(a: array<int>) returns (r: int)
requires a.Length > 0
ensures  r == S(a, a.Length)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n > 0
    //  ( arithmetic; bases cases of S, U, and Z )
    // 0 ≤ 1 ≤ n ∧ 2 * a[0] = S(a, 1) ∧ 2 * a[0] = U(a, 1) ∧ a[0] = Z(a, 1)
  var s:int, u:int, z:int, k:nat := 2 * a[0], 2 * a[0], a[0], 1;
    // J: 1 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k)

  while k < n
  invariant 1 <= k <= n && s == S(a, k) && u == U(a, k) && z == Z(a, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 1 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ n - k = V
      //   ( apply definition of Z to obtain Z(a, k + 1) )
      // 1 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) 
      //     ∧ mxm(z, a[k]) = Z(a, k + 1) ∧ n - k = V
    z := mxm(z, a[k]);
      // 1 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) 
      //     ∧ z = Z(a, k + 1) ∧ n - k = V
      //   ( apply definition of U to obtain U(a, k + 1) )
      // 1 ≤ k < n ∧ s = S(a, k) ∧ mxm(u, a[k] + z) = U(a, k + 1) 
      //     ∧ z = Z(a, k + 1) ∧ n - k = V
    u := mxm(u, a[k] + z);
      // 1 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k + 1) 
      //     ∧ z = Z(a, k + 1) ∧ n - k = V
      //   ( apply definition of S to obtain S(a, k + 1) )
      // 1 ≤ k < n ∧ s + u = S(a, k + 1) 
      //     ∧ u = U(a, k + 1) ∧ z = Z(a, k + 1) ∧ n - k = V
    s := s + u;
      // 1 ≤ k < n ∧ s = S(a, k + 1) 
      //     ∧ u = U(a, k + 1) ∧ z = Z(a, k + 1) ∧ n - k = V
      //   ( prepare for updating k to k + 1 )
      // 1 ≤ k + 1 ≤ n ∧ s = S(a, k + 1) 
      //     ∧ u = U(a, k + 1) ∧ z = Z(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 1 ≤ k ≤ n ∧ s = S(a, k) 
      //     ∧ u = U(a, k) ∧ z = Z(a, k) ∧ n - k < V
      //   ( J is preserved, and the variant function vf has decreased )
  }

    // J ∧ ¬B
    // 1 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ k ≥ n
    //   ( k ≥ n and k ≤ n implies k = n )
    // s = S(a, n) ∧ u = U(a, n) ∧ z = Z(a, n)
  r := s;
    // r = S(a, n)
    //   ( n = a.Length )
    // Q: r = S(a, a.Length)
}