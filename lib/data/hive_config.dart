import 'package:ecom/models/admin_feature/admin_user.dart';
import 'package:ecom/models/home_screen/product_component/goods_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static const goodsBox = 'goods_box';
  static const userHistoryBox = 'user_history_box';
  static const admin = 'admin';

  HiveConfig();
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(GoodsAdapter());
    Hive.registerAdapter(AppUserAdapter());
    await Hive.openBox<Goods>(goodsBox);
    await Hive.openBox<AppUser>(admin);
  }
}
