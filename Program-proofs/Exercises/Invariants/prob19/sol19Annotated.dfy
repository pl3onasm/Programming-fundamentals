/* file: sol19Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob19, with annotations
*/

function mxm(x: int, y: int): int
{
  if x >= y then x else y
}

ghost function S(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
    // We define S(a, x) = Max (a[i] + a[j] + a[h] | i,j,h: 0 ≤ i ≤ j < x ∧ i ≤ h < x)
    // Base case:
    //   S(a, 1) = Max (a[i] + a[j] + a[h] | i,j,h: 0 ≤ i ≤ j < 1 ∧ i ≤ h < 1)
    //           = Max (a[0] + a[0] + a[0]) = 3 * a[0]
    // For x > 1:
    // S(a, x)
    //   = Max (a[i] + a[j] + a[h] | i,j,h: 0 ≤ i ≤ j < x ∧ i ≤ h < x)
    //     ( split domain into j < x - 1 and j = x - 1 ) 
    //   = mxm (Max (a[i] + a[j] + a[h] | i,j,h: 0 ≤ i ≤ j < x - 1 ∧ i ≤ h < x),
    //          Max (a[i] + a[x - 1] + a[h] | i,h: 0 ≤ i ≤ x - 1 ∧ i ≤ h < x))
    //     ( split the first maximum into h < x - 1 and h = x - 1 )
    //   = mxm (mxm (Max (a[i] + a[j] + a[h] | i,j,h: 0 ≤ i ≤ j < x - 1 ∧ i ≤ h < x - 1),
    //               Max (a[i] + a[j] + a[x - 1] | i,j: 0 ≤ i ≤ j < x - 1)),
    //          Max (a[i] + a[x - 1] + a[h] | i,h: 0 ≤ i ≤ x - 1 ∧ i ≤ h < x))
    //     ( apply definition of S to the first term; 
    //       factor out constant a[x - 1] from the second and third terms )
    //   = mxm (mxm (S(a, x - 1), a[x - 1] + Max (a[i] + a[j] | i,j: 0 ≤ i ≤ j < x - 1)),
    //          a[x - 1] + Max (a[i] + a[h] | i,h: 0 ≤ i ≤ x - 1 ∧ i ≤ h < x))
    //     ( apply definition of U to the second term )
    //   = mxm (mxm (S(a, x - 1), a[x - 1] + U(a, x - 1)),
    //          a[x - 1] + Max (a[i] + a[h] | i,h: 0 ≤ i ≤ h < x))
    //     ( apply definition of U to the third term )
    //   = mxm (mxm (S(a, x - 1), a[x - 1] + U(a, x - 1)), a[x - 1] + U(a, x))
    //     ( since U(a, x) includes all pairs counted by U(a, x - 1),
    //       the third term dominates the second term and we can drop the second term )
    //   = mxm (S(a, x - 1), a[x - 1] + U(a, x))
  if x == 1 then 3 * a[0] else mxm(S(a, x - 1), a[x - 1] + U(a, x))
}

ghost function U(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
    // We define U(a, x) = Max (a[i] + a[j] | i,j: 0 ≤ i ≤ j < x)
    // Base case: U(a, 1) = Max (a[i] + a[j] | i,j: 0 ≤ i ≤ j < 1)
    //                    = Max (a[0] + a[0]) = 2 * a[0]
    // For x > 1:
    // U(a, x)
    //   = Max (a[i] + a[j] | i,j: 0 ≤ i ≤ j < x)
    //     ( split domain into j < x - 1 and j = x - 1 )
    //   = mxm (Max (a[i] + a[j] | i,j: 0 ≤ i ≤ j < x - 1),
    //          Max (a[i] + a[x - 1] | i: 0 ≤ i ≤ x - 1))
    //     ( factor out constant a[x - 1] from second term )
    //   = mxm (U(a, x - 1), a[x - 1] + Max (a[i] | i: 0 ≤ i ≤ x - 1))
    //     ( rewrite to comply with definition of Z; use half-open range )
    //   = mxm (U(a, x - 1), a[x - 1] + mxm (Max (a[i] | i: 0 ≤ i < x - 1), a[x - 1]))
    //     ( apply definition of Z )
    //   = mxm (U(a, x - 1), a[x - 1] + mxm (Z(a, x - 1), a[x - 1]))
  if x == 1 then 2 * a[0] else mxm (U(a, x - 1), a[x - 1] + mxm (Z(a, x - 1), a[x - 1]))
}

ghost function Z(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
    // We define Z(a, x) = Max (a[i] | i: 0 ≤ i < x)
    // Base case: Z(a, 1) = Max (a[i] | i: 0 ≤ i < 1) = a[0]
    // For x > 1:
    // Z(a, x)
    //   = Max (a[i] | i: 0 ≤ i < x)
    //     ( split domain into i < x - 1 and i = x - 1 )
    //   = mxm (Max (a[i] | i: 0 ≤ i < x - 1), Max (a[i] | i: i = x - 1))
    //   = mxm (Z(a, x - 1), a[x - 1])
  if x == 1 then a[0] else mxm (Z(a, x - 1), a[x - 1])
}

method problem19(a: array<int>) returns (r: int)
requires a.Length > 0
ensures  r == S(a, a.Length)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n > 0
    //   ( arithmetic; base cases of S, U, and Z )
    // 1 <= 1 <= n && 3 * a[0] = S(a, 1) && 2 * a[0] = U(a, 1) && a[0] = Z(a, 1)
  var z:int := a[0];
  var u:int := 2 * a[0];
  var s:int := 3 * a[0];
  var k:nat := 1;
    // J: 1 <= k <= n && s = S(a, k) && u = U(a, k) && z = Z(a, k)

  while k < n
  invariant 1 <= k <= n
  invariant s == S(a, k) && u == U(a, k) && z == Z(a, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 1 <= k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ n - k > 0
      //   ( apply definition of Z to obtain Z(a, k + 1) = mxm (Z(a, k), a[k]) )
      // 1 <= k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ Z(a, k + 1) = mxm (z, a[k])
    z := mxm(z, a[k]);
      // 1 <= k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k + 1)
      //   ( apply definition of U to obtain U(a, k + 1) = mxm (U(a, k), a[k] + Z(a, k + 1)) )
      // 1 <= k < n ∧ s = S(a, k) ∧ z = Z(a, k + 1) ∧ U(a, k + 1) = mxm (u, a[k] + z)
    u := mxm(u, a[k] + z);
      // 1 <= k < n ∧ s = S(a, k) ∧ z = Z(a, k + 1) ∧ u = U(a, k + 1)
      //   ( apply definition of S to obtain S(a, k + 1) = mxm (S(a, k), a[k] + U(a, k + 1)) )
      // 1 <= k < n ∧ u = U(a, k + 1) ∧ z = Z(a, k + 1) ∧ S(a, k + 1) = mxm (s, a[k] + u)
    s := mxm(s, a[k] + u);
      // 1 <= k < n ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) ∧ z = Z(a, k + 1)
      //   ( prepare for updating k to k + 1 )
      // 1 <= k + 1 <= n ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) ∧ z = Z(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 1 <= k <= n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ n - k < V
      //   J is preserved and the variant function vf has decreased
  }

    // J ∧ ¬B
    // 1 <= k <= n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ k >= n
    //   ( k ≤ n and k >= n implies k = n )
    // s = S(a, n) ∧ u = U(a, n) ∧ z = Z(a, n)
  r := s;
    // r = S(a, n)
    //   ( n = a.Length )
    // Q: r = S(a, a.Length)
}