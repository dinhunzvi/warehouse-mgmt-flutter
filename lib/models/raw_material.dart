class RawMaterial {
  int id;
  int measurementUnitId;
  String measurementUnit;
  String measurementUnitCode;
  int binLocationId;
  String binLocation;
  String name;

  RawMaterial(
      {required this.id,
      required this.measurementUnitId,
      required this.measurementUnit,
      required this.measurementUnitCode,
      required this.binLocationId,
      required this.binLocation,
      required this.name});

  factory RawMaterial.fromJSON(Map<String, dynamic> json) {
    return RawMaterial(
        id: json['id'],
        measurementUnitId: json['measurement_unit_id'],
        measurementUnit: json['measurement_unit'],
        measurementUnitCode: json['measurement_unit_code'],
        name: json['name'],
        binLocationId: json['bin_location_id'],
        binLocation: json['bin_location']);
  }
}
