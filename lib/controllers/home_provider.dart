import 'dart:convert';

import 'package:ecom/controllers/base_provider.dart';
import 'package:ecom/data/hive_config.dart';
import 'package:ecom/models/home_screen/product_component/ecom_product_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    );
  }

  void clearCart() {
    cart = {};
    numberOfItem = {};
  }

  Future<dynamic> getData(String path) async {
    List<Goods> result = [];
    int index = 0;
    final snapshot = await ref.child(path).get();
    if (snapshot.exists) {
      final data = jsonDecode(jsonEncode(snapshot.value));
      result = List.from(data).map((e) {
        var element = Goods.fromJson(e);
        // final myBox = Hive.box<Goods>(HiveConfig.goodsBox);
        // myBox.put('path_$index', e);
        return element;
      }).toList();
      index = 0;
    }
    return result;
  }

  Future<List<Goods>> getLocalData() async {
    List<Goods> result = [];
    final myBox = Hive.box<Goods>(HiveConfig.goodsBox);
    final myValue = myBox.values;
    await Future.delayed(const Duration(milliseconds: 500));
    result.addAll(myValue.map((e) => e));
    return Future.value(result);
  }
}
