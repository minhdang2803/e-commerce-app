/*
name
imageURL: Link đến internetImage (imgur)
description:
price: (fake giá th được rồi)
rate: (int: 1-5, fake th được rồi)
promotion: (New product/ Discount/ cả hai)
*/

import 'package:equatable/equatable.dart';

class ProductItemModel extends Equatable {
  final int id;
  final String name;
  final String imageURL;
  final String description;
  final String price;
  final int rate;
  final String promotion;
  final String category;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.description,
    required this.price,
    required this.promotion,
    required this.rate,
    required this.category,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
        id: json['id'],
        category: json['category'],
        name: json['name'],
        imageURL: json['imageURL'],
        description: json['description'],
        price: json['price'],
        promotion: json['promotion'],
        rate: json['rate']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        imageURL,
        description,
        price,
        promotion,
        category,
      ];
}
