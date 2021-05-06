import 'package:news_reader/models/location.dart';
import 'package:news_reader/models/location_fact.dart';

class MockLocation extends Location {
  static Location FetchAny() {
    return Location(
      name: "stuffs",
      url: "https://neti.ee",
      facts: <LocationFact> [
        LocationFact(
          title: "ok",
          text: "im a text 1"
        ),
        LocationFact(
            title: "ok2",
            text: "im a text 2"
        ),
        LocationFact(
            title: "ok3",
            text: "im a text 3"
        )
      ]
    );
  }
}