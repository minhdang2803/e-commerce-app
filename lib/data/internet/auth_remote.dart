import 'package:ecom/data/hive_config.dart';
import 'package:ecom/data/local/auth_local.dart';
import 'package:ecom/helper/data_helper.dart';
import 'package:ecom/utils/exception.dart';
import 'package:ecom/utils/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemote {
  Future<bool> loginWithEmail(String email, String password);
  Future<void> logoutGoogle();
}

class AuthRemoteImpl implements AuthRemote {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  @override
  Future<bool> loginWithEmail(String email, String password) async {
    if (!await DataHelper.checkInternetConnection()) {
      throw RemoteException(
          RemoteException.noInternet, 'No Internet Connection');
    }
    bool result = false;
    if (email == '' || password == '') {
      throw RemoteException(
          RemoteException.responseError, "Wrong admin acoount credential");
    }
    final adminBox =  AuthLocalImpl().getUserBox();
    final user = adminBox.get(HiveConfig.admin);
    if (email == user!.email && password == user.password) {
      result = true;
    }

    return Future.value(result);
  }

  @override
  Future<void> logoutGoogle() async {
    final userData =
        FirebaseAuth.instance.currentUser!.providerData[0].providerId;
    if (userData != 'password') {
      await googleSignIn.disconnect().catchError(() {});
    }
    FirebaseAuth.instance.signOut();
  }
}
