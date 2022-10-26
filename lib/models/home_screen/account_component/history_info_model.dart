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

class HistoryInfoModel {
  HistoryInfoModel({
    required this.time,
    required this.historyCardModel,
  });
  late final String time;
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
    currentData['history_card'] = historyCardModel.map((e) => e.toJson()).toList();
    return currentData;
  }
}

class HistoryCardModel {
  HistoryCardModel({
    required this.price,
    required this.title,
    required this.status,
  });
  late final String price;
  late final String title;
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
