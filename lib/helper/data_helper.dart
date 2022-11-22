import 'package:ecom/utils/connection_utils.dart';

class DataHelper {
  static Future<bool> checkInternetConnection() async {
    final hasInternet = await ConnectionUtil.hasInternetConnection();
    return hasInternet;
  }
}
