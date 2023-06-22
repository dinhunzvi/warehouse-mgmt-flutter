class GoodsReceivedVoucher {

  int id;
  String processedBy;
  String reference;
  String dateReceived;

  GoodsReceivedVoucher({
    required this.id,
    required this.processedBy,
    required this.reference,
    required this.dateReceived
});

  factory GoodsReceivedVoucher.fromJson( Map<String, dynamic> json) {
    return GoodsReceivedVoucher(
        id: json['id'], processedBy: json['processedBy'],
        reference: json['reference'], dateReceived: json['date_received'] );
  }
}