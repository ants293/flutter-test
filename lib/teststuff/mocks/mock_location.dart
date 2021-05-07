import 'package:news_reader/teststuff/models/location.dart';
import 'package:news_reader/teststuff/models/location_fact.dart';

class MockLocation extends Location {
  static Location FetchAny() {
    return Location(
      name: "stuffs",
      url: "https://i.pinimg.com/originals/5e/55/e6/5e55e60e4f179f86b2158c656e9c055b.jpg",
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