import 'package:ecom/controllers/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/exception.dart';

class RegisterRequest {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
}

class RegisterProvider extends BaseProvider {
  final BaseProviderModel<RegisterRequest> _registerData =
      BaseProviderModel.init(data: RegisterRequest());
  final googleSignIn = GoogleSignIn();

  RegisterRequest get registerInstance => _registerData.data!;
  final registerForm = GlobalKey<FormState>();
  bool isPop = false;
  bool isCancel = false;
  bool isPassword = true;
  bool isVarified = false;
  bool isFirstTimeCheck = true;
  Future registerByEmail() async {
    try {
      isCancel = false;
      isPop = false;
      setStatus(ViewState.loading, notify: true);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: registerInstance.email.text,
        password: registerInstance.password.text,
      )
          .whenComplete(() async {
        FirebaseAuth.instance.currentUser!
            .updateDisplayName(registerInstance.username.text);
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }).catchError((error) {
        setErrorMessage('Register failed');
        setStatus(ViewState.done, notify: true);
      });
      setStatus(ViewState.done, notify: true);
    } on PlatformException catch (exception) {
      setStatus(ViewState.fail, notify: true);
      setErrorMessage(exception.message!, notify: true);
    } on FirebaseAuthException catch (exception) {
      setStatus(ViewState.fail, notify: true);
      setErrorMessage(exception.code, notify: true);
    } on RemoteException catch (exception) {
      setStatus(ViewState.fail, notify: true);
      setErrorMessage(exception.errorMessage, notify: true);
    } finally {}
  }

  Future checkEmail() async {
    if (FirebaseAuth.instance.currentUser != null) {
      if (isFirstTimeCheck) {
        Future.delayed(const Duration(seconds: 1), () async {
          await FirebaseAuth.instance.currentUser!.reload();
        });
      }
      isVarified = FirebaseAuth.instance.currentUser!.emailVerified;
    }
    notifyListeners();
  }
}
