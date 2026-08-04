/*  file: sol19FormalPrefix.dfy
    author: David De Potter
    description: extra practice in Dafny, invariants,
    fully formal solution to prob19
    NOTE: This proof is machine verified end to end against the
    recursive specification TripleMax(a,a.Length). Since Dafny does
    not have a primitive maximum operator over quantified domains,
    TripleMax is used as a recursive Dafny formalization of the maximum
    value of a[i] + a[j] + a[h] over all triples i,j,h satisfying
    0 ≤ i ≤ j < n ∧ i ≤ h < n. The lemmas below formally justify the
    constant-time updates performed in each loop iteration, which
    yields a linear-time method overall.

    This prefix version mirrors the PC-style derivation. It scans the
    array from left to right and maintains the best single value, pair
    value, and triple value in the current prefix.
*/

include "../../Support/ArrayExtrema.dfy"
include "../../Support/Math.dfy"

import opened ArrayExtrema
import opened MathSupport

//========================================================================
// Computes the maximum value of a[i] + a[j] over all pairs i,j satisfying
// 0 ≤ i ≤ j < k
ghost function PairMax(a:array<int>, k:nat): int
  requires 0 < k <= a.Length
  reads a
  decreases k
{
  if k == 1 then
    2 * a[0]
  else
    maximum(PairMax(a,k-1), a[k-1] + PrefixMax(a,k))
}

//========================================================================
// Computes the maximum value of a[i] + a[j] + a[h] over all triples i,j,h
// satisfying 0 ≤ i ≤ j < k ∧ i ≤ h < k
ghost function TripleMax(a:array<int>, k:nat): int
  requires 0 < k <= a.Length
  reads a
  decreases k
{
  if k == 1 then
    3 * a[0]
  else
    maximum(TripleMax(a,k-1), a[k-1] + PairMax(a,k))
}

//========================================================================
// Extending the prefix [0,k) to [0,k+1) adds the new index k. A new best
// pair either was already present in [0,k), or has second index k. In the
// latter case, its value is a[i] + a[k], and the best first index i is
// obtained from PrefixMax(a,k+1).
lemma PairMaxStep(a:array<int>, k:nat)
  requires 0 < k < a.Length
  ensures PairMax(a,k+1) 
       == maximum(PairMax(a,k), a[k] + PrefixMax(a,k+1))
{
}

//========================================================================
// Extending the prefix [0,k) to [0,k+1) adds the new index k. A new best
// triple either was already present in [0,k), or has middle index k. In
// the latter case, its value is a[i] + a[k] + a[h], and the best choices
// for i and h are captured together by PairMax(a,k+1).
lemma TripleMaxStep(a:array<int>, k:nat)
  requires 0 < k < a.Length
  ensures TripleMax(a,k+1) 
       == maximum(TripleMax(a,k), a[k] + PairMax(a,k+1))
{
}

//========================================================================
// Computes the maximum value of a[i] + a[j] + a[h] over all triples i,j,h
// satisfying 0 ≤ i ≤ j < a.Length ∧ i ≤ h < a.Length
method problem19(a:array<int>)
returns (r:int)
requires 0 < a.Length
ensures r == TripleMax(a,a.Length)
{
  var k:nat := 1;

    // Initially, the prefix [0,1) contains only index 0
  var z:int := a[0];
  var u:int := 2 * a[0];
  var s:int := 3 * a[0];

  while k < a.Length
    invariant 1 <= k <= a.Length
      // z is the best single value in the current prefix [0,k),
      // u is the best pair value, and s is the best triple value
    invariant z == PrefixMax(a,k)
    invariant u == PairMax(a,k)
    invariant s == TripleMax(a,k)
    decreases a.Length - k
  {
      // Extend the prefix maximum to the larger prefix [0,k+1). The new
      // maximum is either the old prefix maximum or the new value a[k].
    PrefixMaxStep(a,k);
    z := maximum(z, a[k]);

      // Extend the pair maximum to the larger prefix [0,k+1). The new
      // maximum is either the old pair maximum, or the best pair whose
      // second index is k.
    PairMaxStep(a,k);
    u := maximum(u, a[k] + z);

      // Extend the triple maximum to the larger prefix [0,k+1). The new
      // maximum is either the old triple maximum, or the best triple
      // whose middle index is k.
    TripleMaxStep(a,k);
    s := maximum(s, a[k] + u);

      // Increase the prefix length by one.
    k := k + 1;
  }

    // At loop exit, k = a.Length, so the invariant gives
    // s = TripleMax(a,a.Length)
  r := s;
}