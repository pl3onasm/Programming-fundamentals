/* file: sol09Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob09, with annotations
   This is exercise 7.11 from the PC reader
*/

function Prod(a: array<real>, k: nat := a.Length): real
requires k <= a.Length
reads a
{
    // We define Prod(a, k) = ∏(a[i] | 0 ≤ i < k)
    // Base case: Prod(a, 0) = ∏(a[i] | 0 ≤ i < 0) = ∏(∅) = 1
    // For k > 0:
    // Prod(a, k)
    //  = ∏(a[i] | 0 ≤ i < k)
    //     ( split domain into 0 ≤ i < k - 1 and i = k - 1 )
    //  = (∏(a[i] | 0 ≤ i < k - 1)) * a[k - 1]
    //     ( definition of Prod )
    //  = Prod(a, k - 1) * a[k - 1]
  if k == 0 then 1.0 else Prod(a, k - 1) * a[k - 1]
}

method problem09(a: array<real>) returns (p: real)
ensures p == Prod(a)
{
  var n:nat := a.Length;
    // Initialization to establish J before the loop
    // P: true
    //   ( arithmetic; base case of Prod )
    // 0 ≤ 0 ≤ n ∧ Prod(a, 0) = 1
  var x:real, k:nat := 1.0, 0;
    // J: 0 ≤ k ≤ n ∧ x = Prod(a, k)

  while k != n
  invariant 0 <= k <= n && x == Prod(a, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k < n ∧ x = Prod(a, k) ∧ n - k = V > 0
      //   ( use definition of Prod(a, k + 1) = Prod(a, k) * a[k];
      //     substitute Prod(a, k) for x )
      // 0 ≤ k < n ∧ x * a[k] = Prod(a, k + 1) ∧ n - k = V > 0
    x := x * a[k];
      // 0 ≤ k < n ∧ x = Prod(a, k + 1) ∧ n - k = V > 0
      //   ( prepare for updating k to k + 1 )
      // 0 ≤ k + 1 ≤ n ∧ x = Prod(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 0 ≤ k ≤ n ∧ x = Prod(a, k) ∧ n - k < V
      //   J is preserved and vf has decreased
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ x = Prod(a, k) ∧ k = n
    // x = Prod(a, n)
  p := x;
    // Q: p = Prod(a)
}
