/* file: prob09.dfy
   author: your name
   description: extra practice in Dafny, 2D-counting, prob09
   This is exercise 9.11 from the PC reader
*/

method problem09(w:nat) 
returns (r: nat)
ensures r == ??
{
  /* 
    Derive a command sequence T that satisfies the following 
    specification:

      const w : ℕ;
      var   z : ℕ;

        {P : Z = #{ (i,j) | i,j: 0 < i ≤ w ∧ 0 ≤ j < w ∧ i² + j² < w² }}
      T
        {Q : Z = z}

    Next, use the result to determine the number of grid 
    points within a circle with radius w, and use this to 
    approximate the value of π.
  */
}