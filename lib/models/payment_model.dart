class Payment {
  Payment({
    required this.paymentId,
    required this.amount,
    required this.paidBy,
    required this.paidTo,
    required this.currency,
    required this.remarks,
    required this.createdAt,
    required this.approvedAt,
  });

  String paymentId;
  int amount;

  String paidBy;
  String paidTo;

  String currency;
  String remarks;

  String createdAt;
  String? approvedAt;
}
