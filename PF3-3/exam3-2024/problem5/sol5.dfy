/* 
  file: sol5.dfy
  author: David De Potter
  description: 3-3rd exam 2024, solution to problem 5
*/

method problem5(a: array<int>) returns (k: nat)
requires a.Length > 1 && a[0] == a[a.Length-1]
ensures 0 <= k < a.Length - 1 && a[k] >= a[k+1]
{
  var i, j := 0, a.Length - 1;
  while i + 1 < j
    invariant 0 <= i < j <= a.Length - 1 && a[i] >= a[j]
    decreases j - i
  {
    var m := (i + j)/2;
    
    if a[i] < a[m] 
    {
      i := m;
    } 
    else 
    {
      j := m;
    }
  }
  
  k := i;
}