/* file: sol21Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob21, with annotations
*/

ghost function S(a: array<int>, x: nat): int
requires x <= a.Length
decreases a.Length - x
reads a
{
    // We define 
    //   S(a, x) = ∑( ∑(a[j] * a[h] | j,h: i ≤ j ≤ h < n) | x ≤ i < n)
    // Base case: 
    //   S(a, n) = ∑( ∑(a[j] * a[h] | j,h: i ≤ j ≤ h < n) | n ≤ i < n)
    //           = ∑(∅) = 0
    // For x < n:
    // S(a, x)
    //   = ∑( ∑(a[j] * a[h] | j,h: i ≤ j ≤ h < n) | x ≤ i < n)
    //     ( split domain into x < i and i = x )
    //   = ∑( ∑(a[j] * a[h] | j,h: i ≤ j ≤ h < n) | x < i < n) 
    //     + ∑(a[j] * a[h] | j,h: x ≤ j ≤ h < n)
    //     ( rewrite first sum to comply with definition of S; 
    //       use half-open range )
    //   = ∑( ∑(a[j] * a[h] | j,h: i ≤ j ≤ h < n) | x + 1 ≤ i < n)
    //     + ∑(a[j] * a[h] | j,h: x ≤ j ≤ h < n)
    //     ( apply definition of S and U )
    //   = S(a, x + 1) + U(a, x)
  if x == a.Length then 0 else S(a, x + 1) + U(a, x)
}

ghost function U(a: array<int>, x: nat): int
requires x <= a.Length
decreases a.Length - x
reads a
{
    // We define U(a, x) = ∑(a[i] * a[j] | i,j: x ≤ i ≤ j < n)
    // Base case: U(a, n) = ∑(a[i] * a[j] | i,j: n ≤ i ≤ j < n) 
    //                    = ∑(∅) = 0
    // For x < n:
    // U(a, x)
    //   = ∑(a[i] * a[j] | i,j: x ≤ i ≤ j < n)
    //     ( split domain into x < i and i = x )
    //   = ∑(a[i] * a[j] | i,j: x < i ≤ j < n) 
    //     + ∑(a[x] * a[j] | j: x ≤ j < n)
    //     ( rewrite first sum to comply with definition of U; 
    //       factor out constant a[x] from second sum )
    //   = ∑(a[i] * a[j] | i,j: x + 1 ≤ i ≤ j < n) 
    //     + a[x] * ∑(a[j] | j: x ≤ j < n)
    //     ( apply definition of U and Z )
    //   = U(a, x + 1) + a[x] * Z(a, x)
  if x == a.Length then 0 else U(a, x + 1) + a[x] * Z(a, x)
}

ghost function Z(a: array<int>, x: nat): int
requires x <= a.Length
decreases a.Length - x
reads a
{
    // We define Z(a, x) = ∑(a[i] | i: x ≤ i < n)
    // Base case: Z(a, n) = ∑(a[i] | i: n ≤ i < n) = ∑(∅) = 0
    // For x < n:
    // Z(a, x)
    //   = ∑(a[i] | i: x ≤ i < n)
    //     ( split domain into x < i and i = x )
    //   = ∑(a[i] | i: x < i < n) + a[x]
    //     ( rewrite to comply with definition of Z )
    //   = ∑(a[i] | i: x + 1 ≤ i < n) + a[x]
    //     ( apply definition of Z )
    //   = Z(a, x + 1) + a[x]
  if x == a.Length then 0 else Z(a, x + 1) + a[x]
}

method problem21(a: array<int>) returns (r: int)
ensures r == S(a, 0)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: true
    //   ( arithmetic; base cases of S, U, and Z )
    // 0 ≤ n ≤ n ∧ 0 = S(a, n) ∧ 0 = U(a, n) ∧ 0 = Z(a, n)
  var s:int, u:int, z:int, k:nat := 0, 0, 0, n;
    // J: 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k)

  while k > 0
  invariant 0 <= k <= n
  invariant s == S(a, k) && u == U(a, k) && z == Z(a, k)
  decreases k
  { 
      // J ∧ B ∧ vf = V
      // 0 < k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ k = V > 0
      //   ( apply definition of Z )
      // 0 < k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) 
      //   ∧ z + a[k - 1] = Z(a, k - 1) ∧ k = V
    z := z + a[k - 1];
      // 0 < k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k - 1) ∧ k = V
      //   ( apply definition of U )
      // 0 < k ≤ n ∧ s = S(a, k) ∧ u + a[k - 1] * z = U(a, k - 1) 
      //   ∧ z = Z(a, k - 1) ∧ k = V
    u := u + a[k - 1] * z;
      // 0 < k ≤ n ∧ s = S(a, k) ∧ u = U(a, k - 1) ∧ z = Z(a, k - 1) ∧ k = V
      //   ( apply definition of S )
      // 0 < k ≤ n ∧ s + u = S(a, k - 1) ∧ u = U(a, k - 1) 
      //   ∧ z = Z(a, k - 1) ∧ k = V
    s := s + u;
      // 0 < k ≤ n ∧ s = S(a, k - 1) ∧ u = U(a, k - 1) ∧ z = Z(a, k - 1) ∧ k = V
      //   ( prepare for updating k to k - 1 )
      // 0 ≤ k - 1 < n ∧ s = S(a, k - 1) ∧ u = U(a, k - 1) 
      //   ∧ z = Z(a, k - 1) ∧ k - 1 < V
    k := k - 1;
      // 0 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ k < V
      //   ( J is preserved, and the variant function vf has decreased )
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ k ≤ 0
    //   ( k ≤ 0 and k ≥ 0 implies k = 0 )
    // s = S(a, 0) ∧ u = U(a, 0) ∧ z = Z(a, 0)
  r := s;
    // Q: r = S(a, 0)
}