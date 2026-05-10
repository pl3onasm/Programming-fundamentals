/* file: sol11Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob11, with annotations
   This is exercise 7.13 from the PC reader
*/

function Ord(b: bool): int
{
  if b then 1 else 0
}

function Cnt7(a: array<int>, k: nat := a.Length): int
requires k <= a.Length
reads a
{   
    // We define Cnt7(a, k) = #{ i | 0 ≤ i < k ∧ a[i] = 7 }
    // That is, Cnt7(a, k) counts how many of the first k elements equal 7.
    // Base case: Cnt7(a, 0) = #{ i | 0 ≤ i < 0 ∧ a[i] = 7 } = #∅ = 0
    // For k > 0:
    // Cnt7(a, k) 
    //   = #{ i | 0 ≤ i < k ∧ a[i] = 7 }
    //      ( split domain into 0 ≤ i < k - 1 and i = k - 1 )    
    //   = #{ i | 0 ≤ i < k-1 ∧ a[i] = 7 } + #{ i | i = k - 1 ∧ a[i] = 7 }
    //      ( definition of Cnt7 and Ord )
    //   = Cnt7(a, k-1) + Ord(a[k-1] = 7)
  if k == 0 then 0 else Cnt7(a, k - 1) + Ord(a[k - 1] == 7)
}

method problem11(a: array<int>) returns (r: int)
ensures  r == Cnt7(a)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n ≥ 0
    //   ( arithmetic; base case of Cnt7 )
    // 0 ≤ 0 ≤ n ∧ 0 = Cnt7(a, 0)
  var x:int, k:nat := 0, 0;
    // J: 0 ≤ k ≤ n ∧ x = Cnt7(a, k)
  
  while k < n
  invariant 0 <= k <= n && x == Cnt7(a, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 0 ≤ k < n ∧ x = Cnt7(a, k) ∧ n - k = V 
      //   ( use definition of Cnt7(a, k + 1) = Cnt7(a, k) + Ord(a[k] = 7);
      //     substitute Cnt7(a, k) for x )
      // 0 ≤ k < n ∧ x + Ord(a[k] = 7) = Cnt7(a, k + 1) ∧ n - k = V
    x := x + Ord(a[k] == 7);
      // 0 ≤ k < n ∧ x = Cnt7(a, k + 1) ∧ n - k = V 
      //   ( prepare for updating k to k + 1 )
      // 0 ≤ k + 1 ≤ n ∧ x = Cnt7(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 0 ≤ k ≤ n ∧ x = Cnt7(a, k) ∧ n - k < V
      //   J is preserved and vf has decreased
  }

    // J ∧ ¬B
    // 0 ≤ k ≤ n ∧ x = Cnt7(a, k) ∧ k ≥ n
    //   ( k ≤ n ∧ k ≥ n implies k = n )
    // x = Cnt7(a, n)
    // x = Cnt7(a)
  r := x;
    // Q: r = Cnt7(a)
}