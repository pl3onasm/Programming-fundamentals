/* file: ArrayAggregates.dfy
   author: David De Potter
   description: reusable array sum and product specifications, with
   separate modules for integer arrays and natural-number arrays
*/

module IntArrayAggregates  
{
  //========================================================================
  // Defines the sum of the array elements in the half-open range [lo,hi).
  // The empty range has sum 0
  ghost function ArraySum(a:array<int>, lo:nat, hi:nat): int
    requires lo <= hi <= a.Length
    reads a
    decreases hi - lo
  {
    if lo == hi then 0
                else ArraySum(a,lo,hi-1) + a[hi-1]
  }

  //========================================================================
  // Proves that extending a summation range by one position adds the new
  // final element a[hi]
  lemma ArraySumAddLast(a:array<int>, lo:nat, hi:nat)
    requires lo <= hi < a.Length
    ensures    ArraySum(a,lo,hi+1) 
            == ArraySum(a,lo,hi) + a[hi]
  {
    // Follows by unfolding ArraySum once at the upper bound hi+1
  }

  //========================================================================
  // Proves that an array sum over [lo,hi) can be split at any intermediate
  // index mid into the sums over [lo,mid) and [mid,hi)
  // NOTE: The lemma is proved by induction on hi-mid. The recursive call
  // explicitly supplies the induction hypothesis for the shorter range
  // [lo,hi-1). Dafny then unfolds the relevant ArraySum definitions and
  // completes the remaining arithmetic reasoning automatically.
  lemma ArraySumSplit(a:array<int>, lo:nat, mid:nat, hi:nat)
    requires lo <= mid <= hi <= a.Length
    ensures    ArraySum(a,lo,hi) 
            == ArraySum(a,lo,mid) + ArraySum(a,mid,hi)
    decreases hi - mid
  {
    if mid < hi 
    {
        // Apply the induction hypothesis to the shorter range [lo,hi-1)
      ArraySumSplit(a,lo,mid,hi-1);

        // Unfold the sums ending at hi. Both the complete range
        // [lo,hi) and the right subrange [mid,hi) extend their
        // corresponding ranges ending at hi-1 by the same element a[hi-1]
    }

      // If mid == hi, the right subrange [mid,hi) is empty, and the
      // required equality follows directly from ArraySum(a,mid,hi) == 0
  }

  //========================================================================
  // Defines the prefix sum of the first k array elements as the array sum
  // over the half-open range [0,k)
  ghost function PrefixSum(a:array<int>, k:nat): int
    requires k <= a.Length
    reads a
  {
    ArraySum(a,0,k)
  }

  //========================================================================
  // Proves that extending a prefix by one position adds the new final
  // element a[k]
  lemma PrefixSumStep(a:array<int>, k:nat)
    requires k < a.Length
    ensures    PrefixSum(a,k+1) 
            == PrefixSum(a,k) + a[k]
  {
      // Apply the corresponding range-extension lemma with lo = 0
    ArraySumAddLast(a,0,k);
  }

  //========================================================================
  // Defines the product of the array elements in the half-open range
  // [lo,hi). The empty range has product 1.
  ghost function ArrayProduct(a:array<int>, lo:nat, hi:nat): int
    requires lo <= hi <= a.Length
    reads a
    decreases hi - lo
  {
    if lo == hi then 1
                else ArrayProduct(a,lo,hi-1) * a[hi-1]
  }

  //========================================================================
  // Proves that extending a product range by one position multiplies the
  // previous product by the new final element a[hi]
  lemma ArrayProductAddLast(a:array<int>, lo:nat, hi:nat)
    requires lo <= hi < a.Length
    ensures    ArrayProduct(a,lo,hi+1) 
            == ArrayProduct(a,lo,hi) * a[hi]
  {
    // Follows by unfolding ArrayProduct once at the upper bound hi+1
  }

  //========================================================================
  // Proves that an array product over [lo,hi) can be split at any
  // intermediate index mid into the products over [lo,mid) and [mid,hi)
  // NOTE: The lemma is proved by induction on hi-mid. The recursive call
  // explicitly supplies the induction hypothesis for the shorter range
  // [lo,hi-1). Dafny then unfolds the relevant ArrayProduct definitions 
  // and completes the remaining arithmetic reasoning automatically.
  lemma ArrayProductSplit(a:array<int>, lo:nat, mid:nat, hi:nat)
    requires lo <= mid <= hi <= a.Length
    ensures    ArrayProduct(a,lo,hi)
            == ArrayProduct(a,lo,mid)
             * ArrayProduct(a,mid,hi)
    decreases hi - mid
  {
    if mid < hi 
    {
        // Apply the induction hypothesis to the shorter range [lo,hi-1)
      ArrayProductSplit(a,lo,mid,hi-1);

        // Unfold the products ending at hi. Both the complete range
        // [lo,hi) and the right subrange [mid,hi) extend their
        // corresponding ranges ending at hi-1 by the same element a[hi-1]
    }

      // If mid == hi, the right subrange [mid,hi) is empty, and the
      // required equality follows directly from ArrayProduct(a,mid,hi) == 1
  }
}

module NatArrayAggregates  
{
  //========================================================================
  // Defines the sum of the array elements in the half-open range [lo,hi).
  // The empty range has sum 0
  ghost function ArraySum(a:array<nat>, lo:nat, hi:nat): int
    requires lo <= hi <= a.Length
    reads a
    decreases hi - lo
  {
    if lo == hi then 0
                else ArraySum(a,lo,hi-1) + a[hi-1]
  }

  //========================================================================
  // Proves that extending a summation range by one position adds the new
  // final element a[hi]
  lemma ArraySumAddLast(a:array<nat>, lo:nat, hi:nat)
    requires lo <= hi < a.Length
    ensures    ArraySum(a,lo,hi+1) 
            == ArraySum(a,lo,hi) + a[hi]
  {
    // Follows by unfolding ArraySum once at the upper bound hi+1
  }

  //========================================================================
  // Proves that an array sum over [lo,hi) can be split at any intermediate
  // index mid into the sums over [lo,mid) and [mid,hi)
  // NOTE: The lemma is proved by induction on hi-mid. The recursive call
  // explicitly supplies the induction hypothesis for the shorter range
  // [lo,hi-1). Dafny then unfolds the relevant ArraySum definitions and
  // completes the remaining arithmetic reasoning automatically.
  lemma ArraySumSplit(a:array<nat>, lo:nat, mid:nat, hi:nat)
    requires lo <= mid <= hi <= a.Length
    ensures    ArraySum(a,lo,hi) 
            == ArraySum(a,lo,mid) + ArraySum(a,mid,hi)
    decreases hi - mid
  {
    if mid < hi 
    {
        // Apply the induction hypothesis to the shorter range [lo,hi-1)
      ArraySumSplit(a,lo,mid,hi-1);

        // Unfold the sums ending at hi. Both the complete range
        // [lo,hi) and the right subrange [mid,hi) extend their
        // corresponding ranges ending at hi-1 by the same element a[hi-1]
    }

      // If mid == hi, the right subrange [mid,hi) is empty, and the
      // required equality follows directly from ArraySum(a,mid,hi) == 0
  }

  //========================================================================
  // Defines the prefix sum of the first k array elements as the array sum
  // over the half-open range [0,k)
  ghost function PrefixSum(a:array<nat>, k:nat): int
    requires k <= a.Length
    reads a
  {
    ArraySum(a,0,k)
  }

  //========================================================================
  // Proves that extending a prefix by one position adds the new final
  // element a[k]
  lemma PrefixSumStep(a:array<nat>, k:nat)
    requires k < a.Length
    ensures    PrefixSum(a,k+1) 
            == PrefixSum(a,k) + a[k]
  {
      // Apply the corresponding range-extension lemma with lo = 0
    ArraySumAddLast(a,0,k);
  }

  //========================================================================
  // Defines the product of the array elements in the half-open range
  // [lo,hi). The empty range has product 1.
  ghost function ArrayProduct(a:array<nat>, lo:nat, hi:nat): int
    requires lo <= hi <= a.Length
    reads a
    decreases hi - lo
  {
    if lo == hi then 1
                else ArrayProduct(a,lo,hi-1) * a[hi-1]
  }

  //========================================================================
  // Proves that extending a product range by one position multiplies the
  // previous product by the new final element a[hi]
  lemma ArrayProductAddLast(a:array<nat>, lo:nat, hi:nat)
    requires lo <= hi < a.Length
    ensures    ArrayProduct(a,lo,hi+1) 
            == ArrayProduct(a,lo,hi) * a[hi]
  {
    // Follows by unfolding ArrayProduct once at the upper bound hi+1
  }

  //========================================================================
  // Proves that an array product over [lo,hi) can be split at any
  // intermediate index mid into the products over [lo,mid) and [mid,hi)
  // NOTE: The lemma is proved by induction on hi-mid. The recursive call
  // explicitly supplies the induction hypothesis for the shorter range
  // [lo,hi-1). Dafny then unfolds the relevant ArrayProduct definitions 
  // and completes the remaining arithmetic reasoning automatically.
  lemma ArrayProductSplit(a:array<nat>, lo:nat, mid:nat, hi:nat)
    requires lo <= mid <= hi <= a.Length
    ensures    ArrayProduct(a,lo,hi)
            == ArrayProduct(a,lo,mid)
             * ArrayProduct(a,mid,hi)
    decreases hi - mid
  {
    if mid < hi 
    {
        // Apply the induction hypothesis to the shorter range [lo,hi-1)
      ArrayProductSplit(a,lo,mid,hi-1);

        // Unfold the products ending at hi. Both the complete range
        // [lo,hi) and the right subrange [mid,hi) extend their
        // corresponding ranges ending at hi-1 by the same element a[hi-1]
    }

      // If mid == hi, the right subrange [mid,hi) is empty, and the
      // required equality follows directly from ArrayProduct(a,mid,hi) == 1
  }
}