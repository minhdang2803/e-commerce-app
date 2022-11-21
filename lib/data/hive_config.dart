import 'package:ecom/models/home_screen/account_component/history_info_model.dart';
import 'package:ecom/models/home_screen/product_component/goods_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static const goodsBox = 'goods_box';
  static const userHistoryBox = 'user_history_box';

  HiveConfig();
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(GoodsAdapter());
    Hive.registerAdapter(HistoryInfoModelAdapter());
    Hive.openBox<Goods>(goodsBox);
    Hive.openBox<HistoryInfoModel>(userHistoryBox);
  }
}
