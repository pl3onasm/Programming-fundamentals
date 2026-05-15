/* file: sol08Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob08, with annotations
   This is exercise 7.10b from the PC reader
*/

function max(x: int, y: int): int
{
  if x >= y then x else y
}

ghost function Max(a: array<int>, k: nat := a.Length): int
requires 0 < k <= a.Length
reads a
{
    // We define Max(a, k) = Max(a[i] | 0 ≤ i < k}
    // Base case: Max(a, 1) = Max(a[i] | 0 ≤ i < 1) = a[0]
    // For k > 1:
    // Max(a, k)
    //  = Max(a[i] | 0 ≤ i < k)
    //     ( split domain into 0 ≤ i < k - 1 and i = k - 1 )
    //  = max{Max(a[i] | 0 ≤ i < k - 1), a[k - 1]}
    //     ( definition of Max )
    //  = max{Max(a, k - 1), a[k - 1]}
  if k == 1 then a[0] else max(Max(a, k - 1), a[k - 1])
}

method problem08(a: array<int>) returns (r:int)
requires a.Length > 0
ensures r == Max(a)
{ 
  var n := a.Length; 
    // Initialization to establish J before the loop
    // P: n > 0
    //   ( arithmetic; base case of Max )
    // 1 ≤ 1 ≤ n ∧ a[0] = Max(a, 1)
  var k := 1;
  r := a[0];
    // J: 1 ≤ k ≤ n ∧ r = Max(a, k)

  while k != n
  invariant 1 <= k <= n && r == Max(a, k)
  decreases n - k   // J ∧ B ⇒ vf = n - k > 0
  {
      // J ∧ B ∧ vf = V
      // 1 ≤ k < n ∧ r = Max(a, k) ∧ n - k = V > 0
      //   ( use definition of Max(a, k + 1) = max{Max(a, k), a[k]};
      //     substitute Max(a, k) for r )
      // 1 ≤ k < n ∧ max{r, a[k]} = Max(a, k + 1) ∧ n - k = V > 0
    r := max(r, a[k]);
      // 1 ≤ k < n ∧ r = Max(a, k + 1) ∧ n - k = V > 0
      //   ( prepare for updating k to k + 1 )
      // 1 ≤ k + 1 ≤ n ∧ r = Max(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 1 ≤ k ≤ n ∧ r = Max(a, k) ∧ n - k < V
      //   J is preserved and vf has decreased
  }

    // J ∧ ¬B
    // 1 ≤ k ≤ n ∧ r = Max(a, k) ∧ k = n
    // 1 ≤ n ≤ n ∧ r = Max(a, n)
    // Q: r = Max(a)
}