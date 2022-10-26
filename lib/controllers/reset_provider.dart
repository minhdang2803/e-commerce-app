import 'package:ecom/controllers/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/exception.dart';
import 'base_provider_model.dart';

class ResetModel {
  TextEditingController email = TextEditingController();
}

class ResetPasswordProvider extends BaseProvider {
  final BaseProviderModel<ResetModel> _data =
      BaseProviderModel.init(data: ResetModel());
  ResetModel get instance => _data.data!;

  final forgetfForm = GlobalKey<FormState>();

  bool isPop = false;
  bool isCancel = false;
  bool isPassword = true;
  bool isVarified = false;
  bool isFirstTimeCheck = true;

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;
  Future resetPassword() async {
    try {
      isCancel = false;
      isPop = false;
      setStatus(ViewState.loading, notify: true);
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: instance.email.text);
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
}
