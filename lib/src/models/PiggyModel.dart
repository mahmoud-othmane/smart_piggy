class Piggymodel {
  final String item;
  final num amount;
  final String sign;

  const Piggymodel._({
    required this.item,
    required this.amount,
    required this.sign,
  });

  factory Piggymodel.fromJson(Map<dynamic, dynamic> json) => Piggymodel._(
        item: json["item"],
        amount: json["amount"],
        sign: json["sign"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "amount": amount,
        "sign": sign,
      };

  static List<Piggymodel> fromJsonList(List json) =>
      json.map((model) => Piggymodel.fromJson(model)).toList();

  static List<Map<String, dynamic>> toJsonList(List<Piggymodel> list) =>
      list.map((piggy) => piggy.toJson()).toList();
}
