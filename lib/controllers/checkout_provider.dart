import 'package:ecom/controllers/controllers.dart';

import '../models/checkout_feature/address_model.dart';

class CheckoutProvider extends BaseProvider {
  List<AddressModel> addressModel = [];
  void addAddress(AddressModel address) {
    addressModel.add(address);
    notifyListeners();
  }

  void removeAddress(AddressModel address) {
    addressModel.remove(address);
    notifyListeners();
  }
}
