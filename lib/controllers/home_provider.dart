import 'package:ecom/controllers/base_provider.dart';
import 'package:ecom/models/home_screen/product_component/product_model.dart';
import 'package:ecom/views/home_screen/cart_component/cart_component.dart';
import 'package:ecom/views/home_screen/home_component/home_component.dart';
import 'package:ecom/views/home_screen/product_component/product_component.dart';
import 'package:flutter/material.dart';

import '../views/home_screen/account_Component/account_component.dart';

/*
name
imageURL: Link đến internetImage (imgur)
description:
price: (fake giá th được rồi)
rate: (int: 1-5, fake th được rồi)
promotion: (New product/ Discount/ cả hai)
*/
class HomeProvider extends BaseProvider {
  Set<ProductItemModel> cart = {};
  Map<int, int> numberOfItem = {};
  void addProduct(ProductItemModel item) {
    if (cart.contains(item)) {
      numberOfItem.update(item.id, (value) => numberOfItem[item.id]! + 1);
    } else {
      cart.add(item);
      numberOfItem.addEntries({item.id: 1}.entries);
    }
    notifyListeners();
  }

  void increaseNumberOfItem(ProductItemModel item) {
    numberOfItem.update(item.id, (value) => numberOfItem[item.id]! + 1);
    notifyListeners();
  }

  void decreaseNumberOfItem(ProductItemModel item) {
    if (numberOfItem[item.id] == 1) {
      cart.removeWhere((element) => element.id == item.id);
      numberOfItem.remove(item.id);
    } else {
      numberOfItem.update(item.id, (value) => numberOfItem[item.id]! - 1);
    }
    notifyListeners();
  }

  void removeProductAtIndex(ProductItemModel item) {
    cart.remove(item);
    numberOfItem.remove(item.id);
    notifyListeners();
  }

  double getTotalPrice() {
    return cart.fold(
      0,
      (previousValue, element) {
        int? totalProduct = numberOfItem[element.id];
        return previousValue += int.parse(element.price) * (totalProduct ?? 1);
      },
    );
  }

  Future<List<ProductItemModel>> mockAPIPants() async {
    late List<ProductItemModel> response;
    await Future.delayed(const Duration(seconds: 1), () {
      response = [
        ProductItemModel(
          id: 1,
          name: 'Arsenal Travel pants',
          imageURL: 'assets/home_screen/pant1.jpeg',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '140',
          promotion: 'np',
          rate: 1,
          category: 'pant',
        ),
        ProductItemModel(
          id: 2,
          name: 'Terrex Zupahike Hiking Pants',
          imageURL: 'assets/home_screen/pant2.jpeg',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '200',
          promotion: 'np',
          rate: 2,
          category: 'pant',
        ),
        ProductItemModel(
          id: 3,
          name: 'Tiro Track Pants',
          imageURL: 'assets/home_screen/pant3.jpeg',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '180',
          promotion: 'np',
          rate: 3,
          category: 'pant',
        ),
      ];
    });
    return response;
  }

  Future<List<ProductItemModel>> mockAPIShoes() async {
    late List<ProductItemModel> response;
    await Future.delayed(const Duration(seconds: 1), () {
      response = [
        ProductItemModel(
          id: 4,
          name: 'Adidas MND V1',
          imageURL: 'assets/home_screen/product_shoe1.png',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '120',
          promotion: 'np',
          rate: 1,
          category: 'shoe',
        ),
        ProductItemModel(
          id: 5,
          name: 'Adidas MND V1',
          imageURL: 'assets/home_screen/product_shoe2.png',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '120',
          promotion: 'np',
          rate: 2,
          category: 'shoe',
        ),
        ProductItemModel(
          id: 6,
          name: 'Adidas MND V2',
          imageURL: 'assets/home_screen/product_shoe2.png',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '120',
          promotion: 'np',
          rate: 3,
          category: 'shoe',
        ),
        ProductItemModel(
          id: 7,
          name: 'Adidas MND V3',
          imageURL: 'assets/home_screen/category_shoe.png',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '120',
          promotion: 'np',
          rate: 4,
          category: 'shoe',
        )
      ];
    });
    return response;
  }

  Future<List<ProductItemModel>> mockAPIShirt() async {
    late List<ProductItemModel> response;
    await Future.delayed(const Duration(seconds: 1), () {
      response = [
        ProductItemModel(
          id: 8,
          name: 'Lyte Ryde Aeroready',
          imageURL: 'assets/home_screen/shirt4.webp',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '140',
          promotion: 'np',
          rate: 1,
          category: 'shirt',
        ),
        ProductItemModel(
          id: 9,
          name: '3-BAR Train Icon',
          imageURL: 'assets/home_screen/shirt3.webp',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '120',
          promotion: 'np',
          rate: 2,
          category: 'shirt',
        ),
        ProductItemModel(
          id: 10,
          name: 'Essential Adicolor Loungeware',
          imageURL: 'assets/home_screen/shirt2.webp',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '120',
          promotion: 'np',
          rate: 3,
          category: 'shirt',
        ),
        ProductItemModel(
          id: 11,
          name: 'Essential Manchester United',
          imageURL: 'assets/home_screen/shirt1.webp',
          description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          price: '120',
          promotion: 'np',
          rate: 4,
          category: 'shirt',
        )
      ];
    });
    return response;
  }
}
