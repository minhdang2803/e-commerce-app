import 'package:hive_flutter/hive_flutter.dart';
part 'history_card_model.g.dart';

@HiveType(typeId: 3)
class HistoryCardModel extends HiveObject {
  HistoryCardModel({
    required this.price,
    required this.title,
    required this.status,
    required this.quantity,
  });
  @HiveField(0)
  late final String price;
  @HiveField(1)
  late final String title;
  @HiveField(2)
  late final String status;
  @HiveField(3)
  late final int quantity;

  HistoryCardModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    title = json['title'];
    status = json['status'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson({
    String? status_,
    int? quantity_,
    String? price_,
    String? title_,
  }) {
    final _data = <String, dynamic>{};
    _data['price'] = price_ ?? price;
    _data['title'] = title_ ?? title;
    _data['status'] = status_ ?? status;
    _data['quantity'] = quantity_ ?? quantity;
    return _data;
  }
}
