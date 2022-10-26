import 'dart:math';

import 'package:ecom/controllers/home_provider.dart';
import 'package:ecom/models/home_screen/product_component/product_model.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartComponent extends StatefulWidget {
  const CartComponent({super.key});
  static const String routeName = "CartComponent";
  static NoTransitionPage page() {
    return const NoTransitionPage<void>(
      child: CartComponent(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  State<CartComponent> createState() => _CartComponentState();
}

class _CartComponentState extends State<CartComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product cart',
          style: AppTypography.title.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<HomeProvider>(
                  builder: (context, value, child) {
                    return value.cart.isEmpty
                        ? _buildEmptyCart()
                        : _buildCartList(value);
                  },
                ),
              ),
            ),
            _buildAddToCart(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCartList(HomeProvider value) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = value.cart.elementAt(index);
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            value.removeProductAtIndex(item);
          },
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            padding: EdgeInsets.only(right: 10.w),
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
          ),
          child: ProductCard(itemModel: item),
        );
      },
      separatorBuilder: ((context, index) => 10.verticalSpace),
      itemCount: value.cart.length,
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/home_screen/empty-card.svg'),
        10.verticalSpace,
        Text('Nothing in cart', style: AppTypography.title)
      ],
    );
  }

  Widget _buildAddToCart(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price:',
                  style: AppTypography.title.copyWith(color: Colors.black),
                ),
                Text('\$ ${context.watch<HomeProvider>().getTotalPrice()}',
                    style: AppTypography.body.copyWith(color: Colors.red)),
              ],
            ),
            CustomButton(
              width: MediaQuery.of(context).size.width * 0.5,
              text: 'Checkout',
              color: AppColor.buttonColor,
              textColor: Colors.black,
              function: () {},
            )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.itemModel});
  final ProductItemModel itemModel;
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
            child: Image.asset(
              itemModel.imageURL,
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
                  child: Text(itemModel.name, style: AppTypography.body),
                ),
                Text('\$${itemModel.price}', style: AppTypography.body),
                _buildQuantity(context, itemModel)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantity(BuildContext context, ProductItemModel item) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.remove),
          onPressed: () {
            context.read<HomeProvider>().decreaseNumberOfItem(item);
          },
        ),
        Text(
          context.watch<HomeProvider>().numberOfItem[item.id]!.toString(),
          style: AppTypography.body,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.add),
          onPressed: () =>
              context.read<HomeProvider>().increaseNumberOfItem(item),
        )
      ],
    );
  }
}
