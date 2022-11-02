import 'package:hive/hive.dart';

import 'goods_model.dart';


class ECommerceData {
  ECommerceData({
    required this.men,
    required this.women,
  });
  late final Men men;
  late final Women women;

  ECommerceData.fromJson(Map<String, dynamic> json) {
    men = Men.fromJson(json['men']);
    women = Women.fromJson(json['women']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['men'] = men.toJson();
    _data['women'] = women.toJson();
    return _data;
  }
}

class Men {
  Men({
    required this.accessories,
    required this.clothing,
    required this.shoes,
  });
  late final List<Goods> accessories;
  late final List<Goods> clothing;
  late final List<Goods> shoes;

  Men.fromJson(Map<String, dynamic> json) {
    accessories =
        List.from(json['accessories']).map((e) => Goods.fromJson(e)).toList();
    clothing =
        List.from(json['clothing']).map((e) => Goods.fromJson(e)).toList();
    shoes = List.from(json['shoes']).map((e) => Goods.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accessories'] = accessories.map((e) => e.toJson()).toList();
    _data['clothing'] = clothing.map((e) => e.toJson()).toList();
    _data['shoes'] = shoes.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Women {
  Women({
    required this.accessories,
    required this.clothing,
    required this.shoes,
  });
  late final List<Goods> accessories;
  late final List<Goods> clothing;
  late final List<Goods> shoes;

  Women.fromJson(Map<String, dynamic> json) {
    accessories =
        List.from(json['accessories']).map((e) => Goods.fromJson(e)).toList();
    clothing =
        List.from(json['clothing']).map((e) => Goods.fromJson(e)).toList();
    shoes = List.from(json['shoes']).map((e) => Goods.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accessories'] = accessories.map((e) => e.toJson()).toList();
    _data['clothing'] = clothing.map((e) => e.toJson()).toList();
    _data['shoes'] = shoes.map((e) => e.toJson()).toList();
    return _data;
  }
}
