/* file: sol15Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob15, with annotations
*/

ghost function S(a: array<nat>, k: nat): int
requires k <= a.Length
reads a
{
    // We define S(a, k) = ∑(a[i] * a[j] | i,j: 0 ≤ i < k ∧ 0 ≤ j < k)
    // Base case: S(a, 0) = ∑(a[i] * a[j] | i,j: 0 ≤ i < 0 ∧ 0 ≤ j < 0) 
    //                    = ∑(∅) = 0
    // For k > 0:
    // S(a, k)
    //   = ∑(a[i] * a[j] | i,j: 0 ≤ i < k ∧ 0 ≤ j < k)
    //      ( split domain into i < k - 1 and i = k - 1 )
    //   = ∑(a[i] * a[j] | i,j: 0 ≤ i < k - 1 ∧ 0 ≤ j < k) 
    //     + ∑(a[k - 1] * a[j] | j: 0 ≤ j < k)
    //      ( factor out constant a[k - 1] from second sum )
    //   = ∑(a[i] * a[j] | i,j: 0 ≤ i < k - 1 ∧ 0 ≤ j < k) 
    //     + a[k - 1] * ∑(a[j] | j: 0 ≤ j < k)
    //      ( split the remaining j-ranges into j < k - 1 and j = k - 1 )
    //   = ∑(a[i] * a[j] | i,j: 0 ≤ i < k - 1 ∧ 0 ≤ j < k - 1) 
    //     + ∑(a[i] * a[k - 1] | i: 0 ≤ i < k - 1) 
    //     + a[k - 1] * (∑(a[j] | j: 0 ≤ j < k - 1) + a[k - 1])
    //       ( apply definition of S to first sum; 
    //         factor out constant a[k - 1] from second sum )
    //   = S(a, k - 1) + a[k - 1] * ∑(a[i] | i: 0 ≤ i < k - 1) 
    //     + a[k - 1] * (∑(a[j] | j: 0 ≤ j < k - 1) + a[k - 1])
    //       ( rename bound variable j to i in last sum, 
    //         then combine the two equal terms )
    //   = S(a, k - 1) + 2 * a[k - 1] * ∑(a[i] | i: 0 ≤ i < k - 1) 
    //     + a[k - 1] * a[k - 1]
    //       ( apply definition of U )
    //   = S(a, k - 1) + 2 * a[k - 1] * U(a, k - 1) + a[k - 1] * a[k - 1]
  if k == 0
    then 0 
    else S(a, k - 1) + 2 * a[k - 1] * U(a, k - 1) 
         + a[k - 1] * a[k - 1]
}

ghost function U(a: array<nat>, k: nat): int
requires k <= a.Length
reads a
{
    // We define U(a, k) = ∑(a[i] | i: 0 ≤ i < k)
    // Base case: U(a, 0) = ∑(a[i] | i: 0 ≤ i < 0) 
    //                    = ∑(∅) = 0
    // For k > 0:
    // U(a, k)
    //   = ∑(a[i] | i: 0 ≤ i < k)
    //      ( split domain into i < k - 1 and i = k - 1 )
    //   = ∑(a[i] | i: 0 ≤ i < k - 1) + ∑(a[i] | i: i = k - 1)
    //   = ∑(a[i] | i: 0 ≤ i < k - 1) + a[k - 1]
    //      ( definition of U )
    //   = U(a, k - 1) + a[k - 1]
  if k == 0 then 0 else U(a, k - 1) + a[k - 1]
}

method problem15(a: array<nat>) returns (r: int)
ensures  r == S(a, a.Length)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: true
    //   ( n is a nat; base cases of S and U )
    // 0 ≤ 0 ≤ n ∧ 0 = S(a, 0) ∧ 0 = U(a, 0)
  var s:int, u:int, k:nat := 0, 0, 0;
    // J: 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k)

  while k < n
  invariant 0 <= k <= n && s == S(a, k) && u == U(a, k)
  decreases n - k
  {    
      // J ∧ B ∧ vf = V
      // 0 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ n - k = V
      //   ( use definition of S(a, k + 1) = S(a, k) + 2 * a[k] * U(a, k)
      //     + a[k] * a[k]; substitute S(a, k) for s and U(a, k) for u )
      // 0 ≤ k < n ∧ s + 2 * a[k] * u + a[k] * a[k] = S(a, k + 1) 
      //     ∧ u = U(a, k) ∧ n - k = V
    s := s + 2 * a[k] * u + a[k] * a[k];
      // 0 ≤ k < n ∧ s = S(a, k + 1) ∧ u = U(a, k) ∧ n - k = V
      //   ( use definition of U(a, k + 1) = U(a, k) + a[k]; 
      //     substitute U(a, k) for u )
      // 0 ≤ k < n ∧ s = S(a, k + 1) ∧ u + a[k] = U(a, k + 1) ∧ n - k = V
    u := u + a[k];
      // 0 ≤ k < n ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) ∧ n - k = V
      //   ( prepare for updating k to k + 1 )
      // 0 ≤ k + 1 ≤ n ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ n - k < V
      //   J is preserved and vf has decreased
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ k ≥ n
    //   ( the conditions k ≤ n and k ≥ n imply k = n )
    // s = S(a, n) ∧ u = U(a, n)
  r := s;
    // r = S(a, n)
    //   ( n = a.Length )
    // Q: r = S(a, a.Length)
}