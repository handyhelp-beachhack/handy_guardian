class User {
  final String name, handicapType, gender, id;
  final DateTime dob;
  bool accepted;
  User(
      {required this.name,
      required this.handicapType,
      required this.dob,
      required this.id,
      this.accepted = true,
      required this.gender});

  static List<User> test() => [
        User(
            name: "Killadi",
            id: "232323",
            handicapType: "Blind",
            dob: DateTime.now(),
            accepted: false,
            gender: "m"),
        User(
            name: "Joju",
            id: "544ff3f",
            handicapType: "Deaf",
            dob: DateTime.now(),
            gender: "f"),
      ];

  factory User.fromJson(Map json, bool accepted) => User(
      name: json["name"],
      dob: DateTime.now(),
      id: json["id"],
      accepted: accepted,
      gender: json["gender"],
      handicapType: json["handicap_type"]);
}
