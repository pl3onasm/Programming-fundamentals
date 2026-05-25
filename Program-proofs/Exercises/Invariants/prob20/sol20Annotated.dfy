/* file: sol20Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob20, with annotations
*/

ghost function P(a: array<int>, x: nat): int
requires x <= a.Length
reads a
{
    // We define P(a, x) = ∏( ∑(a[j] * a[h] | j,h: 0 ≤ j ≤ h < i) | i: 0 ≤ i < x)
    // Base case  P(a, 0) = ∏( ∑(a[j] * a[h] | j,h: 0 ≤ j ≤ h < i) | i: 0 ≤ i < 0)
    //                    = ∏(∅) = 1
    // For x > 0:
    // P(a, x)
    //   = ∏( ∑(a[j] * a[h] | j,h: 0 ≤ j ≤ h < i) | i: 0 ≤ i < x)
    //      ( split domain into i < x - 1 and i = x - 1 )
    //   = ∏( ∑(a[j] * a[h] | j,h: 0 ≤ j ≤ h < i) | i: 0 ≤ i < x - 1) 
    //     * ∑(a[j] * a[h] | j,h: 0 ≤ j ≤ h < x - 1)
    //      ( apply definition of P to first factor;
    //        apply definition of S to second factor )
    //   = P(a, x - 1) * S(a, x - 1)
  if x == 0 then 1 else P(a, x - 1) * S(a, x - 1)
}

ghost function S(a: array<int>, x: nat): int
requires x <= a.Length
reads a
{
    // We define S(a, x) = ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x)
    // Base case: S(a, 0) = ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < 0) 
    //                    = ∑(∅) = 0
    // For x > 0:
    // S(a, x)
    //   = ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x)
    //      ( split domain into j < x - 1 and j = x - 1 )
    //   = ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < x - 1) 
    //     + ∑(a[i] * a[x - 1] | i: 0 ≤ i ≤ x - 1)
    //      ( apply definition of S to first sum;
    //        factor out constant a[x - 1] from second sum )
    //   = S(a, x - 1) + a[x - 1] * ∑(a[i] | i: 0 ≤ i ≤ x - 1)
    //      ( rewrite to comply with definition of U; use half-open range )
    //   = S(a, x - 1) + a[x - 1] * ∑(a[i] | i: 0 ≤ i < x)
    //     ( apply definition of U )
    //   = S(a, x - 1) + a[x - 1] * U(a, x)
  if x == 0 then 0 else S(a, x - 1) + a[x - 1] * U(a, x)
}

ghost function U(a: array<int>, x: nat): int
requires x <= a.Length
reads a
{
    // We define U(a, x) = ∑(a[i] | i: 0 ≤ i < x)
    // Base case: U(a, 0) = ∑(a[i] | i: 0 ≤ i < 0) = ∑(∅) = 0
    // For x > 0:
    // U(a, x)
    //   = ∑(a[i] | i: 0 ≤ i < x)
    //      ( split domain into i < x - 1 and i = x - 1 )
    //   = ∑(a[i] | i: 0 ≤ i < x - 1) + a[x - 1]
    //      ( apply definition of U to first sum )
    //   = U(a, x - 1) + a[x - 1]
  if x == 0 then 0 else U(a, x - 1) + a[x - 1]
} 

method problem20(a: array<int>) returns (r: int)
ensures r == P(a, a.Length)
{  
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: true
    //   ( arithmetic; base cases of P, S, and U )
    // 0 ≤ 0 ≤ n ∧ 1 = P(a, 0) ∧ 0 = S(a, 0) ∧ 0 = U(a, 0)
  var p:int, s:int, u:int, k:nat := 1, 0, 0, 0;
    // J: 0 ≤ k ≤ n ∧ p = P(a, k) ∧ s = S(a, k) ∧ u = U(a, k)

  while k < n
  invariant 0 <= k <= n && p == P(a, k) && s == S(a, k) && u == U(a, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k < n ∧ p = P(a, k) ∧ s = S(a, k) ∧ u = U(a, k) ∧ n - k = V
      //   ( apply definition of P to obtain P(a, k + 1) in terms of p and s )
      // 0 ≤ k < n ∧ p * s = P(a, k + 1) ∧ s = S(a, k) ∧ u = U(a, k) ∧ n - k = V
    p := p * s;
      // 0 ≤ k < n ∧ p = P(a, k + 1) ∧ s = S(a, k) ∧ u = U(a, k) ∧ n - k = V
      //   ( apply definition of U to obtain U(a, k + 1) in terms of u and a[k] )
      // 0 ≤ k < n ∧ p = P(a, k + 1) ∧ s = S(a, k) ∧ u + a[k] = U(a, k + 1) ∧ n - k = V
    u := u + a[k];
      // 0 ≤ k < n ∧ p = P(a, k + 1) ∧ s = S(a, k) ∧ u = U(a, k + 1) ∧ n - k = V
      //   ( apply definition of S to obtain S(a, k + 1) in terms of s and u )
      // 0 ≤ k < n ∧ p = P(a, k + 1) ∧ s + a[k] * u = S(a, k + 1) ∧ u = U(a, k + 1) ∧ n - k = V
    s := s + a[k] * u;
      // 0 ≤ k < n ∧ p = P(a, k + 1) ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) ∧ n - k = V
      //   ( prepare for updating k to k + 1 )
      // 0 ≤ k + 1 ≤ n ∧ p = P(a, k + 1) ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 0 ≤ k ≤ n ∧ p = P(a, k) ∧ s = S(a, k) ∧ u = U(a, k) ∧ n - k < V  
      //   ( J is preserved, and the variant function vf has decreased )
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ p = P(a, k) ∧ s = S(a, k) ∧ u = U(a, k) ∧ k ≥ n
    //   ( k ≤ n and k ≥ n implies k = n )
    // p = P(a, n) ∧ s = S(a, n) ∧ u = U(a, n) 
  r := p;
    // r = P(a, n) 
    //   ( n = a.Length )
    // Q: r = P(a, a.Length)
}