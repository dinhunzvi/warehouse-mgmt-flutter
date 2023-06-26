class BinLocation {
  int id;
  String name;

  BinLocation({required this.id, required this.name});

  factory BinLocation.fromJson(Map<String, dynamic> json) {
    return BinLocation(id: json['id'], name: json['name']);
  }
}
