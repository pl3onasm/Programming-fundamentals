/* file: sol18Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob18, with annotations
*/

ghost function S(a: array<nat>, x: nat): int
requires x <= a.Length
reads a
{
    // We define S(a, x) = ∑(a[i] + a[j] | i,j: 0 ≤ i < j < x ∧ a[j] % 2 = 1)
    // Base case: 
    //   S(a, 0) = ∑(a[i] + a[j] | i,j: 0 ≤ i < j < 0 ∧ a[j] % 2 = 1) 
    //           = ∑(∅) = 0
    // For x > 0:
    // S(a, x)
    //   = ∑(a[i] + a[j] | i,j: 0 ≤ i < j < x ∧ a[j] % 2 = 1)
    //      ( split domain into j < x - 1 and j = x - 1 )
    //   = ∑(a[i] + a[j] | i,j : 0 ≤ i < j < x - 1 ∧ a[j] % 2 = 1) 
    //     + ∑(a[i] + a[x - 1] | i: 0 ≤ i < x - 1 ∧ a[x - 1] % 2 = 1)
    //      ( apply definition of S to first sum )
    //   = S(a, x - 1) 
    //     + ∑(a[i] + a[x - 1] | i: 0 ≤ i < x - 1 ∧ a[x - 1] % 2 = 1)
    //      ( take condition a[x - 1] % 2 = 1 out of sum )
    //   = S(a, x - 1) + (a[x - 1] % 2 = 1 ? ∑(a[i] + a[x - 1] | i: 0 ≤ i < x - 1) : 0)
    //      ( simplify by rewriting the condition as a multiplication by 0 or 1 )
    //   = S(a, x - 1) + (a[x - 1] % 2) * ∑(a[i] + a[x - 1] | i: 0 ≤ i < x - 1)
    //      ( factor out constant a[x - 1] from sum )
    //   = S(a, x - 1) + (a[x - 1] % 2) * ((x - 1) * a[x - 1] + ∑(a[i] | i: 0 ≤ i < x - 1))
    //      ( apply definition of U )
    //   = S(a, x - 1) + (a[x - 1] % 2) * ((x - 1) * a[x - 1] + U(a, x - 1))
  if x == 0 then 0 else S(a, x - 1) + (a[x - 1] % 2) * ((x - 1) * a[x - 1] + U(a, x - 1))
}

ghost function U(a: array<nat>, x: nat): int
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

method problem18(a: array<nat>) returns (r: int)
ensures r == S(a, a.Length)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: true
    //   (n is a nat; base cases of S and U )
    // 0 ≤ 0 ≤ n ∧ 0 = S(a, 0) ∧ 0 = U(a, 0)
  var s:int, u:int, k:nat := 0, 0, 0;
    // J: 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k)

  while k < n
  invariant 0 <= k <= n
  invariant s == S(a, k) && u == U(a, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) ∧ n - k = V
      //   ( use definition of S to obtain 
      //     S(a, k + 1) = S(a, k) + (a[k] % 2) * ((k * a[k]) + U(a, k)) )
      // 0 ≤ k < n ∧ S(a, k + 1) = s + (a[k] % 2) * ((k * a[k]) + u) 
      //   ∧ u = U(a, k) ∧ n - k = V
    s := s + (a[k] % 2) * (k * a[k] + u);
      // 0 ≤ k < n ∧ S(a, k + 1) = s ∧ u = U(a, k) ∧ n - k = V
      //   ( use definition of U to obtain U(a, k + 1) = U(a, k) + a[k] )
      // 0 ≤ k < n ∧ S(a, k + 1) = s ∧ u + a[k] = U(a, k + 1) ∧ n - k = V
    u := u + a[k];
      // 0 ≤ k < n ∧ S(a, k + 1) = s ∧ u = U(a, k + 1) ∧ n - k = V
      //   ( prepare for updating k to k + 1 )
      // 0 ≤ k + 1 ≤ n ∧ S(a, k + 1) = s ∧ u = U(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 0 ≤ k ≤ n ∧ S(a, k) = s ∧ u = U(a, k) ∧ n - k < V
      //   J is preserved and the variant function vf has decreased
  }
    
    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ k >= n
    //   ( k ≤ n ∧ k >= n implies k = n )
    // S(a, n) = s ∧ U(a, n) = u
  r := s;
    // r = S(a, n)
    //   ( n = a.Length )
    // Q: r = S(a, a.Length)
}