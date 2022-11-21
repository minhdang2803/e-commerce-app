import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controllers/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/checkout_feature/address_model.dart';

class CheckoutProvider extends BaseProvider {
  List<AddressModel> addressModel = [];
  // void addAddress(AddressModel address) {
  //   addressModel.add(address);
  //   notifyListeners();
  // }

  // void removeAddress(AddressModel address) {
  //   addressModel.remove(address);
  //   notifyListeners();
  // }

  Future<void> addAddress(AddressModel address) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userHistoryCollection =
        FirebaseFirestore.instance.collection("histories");
    final DocumentReference document = userHistoryCollection.doc(uid);
    await document.update({
      'addresses': FieldValue.arrayUnion([
        {'title': address.title, 'address': address.address}
      ])
    });
    notifyListeners();
  }

  Future<void> removeAddress(AddressModel address) async {
    Map<String, Object?> deleteElement = {
      "title": address.title,
      'address': address.address
    };
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userHistoryCollection =
        FirebaseFirestore.instance.collection("histories");
    final DocumentReference document = userHistoryCollection.doc(uid);
    await document.update({
      "addresses": FieldValue.arrayRemove([deleteElement]),
    });
    notifyListeners();
  }

  Future<List<AddressModel>> getAddress() async {
    List<AddressModel> address = [];
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userHistoryCollection =
        FirebaseFirestore.instance.collection("histories");
    final DocumentReference document = userHistoryCollection.doc(uid);
    await document.get().then((value) {
      final data = value.data() as Map<String, dynamic>;
      for (var element in data['addresses']) {
        address.add(AddressModel.fromJson(element));
      }
    });

    return Future.value(address);
  }
}
