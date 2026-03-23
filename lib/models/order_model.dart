class OrderModel {
  final String id;
  final String userId;
  final List items;
  final double total;
  final String status;
  final int createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt
});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "items": items,
      "total": total,
      "status": status,
      "createdAt": createdAt,
    };
  }

  factory OrderModel.fromMap(Map data) {
    return OrderModel(
      id: data['orderId'] ?? "", //  FIX HERE
      userId: data['userId'] ?? "",
      items: data['items'] ?? data['products'] ?? [], //  HANDLE BOTH
      total: (data['total'] ?? data['totalAmount'] ?? 0).toDouble(),
      status: data['status'] ?? "PLACED",
      createdAt: data['createdAt'] ?? data['orderTime'] ?? 0,
    );
  }



}