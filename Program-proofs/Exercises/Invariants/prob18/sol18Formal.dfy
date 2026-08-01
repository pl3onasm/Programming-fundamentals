/*  file: sol18Formal.dfy
    author: David De Potter
    description: extra practice in Dafny, invariants,
    fully formal solution to prob18
    NOTE: This proof is machine verified end to end against the
    recursive specification PairSum(a,a.Length). Since Dafny does not
    have a primitive sigma operator, PairSum is used as a direct recursive
    formalization of the original nested-sum sigma expression over all
    pairs 0 ≤ i < j < n. The lemmas below formally justify the
    constant-time updates performed in each loop iteration, which yields
    a linear-time method overall.
*/

include "../../FormalSupport.dfy"
import opened ArrayAggregates

//========================================================================
// Computes the sum of an inner sum where the second index is fixed at j 
// and the first index runs over [0, k): ∑(a[i] + a[j] | i: 0 ≤ i < k)
ghost function InnerSum(a:array<nat>, j:nat, k:nat): int
  requires k <= j < a.Length
  reads a
{
  if k == 0 then 0 else InnerSum(a,j,k-1) + a[k-1] + a[j]
}

//========================================================================
// A direct formalization of the original nested-sum sigma expression over
// all pairs 0 ≤ i < j < k. For every j, the inner sum is computed by 
// summing over all i < j. The factor (a[j] % 2), which is either 0 or 1, 
// ensures that only odd a[j] contribute to the sum.
ghost function PairSum(a:array<nat>, k:nat): int
  requires k <= a.Length
  reads a
{
  if k == 0 then 0 
            else PairSum(a,k-1) + (a[k-1] % 2) * InnerSum(a,k-1,k-1)
}

//========================================================================
// Splitting each term a[i] + a[j] into the varying part a[i] and the 
// repeated constant part a[j] yields the formula used for the linear-time 
// update:  ∑(a[i] + a[j] | 0 ≤ i < k) = PrefixSum(a,k) + k * a[j]
lemma InnerSumFormula(a:array<nat>, j:nat, k:nat)
  requires k <= j < a.Length
  ensures InnerSum(a,j,k) == PrefixSum(a,k) + k * a[j]
  decreases k
{
  if k > 0 
  {
      // Apply the induction hypothesis to the shorter inner sum
      // over the range [0,k-1)
    InnerSumFormula(a,j,k-1);

      // Unfolding InnerSum at k adds the final term a[k-1] + a[j].
      // Unfolding PrefixSum at k adds the final value a[k-1].
      // The remaining arithmetic accounts for the additional copy of
      // the constant term a[j].
  }
}

//========================================================================
// Extending the outer sum from k to k+1 adds exactly the contribution
// with second index j = k. InnerSumFormula rewrites that contribution
// into the form used by the loop update.
lemma PairSumStep(a:array<nat>, k:nat)
  requires k < a.Length
  ensures PairSum(a,k+1) 
       == PairSum(a,k) + (a[k] % 2) * (k * a[k] + PrefixSum(a,k))
{
    // Unfolding PairSum at k+1 adds the contribution with second
    // index j = k. The inner contribution is InnerSum(a,k,k).
  InnerSumFormula(a,k,k);

    // InnerSumFormula rewrites that inner contribution as
    // PrefixSum(a,k) + k * a[k], which is exactly the loop update.
}

//========================================================================
// Computes the nested sum in linear time by maintaining the prefix sum
// needed for the contribution of each new second index.
method problem18(a:array<nat>)
returns (r:int)
ensures r == PairSum(a,a.Length)
{
  var s:int, u:int, k:nat := 0,0,0;

  while k < a.Length
    invariant k <= a.Length
      // s is the required sum over all pairs with second index below k,
      // while u is the sum of the first k array elements
    invariant s == PairSum(a,k)
    invariant u == PrefixSum(a,k)
    decreases a.Length - k
  {
      // PairSumStep rewrites PairSum(a,k+1) in terms of PairSum(a,k)
      // and the contribution of the new second index j = k
    PairSumStep(a,k);

      // PrefixSumStep rewrites PrefixSum(a,k+1) in terms of
      // PrefixSum(a,k) and the new final element a[k]
    PrefixSumStep(a,k);

      // Add the contribution of all pairs (i,k) with i < k. If a[k] is
      // even, a[k] % 2 is 0 and the contribution vanishes. If a[k] is
      // odd, a[k] % 2 is 1 and the contribution is
      // PrefixSum(a,k) + k * a[k]
    s := s + (a[k] % 2) * (k * a[k] + u);

      // Extend the maintained prefix sum with the new element a[k]
    u := u + a[k];

      // Move to the next second index
    k := k + 1;
  }

    // At loop exit, k = a.Length, so the invariant gives
    // s = PairSum(a,a.Length)
  r := s;
}
