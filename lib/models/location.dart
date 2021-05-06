
import 'location_fact.dart';

class Location {
  final String name;
  final String url;
  final int number;
  final List<LocationFact> facts;
  Location({this.name, this.url, this.facts, this.number});
}