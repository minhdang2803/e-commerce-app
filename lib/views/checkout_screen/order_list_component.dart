import 'package:ecom/models/home_screen/product_component/goods_model.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controllers/home_provider.dart';

class ProductDropdown extends StatelessWidget {
  const ProductDropdown(
      {super.key, required this.itemModel, this.isCheckout = false});
  final Goods itemModel;
  final bool isCheckout;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          10.horizontalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.network(
              itemModel.imgUrl,
              width: 100.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(itemModel.productName, style: AppTypography.body),
                ),
                Text('\$${itemModel.truePrice}', style: AppTypography.body),
                (isCheckout ? _buildQuantity(context, itemModel) : Container())
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantity(BuildContext context, Goods item) {
    return Row(
      children: [
        Text(
          "Total: ${context.watch<HomeProvider>().numberOfItem[item.id] ?? 0}",
          style: AppTypography.body,
        ),
      ],
    );
  }
}
