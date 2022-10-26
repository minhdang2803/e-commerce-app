import 'package:ecom/models/home_screen/product_component/product_model.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDescriptionScreen extends StatelessWidget {
  const ProductDescriptionScreen({super.key, required this.product});
  final ProductItemModel product;
  static const String routeName = "ProductDescriptionScreen";
  static MaterialPage page(ProductItemModel item) {
    return MaterialPage(
      child: ProductDescriptionScreen(product: item),
      name: routeName,
      key: const ValueKey(routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: AppTypography.title.copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.r),
          child: Text(
            product.description,
            style: AppTypography.body,
          ),
        ),
      ),
    );
  }
}
