class Product {
  int id;
  int measurementUnitId;
  String measurementUnitName;
  String measurementUnitCode;
  String name;
  String code;

  Product(
      {required this.id,
      required this.measurementUnitId,
      required this.measurementUnitName,
      required this.measurementUnitCode,
      required this.name,
      required this.code});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        measurementUnitId: json['measurement_unit_id'],
        measurementUnitName: json['measurement_unit_name'],
        measurementUnitCode: json['measurement_unit_code'],
        name: json['name'],
        code: json['code']);
  }
}
