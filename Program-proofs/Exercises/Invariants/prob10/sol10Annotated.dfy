/* file: sol10Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob10, with annotations
   This is exercise 7.12 from the PC reader
*/

ghost function dotProd(a: array<real>, b: array<real>, k: nat := a.Length): real
requires a.Length == b.Length
requires k <= a.Length
reads a, b
{
    // We define dotProd(a, b, k) = ∑(a[i] * b[i] | i: 0 ≤ i < k)
    // Base case: dotProd(a, b, 0) = ∑(a[i] * b[i] | i: 0 ≤ i < 0) = ∑(∅) = 0
    // For k > 0:
    // dotProd(a, b, k)
    //  = ∑(a[i] * b[i] | i: 0 ≤ i < k)
    //     ( split domain into 0 ≤ i < k - 1 and i = k - 1 )
    //  = ∑(a[i] * b[i] | i: 0 ≤ i < k - 1) + a[k - 1] * b[k - 1]
    //     ( definition of dotProd )
    //  = dotProd(a, b, k - 1) + a[k - 1] * b[k - 1]
  if k == 0 then 0.0 else dotProd(a, b, k - 1) + a[k - 1] * b[k - 1]
}

method problem10(a: array<real>, b: array<real>) returns (r: real)
requires a.Length == b.Length
ensures  r == dotProd(a, b)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n ≥ 0
    //   ( arithmetic; base case of dotProd )
    // 0 ≤ 0 ≤ n ∧ 0 = dotProd(a, b, 0)
  var x:real, k:nat := 0.0, 0;
    // J: 0 ≤ k ≤ n ∧ x = dotProd(a, b, k)
  
  while k < n
  invariant 0 <= k <= n && x == dotProd(a, b, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k < n ∧ x = dotProd(a, b, k) ∧ n - k = V 
      //   ( use definition of dotProd(a, b, k + 1) = dotProd(a, b, k) + a[k] * b[k];
      //     substitute dotProd(a, b, k) for x )
      // 0 ≤ k < n ∧ x + a[k] * b[k] = dotProd(a, b, k + 1) ∧ n - k = V 
    x := x + a[k] * b[k];
      // 0 ≤ k < n ∧ x = dotProd(a, b, k + 1) ∧ n - k = V 
      //   ( prepare for updating k to k + 1 )
      // 0 ≤ k + 1 ≤ n ∧ x = dotProd(a, b, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 0 ≤ k ≤ n ∧ x = dotProd(a, b, k) ∧ n - k < V
      //   J is preserved and vf has decreased
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ x = dotProd(a, b, k) ∧ k ≥ n
    //   ( k ≤ n ∧ k ≥ n implies k = n )
    // x = dotProd(a, b, n)
    // x = dotProd(a, b)
  r := x;
    // Q: r = dotProd(a, b)

}