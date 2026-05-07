/* file: sol06Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob06, with annotations
   This is exercise 7.6 from the PC reader
*/

ghost function pow2(i:nat): nat
{
  if i == 0 then 1 else 2 * pow2(i - 1)
}

lemma halfPow2(i:nat, y:nat)
requires i > 0
ensures (pow2(i) * y) / 2 == pow2(i - 1) * y
{
  assert pow2(i) == 2 * pow2(i - 1);
}

method problem06(x:nat, y:nat) returns (q:nat, r:nat)
requires y > 0
ensures  x == q * y + r && 0 <= r < y
{
    // FIRST iteration: keep doubling divisor y until it is larger than dividend x.

    // Initialization to establish J1: z == pow2(i) * y
    // P: y > 0
    //   ( arithmetic reasoning )
    // y = 2^0 * y
  var z:nat := y;
    // z = 2^0 * y
  ghost var i:nat := 0;
    // J1: z == 2^i * y

  while z <= x        // B1
    invariant z == pow2(i) * y
    decreases x - z   // J1 ∧ B1 ⇒ vf = x - z ≥ 0
  {
      // J1 ∧ B1 ∧ vf = V
      // z == 2^i * y ∧ z ≤ x ∧ x - z = V ≥ 0
      //   ( prepare for updating z to 2 * z )
      // 2 * z == 2^(i + 1) * y ∧ x - 2 * z < V
    z := 2 * z;
      // z == 2^(i + 1) * y ∧ x - z < V
    i := i + 1;
      // z == 2^(i) * y ∧ x - z < V
      //   J1 is preserved, and the variant function has decreased.
  }
    // J1 ∧ ¬B1
    // z == 2^i * y ∧ z > x
    // So z is now a power-of-2 multiple of y that is larger than x.

    // SECOND iteration: we will work back down from z to y by repeatedly 
    // halving z until z = y, while updating q and r accordingly.

    // Initialization to establish J2: x == q * z + r ∧ 0 ≤ r < z
    // P: z = 2^i * y ∧ 0 ≤ x < z
    //   ( arithmetic reasoning )
    // x = 0 * z + x ∧ 0 ≤ x < z
  r := x;
    // x = 0 * z + r ∧ 0 ≤ r < z
  q := 0;
    // J2: x == q * z + r ∧ 0 ≤ r < z

  while z != y        // B2
    invariant x == q * z + r && 0 <= r < z
    invariant z == pow2(i) * y 
    decreases z - y   // J2 ∧ B2 ⇒ y < z, so vf = z - y > 0
  { 
      // J2 ∧ B2 ∧ vf = V
      // x = q * z + r ∧ 0 ≤ r < z ∧ z = 2^i * y ∧ z != y ∧ z - y = V ≥ 0
      //   ( prepare for updating z to z / 2 )
      //   ( since z = 2^i * y, z ≠ y, and y > 0, we must have i > 0.
      //     Therefore z / 2 is again a power-of-2 multiple of y, namely
      //     2^(i - 1) * y. This is expressed by the call to halfPow2. )
    halfPow2(i, y);
      //   ( Since z = 2^i * y and i > 0, z has at least one factor of 2.
      //     Therefore z is exactly divisible by 2, so z = 2 * (z / 2).
      // x = 2 * q * (z / 2) + r ∧ 0 ≤ r < 2 * (z / 2) ∧ z / 2 = 2^(i - 1) * y ∧ z / 2 - y < V
    z := z / 2;
      // x = 2 * q * z + r ∧ 0 ≤ r < 2 * z ∧ z = 2^(i - 1) * y ∧ z - y < V
    q := 2 * q;
      // x = q * z + r ∧ 0 ≤ r < 2 * z ∧ z = 2^(i - 1) * y ∧ z - y < V
    i := i - 1;
      // x = q * z + r ∧ 0 ≤ r < 2 * z ∧ z = 2^i * y ∧ z - y < V

      // In order to establish J2 after the loop body, we need to also guarantee 
      // that 0 ≤ r < z after the updates to z and q. This is done by adjusting r 
      // if r is larger than or equal to the new value of z.

    if r >= z
    {
        // x = q * z + r ∧ 0 ≤ r < 2 * z ∧ z = 2^i * y ∧ z - y < V ∧ r >= z
        //   ( since r < 2 * z and r >= z, we have z ≤ r < 2 * z )
        // x = q * z + r ∧ z ≤ r < 2 * z ∧ z = 2^i * y ∧ z - y < V  
        //   ( prepare for updating r to r - z )
        // x = q * z + (r - z) + z ∧ 0 ≤ r - z < z ∧ z = 2^i * y ∧ z - y < V
      r := r - z;
        // x = q * z + r + z ∧ 0 ≤ r < z ∧ z = 2^i * y ∧ z - y < V
        //   ( prepare for updating q to q + 1 )
        // x = (q + 1) * z + r ∧ 0 ≤ r < z ∧ z = 2^i * y ∧ z - y < V
      q := q + 1;
        // x = q * z + r ∧ 0 ≤ r < z ∧ z = 2^i * y ∧ z - y < V
    }

    else 
    {  
      // x = q * z + r ∧ 0 ≤ r < 2 * z ∧ z = 2^i * y ∧ z - y < V ∧ r < z
      // Skip; nothing to update.
      // x = q * z + r ∧ 0 ≤ r < z ∧ z = 2^i * y ∧ z - y < V
    }

    // collect branches: 
    // x = q * z + r ∧ 0 ≤ r < z ∧ z = 2^i * y ∧ z - y < V
    //   J2 is preserved, and the variant function has decreased.
  }

    // J2 ∧ ¬B2
    // x = q * z + r ∧ 0 ≤ r < z ∧ z = 2^i * y ∧ z = y
    // Q: x == q * y + r && 0 <= r < y
}


/*
  Notes:
  - The variable i is a ghost variable. It records the exponent in
    z = 2^i * y, but only for verification purposes. It helps Dafny's
    verifier keep track of the fact that z remains a power-of-2 multiple
    of y. It is not part of the actual algorithm and does not appear
    in the compiled code.

  - The first loop repeatedly doubles z until z > x. The second loop
    repeatedly halves z until z = y. Both loops therefore take
    logarithmically many iterations. More precisely, the number of
    iterations is O(log(x / y)) for x >= y. This is much faster than
    the O(x / y) repeated-subtraction algorithm from prob05.
*/