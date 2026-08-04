/* file: ArrayExtrema.dfy
   author: David De Potter
   description: reusable prefix and suffix minimum/maximum specifications
   for integer arrays
*/
  
include "Math.dfy"

module ArrayExtrema {

import opened MathSupport

  //========================================================================
  // Computes the maximum value in the suffix [k,a.Length).
  ghost function SuffixMax(a:array<int>, k:nat): int
    requires 0 < a.Length
    requires k < a.Length
    reads a
    decreases a.Length - k
  {
    if k == a.Length - 1 then
      a[k]
    else
      maximum(a[k], SuffixMax(a,k+1))
  }

  //========================================================================
  // Extending the suffix [k+1,a.Length) to [k,a.Length) adds a[k].
  lemma SuffixMaxStep(a:array<int>, k:nat)
    requires 0 < a.Length
    requires k + 1 < a.Length
    ensures SuffixMax(a,k) == maximum(a[k], SuffixMax(a,k+1))
  {
  }

  //========================================================================
  // Computes the minimum value in the suffix [k,a.Length).
  ghost function SuffixMin(a:array<int>, k:nat): int
    requires 0 < a.Length
    requires k < a.Length
    reads a
    decreases a.Length - k
  {
    if k == a.Length - 1 then
      a[k]
    else
      minimum(a[k], SuffixMin(a,k+1))
  }

  //========================================================================
  // Extending the suffix [k+1,a.Length) to [k,a.Length) adds a[k].
  lemma SuffixMinStep(a:array<int>, k:nat)
    requires 0 < a.Length
    requires k + 1 < a.Length
    ensures SuffixMin(a,k) == minimum(a[k], SuffixMin(a,k+1))
  {
  }

  //========================================================================
  // Computes the maximum value in the prefix [0,k).
  ghost function PrefixMax(a:array<int>, k:nat): int
    requires 0 < k <= a.Length
    reads a
    decreases k
  {
    if k == 1 then
      a[0]
    else
      maximum(PrefixMax(a,k-1), a[k-1])
  }

  //========================================================================
  // Extending the prefix [0,k) to [0,k+1) adds a[k].
  lemma PrefixMaxStep(a:array<int>, k:nat)
    requires 0 < k < a.Length
    ensures PrefixMax(a,k+1) == maximum(PrefixMax(a,k), a[k])
  {
  }

  //========================================================================
  // Computes the minimum value in the prefix [0,k).
  ghost function PrefixMin(a:array<int>, k:nat): int
    requires 0 < k <= a.Length
    reads a
    decreases k
  {
    if k == 1 then
      a[0]
    else
      minimum(PrefixMin(a,k-1), a[k-1])
  }

  //========================================================================
  // Extending the prefix [0,k) to [0,k+1) adds a[k].
  lemma PrefixMinStep(a:array<int>, k:nat)
    requires 0 < k < a.Length
    ensures PrefixMin(a,k+1) == minimum(PrefixMin(a,k), a[k])
  {
  }
}