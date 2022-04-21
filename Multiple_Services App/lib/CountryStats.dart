
class CountryStats{
  String name;
  var flag;
  var population;
  var confirmed;
  var deaths;

  CountryStats(this.name, this.flag, this.population, this.confirmed, this.deaths);

  @override
  String toString() {
    return "{$name, $population, $confirmed, $deaths}";
  }
}