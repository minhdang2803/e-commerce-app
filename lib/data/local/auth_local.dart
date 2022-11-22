import 'package:ecom/data/hive_config.dart';
import 'package:ecom/models/admin_feature/admin_user.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AuthLoacal {
  Future<void> saveCurrentUser();

  AppUser? getCurrentUser();

  Box<AppUser> getUserBox();
}

class AuthLocalImpl implements AuthLoacal {
  @override
  Box<AppUser> getUserBox() {
    return Hive.box(HiveConfig.admin);
  }

  @override
  AppUser? getCurrentUser() {
    final userBox = getUserBox();
    return userBox.get(HiveConfig.admin);
  }

  @override
  Future saveCurrentUser() async {
    final userBox = getUserBox();
    userBox.put(
      HiveConfig.admin,
      AppUser(email: "admin@sad.com", password: "123456"),
    );
  }
}
