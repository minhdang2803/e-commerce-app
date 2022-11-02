import 'package:ecom/models/home_screen/product_component/goods_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static const goodsBox = 'goods_box';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(GoodsAdapter());
    Hive.openBox<Goods>(goodsBox);
  }
}
