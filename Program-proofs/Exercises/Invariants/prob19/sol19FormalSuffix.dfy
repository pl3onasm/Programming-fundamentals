/*  file: sol19FormalSuffix.dfy
    author: David De Potter
    description: extra practice in Dafny, invariants,
    alternative fully formal solution to prob19
    NOTE: This proof is machine verified end to end against the
    recursive specification TripleMax(a,0). Since Dafny does not have
    a primitive maximum operator over quantified domains, TripleMax is
    used as a recursive Dafny formalization of the maximum value of
    a[i] + a[j] + a[h] over all triples i,j,h satisfying
    0 ≤ i ≤ j < n ∧ i ≤ h < n. The lemmas below formally justify the
    constant-time updates performed in each loop iteration, which
    yields a linear-time method overall.

    This alternative suffix version scans the array from right to left.
    For each fixed first index i, the best choices for both j and h are
    obtained from the suffix maximum over [i,a.Length).
*/

include "../../Support/ArrayExtrema.dfy"
include "../../Support/Math.dfy"

import opened ArrayExtrema
import opened MathSupport

//========================================================================
// Computes the maximum value of a[i] + a[j] + a[h] over all triples
// i,j,h satisfying k ≤ i ≤ j < a.Length ∧ i ≤ h < a.Length.
// For a fixed first index i, both j and h range over the suffix
// [i,a.Length). Hence the best choices for j and h both have value
// SuffixMax(a,i), so the best triple with first index i has value
// a[i] + 2*SuffixMax(a,i).
ghost function TripleMax(a:array<int>, k:nat): int
  requires 0 < a.Length
  requires k < a.Length
  reads a
  decreases a.Length - k
{
  if k == a.Length - 1 then
    3 * a[k]
  else
    maximum(a[k] + 2 * SuffixMax(a,k), TripleMax(a,k+1))
}

//========================================================================
// Extending the suffix of possible first indices from [k+1,a.Length) to
// [k,a.Length) adds the new first index k. The new maximum is either the
// old triple maximum, or the best triple whose first index is k.
lemma TripleMaxStep(a:array<int>, k:nat)
  requires 0 < a.Length
  requires k + 1 < a.Length
  ensures TripleMax(a,k) 
      ==  maximum(a[k] + 2 * SuffixMax(a,k), TripleMax(a,k+1))
{
}

//========================================================================
// Computes the maximum value of a[i] + a[j] + a[h] over all triples
// i,j,h satisfying 0 ≤ i ≤ j < a.Length ∧ i ≤ h < a.Length.
method problem19(a:array<int>)
returns (r:int)
requires 0 < a.Length
ensures r == TripleMax(a,0)
{
  var k:nat := a.Length - 1;

    // Initially, the suffix [k,a.Length) contains only the last index,
    // so the only possible triple is i = j = h = k
  var u:int := a[k];
  r := 3 * a[k];

  while k > 0
    invariant k < a.Length
      // u is the best single value in the current suffix [k,a.Length),
      // while r is the best triple value whose first index lies in
      // that suffix
    invariant u == SuffixMax(a,k)
    invariant r == TripleMax(a,k)
    decreases k
  {
      // Extend the suffix one position to the left by adding the new
      // index k-1
    k := k - 1;

      // Extend the suffix maximum to the larger suffix [k,a.Length).
      // The new maximum is either the old suffix maximum or the new
      // value a[k]
    SuffixMaxStep(a,k);
    u := maximum(a[k], u);

      // Extend the triple maximum to the larger suffix [k,a.Length).
      // The new maximum is either the old triple maximum, or the best
      // triple whose first index is k
    TripleMaxStep(a,k);
    r := maximum(a[k] + 2 * u, r);
  }
}