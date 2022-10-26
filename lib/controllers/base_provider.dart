import 'package:flutter/foundation.dart';

enum ViewState { loading, done, fail, none }

class BaseProvider extends ChangeNotifier {
  ViewState _viewState = ViewState.none;

  ViewState get viewState => _viewState;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  void setStatus(ViewState stateValue, {bool notify = true}) {
    _viewState = stateValue;
    if (notify) {
      notifyListeners();
    }
  }

  void setErrorMessage(String errorMessageValue, {bool notify = true}) {
    _errorMessage = errorMessageValue;
    if (notify) {
      notifyListeners();
    }
  }
}
