class PiggyModel {
  final String item;
  final num amount;
  final String sign;
  final DateTime createdAt;

  const PiggyModel._({
    required this.item,
    required this.amount,
    required this.sign,
    required this.createdAt,
  });

  factory PiggyModel.fromJson(Map<dynamic, dynamic> json) => PiggyModel._(
        item: json["item"],
        amount: json["amount"],
        sign: json["sign"],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "amount": amount,
        "sign": sign,
        "created_at": createdAt.toIso8601String(),
      };

  static List<PiggyModel> fromJsonList(List json) =>
      json.map((model) => PiggyModel.fromJson(model)).toList();

  static List<Map<String, dynamic>> toJsonList(List<PiggyModel> list) =>
      list.map((piggy) => piggy.toJson()).toList();
}
