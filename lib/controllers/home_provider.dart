import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controllers/base_provider.dart';
import 'package:ecom/data/hive_config.dart';
import 'package:ecom/models/checkout_feature/address_model.dart';
import 'package:ecom/models/home_screen/account_component/history_info_model.dart';
import 'package:ecom/utils/string_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../models/home_screen/product_component/goods_model.dart';

/*
name
imageURL: Link đến internetImage (imgur)
description:
price: (fake giá th được rồi)
rate: (int: 1-5, fake th được rồi)
promotion: (New product/ Discount/ cả hai)
*/
class HomeProvider extends BaseProvider {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  Set<Goods> cart = {};
  Map<int, int> numberOfItem = {};
  void addProduct(Goods item) {
    if (cart.contains(item)) {
      numberOfItem.update(item.id, (value) => numberOfItem[item.id]! + 1);
    } else {
      cart.add(item);
      numberOfItem.addEntries({item.id: 1}.entries);
    }
    notifyListeners();
  }

  void increaseNumberOfItem(Goods item) {
    numberOfItem.update(item.id, (value) => numberOfItem[item.id]! + 1);
    notifyListeners();
  }

  void decreaseNumberOfItem(Goods item) {
    if (numberOfItem[item.id] == 1) {
      cart.removeWhere((element) => element.id == item.id);
      numberOfItem.remove(item.id);
    } else {
      numberOfItem.update(item.id, (value) => numberOfItem[item.id]! - 1);
    }
    notifyListeners();
  }

  void removeProductAtIndex(Goods item) {
    cart.remove(item);
    numberOfItem.remove(item.id);
    notifyListeners();
  }

  double getTotalPrice() {
    return cart.fold(
          0,
          (previousValue, element) {
            int? totalProduct = numberOfItem[element.id];
            return previousValue +=
                int.parse(element.truePrice) * (totalProduct ?? 1);
          },
        ) *
        24873;
  }

  void clearCart() {
    cart = {};
    numberOfItem = {};
  }

  Future<void> addHistory(List<Goods> goods) async {
    List<Map<String, dynamic>> listOfGood = [];
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userHistoryCollection =
        FirebaseFirestore.instance.collection("histories");
    final DocumentReference document = userHistoryCollection.doc(uid);
    final timeNow = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    for (var element in goods) {
      listOfGood.add({
        "price": (int.parse(element.truePrice) * 24873).toString().parseMoney(),
        "status": 'waiting',
        "title": element.productName
      });
    }

    await document.update(
      {
        "histories": FieldValue.arrayUnion([
          {"time": timeNow, "history_card": listOfGood}
        ])
      },
    );
  }

  Future<List<HistoryInfoModel>> getHistory() async {
    List<HistoryInfoModel> result = [];
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userHistoryCollection =
        FirebaseFirestore.instance.collection("histories");
    final DocumentReference document = userHistoryCollection.doc(uid);
    await document.get().then((value) {
      final data = value.data() as Map<String, dynamic>;
      for (var element in data['histories']) {
        result.add(HistoryInfoModel.fromJson(element));
      }
    });
    return Future.value(result);
  }

  // 9704198526191432198
  Future<dynamic> getData(String path) async {
    List<Goods> result = [];
    final snapshot = await ref.child(path).get();
    if (snapshot.exists) {
      final data = jsonDecode(jsonEncode(snapshot.value));
      result = List.from(data).map((e) {
        var element = Goods.fromJson(e);
        final myBox = Hive.box<Goods>(HiveConfig.goodsBox);
        myBox.put(element.id, element);
        return element;
      }).toList();
    }
    return result;
  }

  

  List<Goods> getLocalData() {
    List<Goods> result = [];
    final myBox = Hive.box<Goods>(HiveConfig.goodsBox);
    final myValue = myBox.values;
    // await Future.delayed(const Duration(milliseconds: 500));
    result.addAll(myValue.map((e) => e));
    return result;
  }
}
