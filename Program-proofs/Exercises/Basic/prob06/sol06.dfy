/* file: sol06.dfy
   author: David De Potter
   description: extra practice in Dafny, basic, 
    solution to prob06
*/

method problem06(x:int, y:int, ghost X:int, ghost Y:int) returns (r:int, s:int)
requires 4 * x + 2 * y == 2 * X + 4 * Y && 2 * x - y == Y
ensures  r == X && s == Y - 3 * X
{   
    // P: 4 * x + 2 * y = 2 * X + 4 * Y ∧ 2 * x - y = Y
    //   ( substitute Y for 2 * x - y in the first conjunct )
    // 4 * x + 2 * y = 2 * X + 4 * (2 * x - y) ∧ 2 * x - y = Y
    //   ( simplify the first conjunct )
    // -4 * x + 6 * y = 2 * X ∧ 2 * x - y = Y
    //   ( divide both sides of the first conjunct by 2 )
    // -2 * x + 3 * y = X ∧ 2 * x - y = Y
  r := -2 * x + 3 * y;
    // r = X ∧ 2 * x - y = Y
    //   ( subtract equal terms from both sides of the second conjunct )
    // r = X ∧ 2 * x - y - 3 * r = Y - 3 * X 
  s := 2 * x - y - 3 * r;
    // Q: r = X ∧ s = Y - 3 * X
}