import 'package:ecom/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../controllers/home_provider.dart';
import '../../../theme/app_font.dart';
import '../home_component/home_component.dart';
import '../home_component/product_item.dart';

class ProductComponent extends StatefulWidget {
  const ProductComponent({super.key});
  static const String routeName = "ProductComponent";
  static NoTransitionPage page() {
    return const NoTransitionPage<void>(
      child: ProductComponent(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          10.verticalSpace,
          _buildSearchBar(context),
          20.verticalSpace,
          _buildListView(context),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          CategoryComponent(
            title: 'Shirt',
            onTap: (item) => context.pushNamed(
              ProductItem.routeName,
              extra: <String, Object>{'item': item},
              params: <String, String>{
                'name': '${item.name.split(' ').join()}',
              },
            ),
            future: context.read<HomeProvider>().mockAPIShirt(),
          ),
          CategoryComponent(
            title: 'Shoes',
            onTap: (item) {
              context.pushNamed(
                ProductItem.routeName,
                extra: <String, Object>{'item': item},
                params: <String, String>{
                  'name': '${item.name.split(' ').join()}',
                },
              );
            },
            future: context.read<HomeProvider>().mockAPIShoes(),
          ),
          CategoryComponent(
            title: 'Pants',
            onTap: (item) => Router.neglect(
              context,
              () => context.goNamed(
                ProductItem.routeName,
                extra: <String, Object>{'item': item},
                params: <String, String>{
                },
              ),
            ),
            future: context.read<HomeProvider>().mockAPIPants(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext contexxt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        children: [
          Expanded(
            child: SearchTextField(
              controller: _controller,
              height: 30.h,
              hintColor: Colors.grey,
              textColor: AppColor.textPrimary,
              hintText: 'Find your products',
              onChanged: (value) {},
            ),
          ),
          IconButton(
            icon: const Image(
              image: AssetImage(
                'assets/home_screen/ic-cart.png',
              ),
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    this.height,
    this.width,
    required this.hintColor,
    required this.hintText,
    required this.textColor,
    required this.onChanged,
  });
  final TextEditingController controller;
  final double? height;
  final double? width;
  final Color textColor;
  final Color hintColor;
  final String hintText;
  final void Function(String?) onChanged;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextField(
        enableSuggestions: false,
        autocorrect: false,
        style: AppTypography.title.copyWith(
          color: widget.textColor,
          fontSize: 15,
          decoration: TextDecoration.none,
        ),
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTypography.title.copyWith(
              color: widget.hintColor,
              fontSize: 18,
              decoration: TextDecoration.none,
              height: 0),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: AppColor.inputTextBorder.withOpacity(0.8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/*
name
imageURL: Link đến internetImage (imgur)
description:
price: (fake giá th được rồi)
rate: (int: 1-5, fake th được rồi)
promotion: (New product/ Discount/ cả hai)
*/