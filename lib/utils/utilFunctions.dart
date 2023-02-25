bool dateEquals(var a,var b){
  a = DateTime.parse(a);

  if(a.year==b.year && a.month==b.month && a.day==b.day) return true;
  return false;

}