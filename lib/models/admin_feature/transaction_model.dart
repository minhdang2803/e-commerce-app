import 'package:ecom/models/home_screen/account_component/history_card_model.dart';

class ProductTransaction {
  final String time;
  final String uid;
  final List<HistoryCardModel> items;
  ProductTransaction(
      {required this.time, required this.uid, required this.items});

  factory ProductTransaction.fromJson(Map<String, dynamic> json) {
    return ProductTransaction(
      time: json['time'],
      uid: json['uid'],
      items: List.from(json['products'])
          .map((e) => HistoryCardModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson({
    String? time_,
    String? uid_,
    List<Map<String, dynamic>>? items_,
  }) {
    return {
      "time": time_ ?? time,
      "uid": uid_ ?? uid,
      "products": items_ ?? items.map((e) => e.toJson()).toList()
    };
  }
}
