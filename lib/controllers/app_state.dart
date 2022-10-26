import 'dart:async';

import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool isSplashScreenDone = false;
  bool isOnboardingSceenDone = false;

  void initializedApp() async {
    Timer(const Duration(seconds: 2), () {
      isSplashScreenDone = true;
      notifyListeners();
    });
  }

  void onBoaringScreenProcess() {
    isOnboardingSceenDone = true;
    notifyListeners();
  }
}
