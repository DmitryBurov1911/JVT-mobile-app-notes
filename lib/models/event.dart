// ignore_for_file: non_constant_identifier_names

class Event {
  String ?name;
  String ?location;
  DateTime ?StartDateTime;

  Event({this.name, this.location, this.StartDateTime});
}

var i = Event(name: "name", location: "place", StartDateTime: DateTime.now());