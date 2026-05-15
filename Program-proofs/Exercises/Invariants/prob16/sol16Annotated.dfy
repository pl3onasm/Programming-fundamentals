/* file: sol16Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob16, with annotations
*/

ghost function S(a: array<nat>, x: nat): int
requires x <= a.Length
reads a
{
    // We define S(a, x) = ∑( ∑(a[i] | i: 0 ≤ i ≤ k) * ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < k) | k: 0 ≤ k < x )
    // Base case: S(a, 0) = ∑( ∑(a[i] | i: 0 ≤ i ≤ k) * ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < k) | k: 0 ≤ k < 0 )
    //                    = ∑(∅) = 0
    // For x > 0:
    // S(a, x)
    //   = ∑( ∑(a[i] | i: 0 ≤ i ≤ k) * ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < k) | k: 0 ≤ k < x )
    //      ( split domain into k < x - 1 and k = x - 1 )
    //   = ∑( ∑(a[i] | i: 0 ≤ i ≤ k) * ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < k) | k: 0 ≤ k < x - 1 )
    //     + ∑(a[i] | i: 0 ≤ i ≤ x - 1) * ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x - 1)
    //      ( apply definition of S to first sum )
    //   = S(a, x - 1) + ∑(a[i] | i: 0 ≤ i ≤ x - 1) * ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x - 1)
    //      ( rewrite to comply with definition of U; use half-open range )
    //   = S(a, x - 1) + ∑(a[i] | i: 0 ≤ i < x) * ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x - 1)
    //      ( apply definition of Z to first sum )
    //   = S(a, x - 1) + Z(a, x) * ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x - 1)
    //      ( apply definition of U to last sum )
    //   = S(a, x - 1) + Z(a, x) * U(a, x - 1)
  if x == 0 then 0 else S(a, x - 1) + Z(a, x) * U(a, x - 1)
}

ghost function U(a: array<nat>, x: nat): int
requires x <= a.Length
reads a
{
    // We define U(a, x) = ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x)
    // Base case: U(a, 0) = ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < 0) 
    //                    = ∑(∅) = 0
    // For x > 0:
    // U(a, x)
    //   = ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x)
    //      ( split domain into j < x - 1 and j = x - 1 )
    //   = ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x - 1) + ∑(a[i] * a[x - 1] | i: 0 ≤ i ≤ x - 1)
    //      ( apply definition of U to first sum; 
    //        factor out constant a[x - 1] from second sum )
    //   = U(a, x - 1) + a[x - 1] * ∑(a[i] | i: 0 ≤ i ≤ x - 1)
    //      ( rewrite to comply with definition of Z; use half-open range )
    //   = U(a, x - 1) + a[x - 1] * ∑(a[i] | i: 0 ≤ i < x)
    //      ( apply definition of Z )
    //   = U(a, x - 1) + a[x - 1] * Z(a, x)
  if x == 0 then 0 else U(a, x - 1) + a[x - 1] * Z(a, x)
}

ghost function Z(a: array<nat>, x: nat): int
requires x <= a.Length
reads a
{
    // We define Z(a, x) = ∑(a[i] | i: 0 ≤ i < x)
    // Base case: Z(a, 0) = ∑(a[i] | i: 0 ≤ i < 0) = ∑(∅) = 0
    // For x > 0:
    // Z(a, x)
    //   = ∑(a[i] | i: 0 ≤ i < x)
    //      ( split domain into i < x - 1 and i = x - 1 )
    //   = ∑(a[i] | i: 0 ≤ i < x - 1) + ∑(a[i] | i: i = x - 1)
    //   = ∑(a[i] | i: 0 ≤ i < x - 1) + a[x - 1]
    //      ( apply definition of Z )
    //   = Z(a, x - 1) + a[x - 1]
  if x == 0 then 0 else Z(a, x - 1) + a[x - 1]
}

method problem16(a: array<nat>) returns (r: int)
ensures r == S(a, a.Length)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: true
    //   ( n is a natural number; base cases of S, U, and Z )
    // 0 ≤ 0 ≤ n ∧ 0 = S(a, 0) ∧ 0 = U(a, 0) ∧ 0 = Z(a, 0)
  var s:int, u:int, k:nat, z:int := 0, 0, 0, 0;
    // J: 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k)

  while k < n
  invariant 0 <= k <= n && s == S(a, k) && u == U(a, k) && z == Z(a, k)
  decreases n - k
  {    
      // J ∧ B ∧ vf = V
      // 0 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ n - k = V 
      //   ( use definition of Z(a, k + 1) = Z(a, k) + a[k]; 
      //     substitute Z(a, k) for z )
      // 0 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z + a[k] = Z(a, k + 1) ∧ n - k = V
    z := z + a[k];
      // 0 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k + 1) ∧ n - k = V
      //   ( use definition of S(a, k + 1) = S(a, k) + Z(a, k + 1) * U(a, k);
      //     substitute S(a, k) for s, Z(a, k + 1) for z, and U(a, k) for u )
      // 0 ≤ k < n ∧ s + z * u = S(a, k + 1) ∧ u = U(a, k) ∧ z = Z(a, k + 1) ∧ n - k = V
    s := s + z * u;
      // 0 ≤ k < n ∧ s = S(a, k + 1) ∧ u = U(a, k) ∧ z = Z(a, k + 1) ∧ n - k = V
      //   ( use definition of U(a, k + 1) = U(a, k) + a[k] * Z(a, k + 1); 
      //     substitute U(a, k) for u and Z(a, k + 1) for z )
      // 0 ≤ k < n ∧ s = S(a, k + 1) ∧ u + a[k] * z = U(a, k + 1) ∧ z = Z(a, k + 1) ∧ n - k = V
    u := u + a[k] * z;
      // 0 ≤ k < n ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) ∧ z = Z(a, k + 1) ∧ n - k = V
      //   ( prepare for updating k to k + 1 )
      // 0 ≤ k + 1 ≤ n ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) ∧ z = Z(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ n - k < V
      //   J is preserved and the variant function vf has decreased
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ k ≥ n
    //   ( k ≤ n ∧ k ≥ n implies k = n )
    // s = S(a, n) ∧ u = U(a, n) ∧ z = Z(a, n)
  r := s;
    // r = S(a, n)
    //   ( n = a.Length )
    // Q: r = S(a, a.Length)
}
