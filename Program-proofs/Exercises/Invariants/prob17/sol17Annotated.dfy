/* file: sol17Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob17, with annotations
*/

function mxm(x: int, y: int): int
{
  if x >= y then x else y
}

function mnm(x: int, y: int): int
{
  if x <= y then x else y
}

ghost function S(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
    // We define S(a, x) 
    //   = Max (Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ k) | k: 0 ≤ k < x)
    // Base case: 
    //   S(a, 1) = Max (Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ k) | k: 0 ≤ k < 1)
    //           = Max (Min (a[0] + a[0])) = a[0] + a[0] = 2 * a[0]
    // For x > 1:
    // S(a, x)
    //   = Max (Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ k) | k: 0 ≤ k < x)
    //     ( split domain into 0 ≤ k < x - 1 and k = x - 1 )
    //   = mxm (Max (Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ k) | k: 0 ≤ k < x - 1),
    //         Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j ≤ x - 1))
    //     ( apply definition of S to first mxm term; rewrite second term 
    //       to comply with definition of U; use half-open range )
    //   = mxm (S(a, x - 1), U(a, x))
  if x == 1 then 2 * a[0] else mxm(S(a, x - 1), U(a, x))
}

ghost function U(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
    // We define U(a, x) = Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j < x)
    // Base case: 
    //   U(a, 1) = Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j < 1) 
    //           = Min (a[0] + a[0]) = a[0] + a[0] = 2 * a[0]
    // For x > 1:
    // U(a, x)
    //   = Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j < x)
    //     ( split domain into 0 ≤ i ≤ j < x - 1 and j = x - 1 )
    //   = mnm (Min (a[i] + a[j] | i,j: 0 ≤ i ≤ j < x - 1), 
    //          Min (a[i] + a[x - 1] | i: 0 ≤ i < x))
    //     ( apply definition of U to first mnm term; 
    //       factor out constant a[x - 1] from second mnm term )
    //   = mnm (U(a, x - 1), a[x - 1] + Min (a[i] | i: 0 ≤ i < x))
    //     ( apply definition of Z to last term )
    //   = mnm (U(a, x - 1), a[x - 1] + Z(a, x))
  if x == 1 then 2 * a[0] else mnm(U(a, x - 1), a[x - 1] + Z(a, x))
}

ghost function Z(a: array<int>, x: nat): int
requires 1 <= x <= a.Length
reads a
{
    // We define Z(a, x) = Min (a[i] | i: 0 ≤ i < x)
    // Base case: Z(a, 1) = Min (a[i] | i: 0 ≤ i < 1) 
    //                    = Min (a[0]) = a[0]
    // For x > 1:
    // Z(a, x)
    //   = Min (a[i] | i: 0 ≤ i < x)
    //     ( split domain into i < x - 1 and i = x - 1 )
    //   = mnm (Min (a[i] | i: 0 ≤ i < x - 1), a[x - 1])
    //     ( apply definition of Z to first mnm term )
    //   = mnm (Z(a, x - 1), a[x - 1])
  if x == 1 then a[0] else mnm(Z(a, x - 1), a[x - 1])
} 

method problem17(a: array<int>) returns (r: int)                                                        
requires a.Length > 0
ensures  r == S(a, a.Length)
{
  var n:nat := a.Length;

    // Initialization to establish J before the loop
    // P: n > 0
    //   ( arithmetic; base cases of S, U, and Z )
    // 1 ≤ 1 ≤ n ∧ 2 * a[0] == S(a, 1) ∧ 2 * a[0] == U(a, 1) 
    //   ∧ a[0] == Z(a, 1)
  var s:int, u:int, z:int, k:nat := 2 * a[0], 2 * a[0], a[0], 1;
    // J: 1 ≤ k ≤ n ∧ s == S(a, k) ∧ u == U(a, k) ∧ z == Z(a, k)

  while k < n
  invariant 1 <= k <= n
  invariant s == S(a, k) && u == U(a, k) && z == Z(a, k)
  decreases n - k
  {
      // J ∧ B ∧ vf = V
      // 1 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) 
      //   ∧ z = Z(a, k) ∧ n - k = V
      //   ( use definition of Z to obtain 
      //     Z(a, k + 1) = mnm(Z(a, k), a[k]) )
      // 1 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k) 
      //   ∧ Z(a, k + 1) = mnm(z, a[k]) ∧ n - k = V
    z := mnm(z, a[k]);
      //   ( use definition of U to obtain 
      //     U(a, k + 1) = mnm(U(a, k), a[k] + Z(a, k + 1)) )
      // 1 ≤ k < n ∧ s = S(a, k) ∧ U(a, k + 1) = mnm(u, a[k] + z) 
      //   ∧ z = Z(a, k + 1) ∧ n - k = V
    u := mnm(u, a[k] + z);
      // 1 ≤ k < n ∧ s = S(a, k) ∧ u = U(a, k + 1) 
      //   ∧ z = Z(a, k + 1) ∧ n - k = V
      //   ( use definition of S to obtain 
      //     S(a, k + 1) = mxm(S(a, k), U(a, k + 1)) )
      // 1 ≤ k < n ∧ S(a, k + 1) = mxm(s, u) ∧ u = U(a, k + 1) 
      //   ∧ z = Z(a, k + 1) ∧ n - k = V
    s := mxm(s, u);
      // 1 ≤ k < n ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) 
      //   ∧ z = Z(a, k + 1) ∧ n - k = V
      //   ( prepare to update k to k + 1 )
      // 1 ≤ k + 1 ≤ n ∧ s = S(a, k + 1) ∧ u = U(a, k + 1) 
      //   ∧ z = Z(a, k + 1) ∧ n - (k + 1) < V
    k := k + 1;
      // 1 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) 
      //   ∧ z = Z(a, k) ∧ n - k < V
      //   J is preserved and the variant function vf has decreased
  }

    // J ∧ ¬B
    // 1 ≤ k ≤ n ∧ s = S(a, k) ∧ u = U(a, k) ∧ z = Z(a, k) ∧ k ≥ n
    //   ( k ≤ n and k ≥ n imply k = n )
    // s = S(a, n) ∧ u = U(a, n) ∧ z = Z(a, n)
  r := s;
    // r = S(a, n)
    //   ( n = a.Length )
    // Q: r = S(a, a.Length)
}