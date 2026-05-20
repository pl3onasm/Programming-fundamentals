/* file: sol14Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob14, with annotations
*/

ghost function S(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length
requires k <= a.Length
reads a, b
{
    // We define S(a, b, k) = ∑(a[i] * b[j] | i,j: 0 ≤ i < j < k ∧ a[i] ≤ b[i])
    // Base case: S(a, b, 0) = ∑(a[i] * b[j] | i,j: 0 ≤ i < j < 0 ∧ a[i] ≤ b[i])
    //                       = ∑(∅) = 0
  if k == 0 then 0 
    // For k > 0:
    // S(a, b, k)
    //   = ∑(a[i] * b[j] | i,j: 0 ≤ i < j < k ∧ a[i] ≤ b[i])
    //      ( split domain into 0 ≤ i < j < k - 1 and j = k - 1 )
    //   = ∑(a[i] * b[j] | i,j: 0 ≤ i < j < k - 1 ∧ a[i] ≤ b[i])
    //     + ∑(a[i] * b[k - 1] | i: 0 ≤ i < k - 1 ∧ a[i] ≤ b[i])
    //      ( apply definition of S to first sum; 
    //        factor out constant b[k - 1] in second sum )
    //   = S(a, b, k - 1) + b[k - 1] * ∑(a[i] | i: 0 ≤ i < k - 1 ∧ a[i] ≤ b[i])
    //      ( apply definition of U )
    //   = S(a, b, k - 1) + b[k - 1] * U(a, b, k - 1)
  else S(a, b, k - 1) + b[k - 1] * U(a, b, k - 1)
}

ghost function U(a: array<nat>, b: array<nat>, k: nat): int
requires a.Length == b.Length 
requires k <= a.Length
reads a, b
{
    // We define U(a, b, k) = ∑(a[i] | i: 0 ≤ i < k ∧ a[i] ≤ b[i])
    // Base case: U(a, b, 0) = ∑(a[i] | i: 0 ≤ i < 0 ∧ a[i] ≤ b[i]) 
    //                       = ∑(∅) = 0
  if k == 0 then 0
    // For k > 0:
    // U(a, b, k)
    //   = ∑(a[i] | i: 0 ≤ i < k ∧ a[i] ≤ b[i])
    //      ( split domain into 0 ≤ i < k - 1 and i = k - 1 )
    //   = ∑(a[i] | i: 0 ≤ i < k - 1 ∧ a[i] ≤ b[i]) 
    //     + ∑(a[i] | i: i = k - 1 ∧ a[i] ≤ b[i])
    //      ( apply definition of U to first sum )
    //   = U(a, b, k - 1) + ∑(a[i] | i: i = k - 1 ∧ a[i] ≤ b[i])
    //      ( distinguish cases a[k - 1] ≤ b[k - 1] and a[k - 1] > b[k - 1] )
  else if a[k - 1] <= b[k - 1]
      //  = U(a, b, k - 1) + ∑(a[i] | i: i = k - 1 ∧ a[i] ≤ b[i])
      //  = U(a, b, k - 1) + a[k - 1]
    then U(a, b, k - 1) + a[k - 1]
      //  = U(a, b, k - 1) + ∑(∅)
      //  = U(a, b, k - 1) + 0
    else U(a, b, k - 1)
}
  

method problem14(a: array<nat>, b: array<nat>) returns (r: int)
requires a.Length == b.Length
ensures r == S(a, b, a.Length)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: true
    //   ( n is a nat; base cases of S and U )
    // 0 ≤ 0 ≤ n ∧ 0 = S(a, b, 0) ∧ 0 = U(a, b, 0)
  var s:int, u:int, k:nat := 0, 0, 0;
    // J: 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ u = U(a, b, k)
  
  while k < n
  invariant 0 <= k <= n && s == S(a, b, k) && u == U(a, b, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k < n ∧ s = S(a, b, k) ∧ u = U(a, b, k) ∧ n - k = V
      //   ( use definition of S to rewrite S(a, b, k + 1) )
      // 0 ≤ k < n ∧ S(a, b, k + 1) = s + u * b[k] ∧ u = U(a, b, k) ∧ n - k = V
    s := s + u * b[k];
      // 0 ≤ k < n ∧ S(a, b, k + 1) = s ∧ u = U(a, b, k) ∧ n - k = V
      //   ( use definition of U to rewrite U(a, b, k + 1) )
      // 0 ≤ k < n ∧ S(a, b, k + 1) = s 
      //     ∧ U(a, b, k + 1) = a[k] <= b[k] ? u + a[k] : u ∧ n - k = V
    u := u + (if a[k] <= b[k] then a[k] else 0);
      // 0 ≤ k < n ∧ S(a, b, k + 1) = s ∧ U(a, b, k + 1) = u ∧ n - k = V
      //   ( prepare for updating k to k + 1 )
      // 0 ≤ k + 1 ≤ n ∧ S(a, b, k + 1) = s ∧ U(a, b, k + 1) = u ∧ n - (k + 1) < V
    k := k + 1;
      // 0 ≤ k ≤ n ∧ S(a, b, k) = s ∧ U(a, b, k) = u ∧ n - k < V 
      //   J is preserved and the variant function vf has decreased
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ s = S(a, b, k) ∧ u = U(a, b, k) ∧ k ≥ n
    //   ( k ≤ n and k ≥ n imply k = n )
    // s = S(a, b, n) ∧ u = U(a, b, n) 
  r := s;
    // r = S(a, b, n)
    //   ( n = a.Length )
    // Q: r = S(a, b, a.Length)
}
