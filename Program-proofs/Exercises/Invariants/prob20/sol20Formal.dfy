/*  file: sol20Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, invariants,
    fully formal solution to prob20
    NOTE: This proof is machine verified end to end against the
    recursive specification SumsProduct(a,a.Length). Since Dafny does
    not have primitive sum and product operators over quantified domains,
    SumsProduct is used as a recursive Dafny formalization of the
    mathematical specification of the problem. The recursive definitions
    below justify the constant-time updates performed in each loop
    iteration, which yields a linear-time method overall.
*/

include "../../Support/ArrayAggregates.dfy"
import opened IntArrayAggregates

//========================================================================
// Computes the sum of a[i] * a[j] over all pairs i,j satisfying
// 0 ≤ i ≤ j < k, that is: ∑(a[i] * a[j] | i,j: 0 ≤ i ≤ j < k)
ghost function ProductPairsSum(a:array<int>, k:nat): int
  requires k <= a.Length
  reads a
  decreases k
{
  if k == 0 then 0
            else ProductPairsSum(a,k-1) + a[k-1] * PrefixSum(a,k)
}

//========================================================================
// Computes the product over all prefix lengths i < k of the product-pairs
// sum over the prefix [0,i), that is:
//   ∏( ∑(a[j] * a[h] | j,h: 0 ≤ j ≤ h < i) | i: 0 ≤ i < k)
ghost function SumsProduct(a:array<int>, k:nat): int
  requires k <= a.Length
  reads a
  decreases k
{
  if k == 0 then 1
            else SumsProduct(a,k-1) * ProductPairsSum(a,k-1)
}

//========================================================================
// Computes ∏( ∑(a[j] * a[h] | j,h: 0 ≤ j ≤ h < i) | i: 0 ≤ i < a.Length)
method problem20(a:array<int>)
returns (r:int)
ensures r == SumsProduct(a,a.Length)
{
  var k:nat := 0;

    // Initially, the prefix [0,0) is empty. The empty product is 1,
    // the empty product-pairs sum is 0, and the empty prefix sum is 0.
  var p:int := 1;
  var s:int := 0;
  var u:int := 0;

  while k < a.Length
    invariant k <= a.Length
      // p is the product of product-pairs sums for all prefix lengths
      // below k, s is the product-pairs sum for the current prefix
      // [0,k), and u is the sum of the current prefix.
    invariant p == SumsProduct(a,k)
    invariant s == ProductPairsSum(a,k)
    invariant u == PrefixSum(a,k)
    decreases a.Length - k
  {
      // Unfold SumsProduct at k+1: the new product is obtained by
      // multiplying the old product by the factor for prefix length k
    p := p * s;

      // Extend the prefix sum to the larger prefix [0,k+1). The new
      // prefix sum is the old one plus the new value a[k]
    PrefixSumStep(a,k);
    u := u + a[k];

      // Unfold ProductPairsSum at k+1: the new contribution consists
      // of all pairs whose second index is k
    s := s + a[k] * u;

      // Increase the prefix length by one
    k := k + 1;
  }

    // At loop exit, k = a.Length, so the invariant gives
    // p = SumsProduct(a,a.Length)
  r := p;
}