import 'package:hive_flutter/hive_flutter.dart';
part 'history_card_model.g.dart';

@HiveType(typeId: 3)
class HistoryCardModel extends HiveObject {
  HistoryCardModel({
    required this.price,
    required this.title,
    required this.status,
  });
  @HiveField(0)
  late final String price;
  @HiveField(1)
  late final String title;
  @HiveField(2)
  late final String status;

  HistoryCardModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['price'] = price;
    _data['title'] = title;
    _data['status'] = status;
    return _data;
  }
}
