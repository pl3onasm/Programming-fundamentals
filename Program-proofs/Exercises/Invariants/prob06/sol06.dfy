/* file: sol06.dfy
   author: David De Potter
   description: extra practice in Dafny, invariants, 
   solution to prob06
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
  var z:nat := y;
  ghost var i:nat := 0;

  while z <= x
    invariant z == pow2(i) * y
    decreases x - z
  {
    z := 2 * z;
    i := i + 1;
  }

  r := x;
  q := 0;

  while z != y
    invariant x == q * z + r && 0 <= r < z
    invariant z == pow2(i) * y 
    decreases z - y
  { 
    z := z / 2;
    halfPow2(i, y);
    q := 2 * q;
    i := i - 1;

    if r >= z
    {
      r := r - z;
      q := q + 1;
    }
  }
}