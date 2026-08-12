/*  file: PeanoNumbers.dfy
    author: David De Potter
    description: definition of Peano natural numbers and their basic
    arithmetic and conversion operations
*/

module PeanoNumbers
{
  //======================================================================
  // Represents natural numbers inductively in Peano form. A Peano number  
  // is either Zero, or the successor of another Peano number. For 
  // example, the Peano number representing 3 is Succ(Succ(Succ(Zero))).
  datatype Peano  = Zero
                  | Succ(prev:Peano)

  //======================================================================
  // Defines addition of two Peano numbers by recursion on the first
  // argument: its outer layer is peeled off until the base case is 
  // reached where the second argument is returned as is.
  //   Add(Zero, q)    = q
  //   Add(Succ(p), q) = Succ(Add(p, q))
  function Add(p:Peano, q:Peano): Peano
    decreases p
  {
    match p
    case  Zero       => q
    case  Succ(prev) => Succ(Add(prev, q))
  }

  //======================================================================
  // Defines multiplication of two Peano numbers by repeated addition of 
  // the second argument. The outer layer of the first argument is peeled
  // off until the base case is reached where Zero is returned.
  //   Mul(Zero, q)    = Zero
  //   Mul(Succ(p), q) = Add(q, Mul(p, q))
  function Mul(p:Peano, q:Peano): Peano
    decreases p
  {
    match p
    case  Zero       => Zero
    case  Succ(prev) => Add(q, Mul(prev, q))
  }

  //======================================================================
  // Converts a Peano number to the corresponding Dafny natural number:
  //   PeanoToNat(Zero)    = 0
  //   PeanoToNat(Succ(p)) = PeanoToNat(p) + 1
  function PeanoToNat(p:Peano): nat
    decreases p
  {
    match p
    case  Zero       => 0
    case  Succ(prev) => PeanoToNat(prev) + 1
  }

  //======================================================================
  // Converts a Dafny natural number to the corresponding Peano number:
  //   PeanoFromNat(0) = Zero
  //   PeanoFromNat(n) = Succ(PeanoFromNat(n-1)), for n > 0
  function PeanoFromNat(n:nat): Peano
    decreases n
  {
    if n == 0 then Zero
              else Succ(PeanoFromNat(n-1))
  }

}