import 'package:hive/hive.dart';
part 'goods_model.g.dart';

@HiveType(typeId: 0)
class Goods extends HiveObject {
  Goods({
    required this.description,
    required this.id,
    required this.imgUrl,
    required this.productClass,
    required this.productLine,
    required this.productName,
    required this.promotion,
    required this.rating,
    this.salePrice,
    required this.truePrice,
  });
  @HiveField(0)
  late final String description;
  @HiveField(1)
  late final int id;
  @HiveField(2)
  late final String imgUrl;
  @HiveField(3)
  late final String productClass;
  @HiveField(4)
  late final String productLine;
  @HiveField(5)
  late final String productName;
  @HiveField(6)
  late final String promotion;
  @HiveField(7)
  late final int rating;
  @HiveField(8)
  late final String? salePrice;
  @HiveField(9)
  late final String truePrice;

  Goods.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imgUrl = json['img_url'];
    productClass = json['product_class'];
    productLine = json['product_line'];
    productName = json['product_name'];
    promotion = json['promotion'];
    rating = json['rating'];
    salePrice = json['sale_price'];
    truePrice = json['true_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['description'] = description;
    _data['id'] = id;
    _data['img_url'] = imgUrl;
    _data['product_class'] = productClass;
    _data['product_line'] = productLine;
    _data['product_name'] = productName;
    _data['promotion'] = promotion;
    _data['rating'] = rating;
    _data['sale_price'] = salePrice;
    _data['true_price'] = truePrice;
    return _data;
  }
}
