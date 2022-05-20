class LatLng {
  final double lat, lng;

  LatLng(this.lat, this.lng);
  factory LatLng.fromMap(Map<String, dynamic> json) =>
      LatLng(json["coordinates"][1], json["coordinates"][0]);
}

class EventModel {
  EventModel({
    required this.location,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.eventDate,
    required this.description,
    required this.contactNumber,
    required this.img,
    required this.postedBy,
    required this.eventId,
    required this.updatedAt,
    required this.v,
  });

  LatLng location;
  String id;
  DateTime createdAt;
  String name;
  DateTime eventDate;
  String description;
  String contactNumber;
  String img;
  String postedBy;
  String eventId;
  DateTime updatedAt;
  int v;

  factory EventModel.fromMap(Map<String, dynamic> json) => EventModel(
        location: LatLng.fromMap(json["location"]),
        id: json["_id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        eventDate: DateTime.parse(json["event_date"]),
        description: json["description"],
        contactNumber: json["contact_number"],
        img: json["img"],
        postedBy: json["posted_by"],
        eventId: json["event_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );
}

class Job {
  final String title;
  final String body;
  final DateTime venuDate;
  final double lat, lng;

  Job(
      {required this.title,
      required this.body,
      required this.venuDate,
      required this.lat,
      required this.lng});

  factory Job.fromJson(Map json) => Job(
      title: json["title"],
      body: json["body"],
      venuDate: DateTime.parse(json["date"]),
      lat: json["lat"],
      lng: json["lng"]);
}
