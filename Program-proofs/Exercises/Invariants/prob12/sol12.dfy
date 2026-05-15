/* file: sol12.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob12
   This is exercise 7.14 from the PC reader
*/

ghost function B(a: array<int>, k: nat := a.Length): int
requires k <= a.Length
reads a
{
    // We define B(a, k) = ∑(a[i] * a[j] | 0 ≤ i < j < k) 
    // That is, B(a, k) sums the products of all pairs of the first k elements.
    // Base case: B(a, 0) = ∑(a[i] * a[j] | 0 ≤ i < j < 0) = ∑(a[i] * a[j] | i, j ∈ ∅) = 0
    // For k > 0:
    // B(a, k)
    //   = ∑(a[i] * a[j] | 0 ≤ i < j < k) 
    //      ( split domain into 0 ≤ i < j < k - 1 and j = k - 1 )
    //   = ∑(a[i] * a[j] | 0 ≤ i < j < k - 1) + ∑(a[i] * a[j] | 0 ≤ i < k - 1 ∧ j = k - 1)  
    //      ( definition of B )
    //   = B(a, k - 1) + ∑(a[i] * a[k - 1] | 0 ≤ i < k - 1)
    //      ( arithmetic )
    //   = B(a, k - 1) + a[k - 1] * ∑(a[i] | 0 ≤ i < k - 1)
    //      ( definition of C )
    //   = B(a, k - 1) + a[k - 1] * C(a, k - 1)
  if k == 0 then 0 else B(a, k - 1) + a[k - 1] * C(a, k - 1)
}

ghost function C(a: array<int>, k: nat := a.Length): int
requires k <= a.Length
reads a
{  
    // We define C(a, k) = ∑(a[i] | 0 ≤ i < k)
    // Base case: C(a, 0) = ∑(a[i] | 0 ≤ i < 0) = ∑(∅) = 0
    // For k > 0:
    // C(a, k)
    //   = ∑(a[i] | 0 ≤ i < k)
    //      ( split domain into 0 ≤ i < k - 1 and i = k - 1 )
    //   = ∑(a[i] | 0 ≤ i < k - 1) + ∑(a[i] | i = k - 1)
    //      ( definition of C )
    //   = C(a, k - 1) + a[k - 1]
  if k == 0 then 0 else C(a, k - 1) + a[k - 1]
}

method problem12(a: array<int>) returns (r: int)
ensures  r == B(a)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n ≥ 0
    //   ( arithmetic; base case of B and C )
    // 0 ≤ 0 ≤ n ∧ 0 = B(a, 0) ∧ 0 = C(a, 0)
  var b:int, c:int, k:nat := 0, 0, 0;
    // J: 0 ≤ k ≤ n ∧ b = B(a, k) ∧ c = C(a, k)
  
  while k < n
  invariant 0 <= k <= n && b == B(a, k) && c == C(a, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k < n ∧ b = B(a, k) ∧ c = C(a, k) ∧ n - k = V 
      //   ( use definition of B(a, k + 1) = B(a, k) + C(a, k) * a[k];
      //     substitute B(a, k) for b and C(a, k) for c )
      // 0 ≤ k < n ∧ b + c * a[k] = B(a, k + 1) ∧ c = C(a, k) ∧ n - k = V 
    b := b + c * a[k];
      // 0 ≤ k < n ∧ b = B(a, k + 1) ∧ c = C(a, k) ∧ n - k = V
      //    ( use definition of C(a, k + 1) = C(a, k) + a[k];
      //      substitute C(a, k) for c )
      // 0 ≤ k < n ∧ b = B(a, k + 1) ∧ c + a[k] = C(a, k + 1) ∧ n - k = V
    c := c + a[k];
      // 0 ≤ k < n ∧ b = B(a, k + 1) ∧ c = C(a, k + 1) ∧ n - k = V 
      //   ( prepare for updating k to k + 1 )
      // 0 ≤ k + 1 ≤ n ∧ b = B(a, k + 1) ∧ c = C(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 0 ≤ k ≤ n ∧ b = B(a, k) ∧ c = C(a, k) ∧ n - k < V
      //   J is preserved and vf has decreased
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ b = B(a, k) ∧ c = C(a, k) ∧ k ≥ n
    //   ( k ≤ n ∧ k ≥ n implies k = n )
    // b = B(a, n) ∧ c = C(a, n)
    // b = B(a) ∧ c = C(a)
  r := b;
    // Q: r = B(a)
}