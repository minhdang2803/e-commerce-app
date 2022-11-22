import 'package:ecom/data/internet/auth_remote.dart';
import 'package:ecom/data/local/auth_local.dart';

class AuthRepository {
  late final AuthRemote _authRemote;
  late final AuthLoacal _authLoacal;

  AuthRepository._privateConstructor() {
    _authLoacal = AuthLocalImpl();
    _authRemote = AuthRemoteImpl();
  }

  static final _instance = AuthRepository._privateConstructor();

  factory AuthRepository.instance() => _instance;

  Future<bool> loginWithEmail(String email, String password) async {
    return await _authRemote.loginWithEmail(email, password);
  }

  Future<void> saveCurrentUser() async {
    await _authLoacal.saveCurrentUser();
  }

  Future<void> logOut() async {
    await _authRemote.logoutGoogle();
  }
}
