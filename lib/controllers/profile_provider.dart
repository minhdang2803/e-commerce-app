import 'package:ecom/controllers/base_provider.dart';

import '../models/models.dart';

class ProfileProvider extends BaseProvider {
  void updateInfo({
    String? name,
    String? email,
    String? password,
  }) {}

  List<HistoryInfoModel> historyInfos = [
    HistoryInfoModel(
      time: '28/04/2022',
      historyCardModel: [
        HistoryCardModel(
            price: '20\$', title: 'Ultraboot 1.0', status: 'shipped'),
        HistoryCardModel(
            price: '50\$', title: 'Ultraboot 2.0', status: 'shipped'),
        HistoryCardModel(
            price: '70\$', title: 'Ultraboot 3.0', status: 'shipping'),
        HistoryCardModel(
            price: '90\$', title: 'Ultraboot 4.0', status: 'waiting'),
      ],
    ),
    HistoryInfoModel(
      time: '30/06/2022',
      historyCardModel: [
        HistoryCardModel(price: '20\$', title: 'Lebron IX', status: 'shipped'),
        HistoryCardModel(price: '40\$', title: 'Lebron X', status: 'shipped'),
        HistoryCardModel(price: '60\$', title: 'Lebron XI', status: 'shipping'),
        HistoryCardModel(price: '80\$', title: 'Lebron XII', status: 'waiting'),
        HistoryCardModel(
            price: '80\$', title: 'Lebron IX Soldier', status: 'shipped'),
        HistoryCardModel(
            price: '80\$', title: 'Lebron XII Soldier', status: 'waiting'),
      ],
    ),
    HistoryInfoModel(
      time: '29/05/2022',
      historyCardModel: [
        HistoryCardModel(
            price: '20\$', title: 'Jordan 1 Chicago', status: 'shipped'),
        HistoryCardModel(
            price: '20\$',
            title: 'Jordan 7 Nothing but net clmasd asd sa',
            status: 'shipped'),
        HistoryCardModel(
            price: '20\$', title: 'Jordon 4 KO Shadow', status: 'shipping'),
        HistoryCardModel(
            price: '20\$', title: 'Jordan 5 Supreme', status: 'waiting'),
      ],
    ),
  ];
}
