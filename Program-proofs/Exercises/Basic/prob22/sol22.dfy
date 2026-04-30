/* file: sol22.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
   solution to prob22  
*/

method problem22(a:int, b:int, ghost X:int) returns (r:int, s:int)
requires a == X
ensures  r % 2 == 0 && s == r * r && (s == X * X || s == X * X + 2 * X + 1)
{
  r, s := a, b;

  if (r % 2 == 0) 
  {
      // r % 2 = 0 
      //   (prepare s := r * r)
      // r % 2 = 0 ∧ r * r = r * r ∧ r * r = X * X
    s := r * r;
      // r % 2 = 0 ∧ s = r * r ∧ s = X * X 
  } 
  
  else 
  {
      // r % 2 ≠ 0 
      //   (arithmetic)
      // (r + 1) % 2 = 0
      //   (prepare r := r + 1)
      // (r + 1) % 2 = 0 ∧ r + 1 = X + 1
    r := r + 1;
      // r % 2 = 0 ∧ r = X + 1
      //   (prepare s := r * r)
      // r % 2 = 0 ∧ r * r = r * r ∧ r + r = (X + 1) * (X + 1)
    s := r * r;
      // r % 2 = 0 ∧ s = r * r ∧ s = (X + 1) * (X + 1)
      //   (arithmetic)
      // r % 2 = 0 ∧ s = r * r ∧ s = X * X + 2 * X + 1
  }

  // Collect branches:
  // Q: r % 2 = 0 ∧ s = r * r ∧ (s = X * X ∨ s = X * X + 2 * X + 1)
}