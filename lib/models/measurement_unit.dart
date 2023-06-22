class MeasurementUnit {
  int id;
  String name;
  String code;

  MeasurementUnit({required this.id, required this.name, required this.code});

  factory MeasurementUnit.fromJson(Map<String, dynamic> json) {
    return MeasurementUnit(
        id: json['id'], name: json['name'], code: json['code']);
  }
}
