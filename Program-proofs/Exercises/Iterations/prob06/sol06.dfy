/* file: sol06.dfy
   author: David De Potter
   description: extra practice in Dafny, iterations, 
   solution to prob06
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
  var m := n;
  var a, b, c := 0, 1, 0;

  while m != 0                                            
  invariant a + b * f(m) + c * f(m + 1) == f(n) && m >= 0  
  decreases m                                              
  { 
    if m % 2 == 0 
    {
      a := a + 6 * c;
      b := b - 3 * c;
    }
    
    else 
    {
      if m == 1
      {
        OddEquationBaseCase();
        assert f(1) == 6 - 3 * f(1 / 2) + f(1 / 2 + 1);
      } 
      a := a + 6 * b;
      c := b + c;
      b := -3 * b;
    } 
      
    m := m / 2;
  }
   
  r := a + 2 * b; 
}