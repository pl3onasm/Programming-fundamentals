/* file: sol06Annotated.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob06, with annotations
*/

ghost function even (n:nat): bool
{
  n % 2 == 0
}

ghost function f(n:nat): int
{
  match n
  case  0 => 2
  case  1 => 0
  case  _ => if even(n) then f(n/2) 
                        else 6 - 3 * f(n/2) + f(n/2 + 1)
}

lemma OddEquationBaseCase()
  ensures f(1) == 6 - 3 * f(1 / 2) + f(1 / 2 + 1)
{
  calc {
    f(1);
  ==  // definition of f(1)
    0;
  ==  // f(0) == 2 and f(1) == 0
    6 - 3 * f(0) + f(1);
  ==  // since 1 / 2 == 0 and 1 / 2 + 1 == 1
    6 - 3 * f(1 / 2) + f(1 / 2 + 1);
  }
}

method problem06(n:nat) returns (r:int)
ensures r == f(n)
{ 
    // We need an extra variable m since n is an input parameter 
    // and cannot be modified.
  var m := n;
  
    // Initialization to make J hold at the start of the loop
    // P: n ≥ 0
    //   ( use m = n )
    // m ≥ 0 ∧ 0 + 1 * f(m) + 0 * f(m + 1) = f(n)
  var a, b, c := 0, 1, 0;
    // J: a + b * f(m) + c * f(m + 1) = f(n) ∧ m ≥ 0

  while m != 0                                             // B
  invariant a + b * f(m) + c * f(m + 1) == f(n) && m >= 0  // J
  decreases m                                              // J ∧ B ⇒ vf = m > 0
  { 
      // J ∧ B ∧ vf = V
      // a + b * f(m) + c * f(m + 1) = f(n) ∧ m ≥ 0 ∧ m ≠ 0 ∧ m = V 
      // a + b * f(m) + c * f(m + 1) = f(n) ∧ m > 0 ∧ m = V
    if m % 2 == 0 
    {
        // m % 2 == 0 ∧ a + b * f(m) + c * f(m + 1) = f(n) ∧ m > 0 ∧ m = V
        //   ( m is even, so we can rewrite it as 2 * (m / 2) )
        // a + b * f(2 * (m / 2)) + c * f(2 * (m / 2) + 1) = f(n) ∧ m > 0 ∧ m = V
        //   ( use definition of f for both cases; note that m ≥ 2 
        //     since m is even and m > 0, so no need to worry about the base cases )
        // a + b * f(m / 2) + c * (6 - 3 * f(m / 2) + f(m / 2 + 1)) = f(n) ∧ m > 0 ∧ m = V
        // a + 6 * c + (b - 3 * c) * f(m / 2) + c * f(m / 2 + 1) = f(n) ∧ m > 0 ∧ m = V
      a := a + 6 * c;
      b := b - 3 * c;
        // a + b * f(m/2) + c * f(m/2 + 1) = f(n) ∧ m > 0 ∧ m = V
    }
    
    else 
    {
        // m % 2 != 0 ∧ a + b * f(m) + c * f(m + 1) = f(n) ∧ m > 0 ∧ m = V
        //   ( m is odd, so we can rewrite it as 2 * (m / 2) + 1 )
        // a + b * f(2 * (m / 2) + 1) + c * f(2 * (m / 2) + 2) = f(n) ∧ m > 0 ∧ m = V
        // a + b * f(2 * (m / 2) + 1) + c * f(2 * (m / 2 + 1)) = f(n) ∧ m > 0 ∧ m = V
        //   ( use definition of f for both cases; note that m ≥ 1 since m is odd 
        //     and m > 0. This means that m/2 ≥ 0 and we need to prove that we can 
        //     apply the recursive definition of f for the odd case if m = 1, as that 
        //     is a base case. We use a separate lemma for this. )
      if m == 1
      {
        OddEquationBaseCase();
        assert f(1) == 6 - 3 * f(1 / 2) + f(1 / 2 + 1);
      } 
        //   ( now we can safely apply the definition of f for m ≥ 1 )
        // a + b * (6 - 3 * f(m / 2) + f(m / 2 + 1)) + c * f(m / 2 + 1) = f(n) ∧ m > 0 ∧ m = V
        // a + 6 * b - 3 * b * f(m / 2) + (b + c) * f(m / 2 + 1) = f(n) ∧ m > 0 ∧ m = V
      a := a + 6 * b;
      c := b + c;
      b := -3 * b;
        // a + b * f(m/2) + c * f(m/2 + 1) = f(n) ∧ m > 0 ∧ m = V
    } 
      
      // Collect branches: 
      // a + b * f(m/2) + c * f(m/2 + 1) = f(n) ∧ m > 0 ∧ m = V
      //   ( prepare for the next iteration by updating m )
      // a + b * f(m/2) + c * f(m/2 + 1) = f(n) ∧ m/2 ≥ 0 ∧ m/2 < V
    m := m / 2;
      // a + b * f(m) + c * f(m + 1) = f(n) ∧ m ≥ 0 ∧ m < V
      // J holds after the body, and the variant function has decreased (m < V)
  }
    
    // ¬B ∧ J
    // m == 0 ∧ a + b * f(m) + c * f(m + 1) = f(n) ∧ m ≥ 0
    // a + b * f(0) + c * f(1) = f(n)
    // a + 2 * b = f(n)
  r := a + 2 * b; 
    // Q: r == f(n)
}