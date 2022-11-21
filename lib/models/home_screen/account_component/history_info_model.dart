// class HistoryInfoModel {
//   final String time;
//   final List<HistoryCardModel> historyCardModel;
//   HistoryInfoModel({required this.time, required this.historyCardModel});

//   factory HistoryInfoModel.fromJson(Map<String, dynamic> json) {
//     final clm = json['historyCard'].map(
//       (element) => HistoryCardModel.fromJson(element),
//     );

//     return HistoryInfoModel(
//       time: json['time'],
//       historyCardModel: clm,
//     );
//   }
// }

// class HistoryCardModel {
//   final String title;
//   final String price;
//   final String status;
//   HistoryCardModel(
//       {required this.title, required this.price, required this.status});

//   factory HistoryCardModel.fromJson(Map<String, dynamic> json) =>
//       HistoryCardModel(
//           price: json['price'], status: json['status'], title: json['title']);

//   Map<String, dynamic> toJson() =>
//       {'title': title, 'status': status, 'price': price};
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/home_screen/account_component/history_card_model.dart';
import 'package:hive/hive.dart';
part 'history_info_model.g.dart';

@HiveType(typeId: 2)
class HistoryInfoModel extends HiveObject {
  HistoryInfoModel({
    required this.time,
    required this.historyCardModel,
  });
  @HiveField(0)
  late final String time;
  @HiveField(1)
  late final List<HistoryCardModel> historyCardModel;

  HistoryInfoModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    historyCardModel = List.from(json['history_card'])
        .map((e) => HistoryCardModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final currentData = <String, dynamic>{};
    currentData['time'] = time;
    currentData['history_card'] =
        historyCardModel.map((e) => e.toJson()).toList();
    return currentData;
  }

  factory HistoryInfoModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return HistoryInfoModel(
        time: data?['time'],
        historyCardModel: List.from(data!['history_card']));
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (time != null) "time": time,
      if (historyCardModel != null) "history_card": historyCardModel,
    };
  }
}
