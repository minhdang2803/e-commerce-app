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
          // _buildListView(context),
        ],
      ),
    );
  }

  List<String> title = [
    "Men's Bags",
    "Men's Gloves",
    "Men's Socks",
    "Men's Hoodies",
    "Men's Jackets",
    "Men's Pants",
    "Men's Basketball shoes",
    "Men's Running shoes",
    "Women's Bags",
    "Women's Gloves",
    "Women's Socks",
    "Women's Hoodies",
    "Women's Jackets",
    "Women's Pants",
    "Women's Basketball shoes",
    "Women's Running shoes"
  ];
  List<String> urls = [
    "men/accessories/bags",
    "men/accessories/gloves",
    "men/accessories/socks",
    "men/clothing/hoodies",
    "men/clothing/jackets",
    "men/clothing/pants",
    "men/shoes/basketball",
    "men/shoes/running",
    "woomen/accessories/bags",
    "woomen/accessories/gloves",
    "woomen/accessories/socks",
    "woomen/clothing/hoodies",
    "woomen/clothing/jackets",
    "woomen/clothing/pants",
    "woomen/shoes/basketball",
    "woomen/shoes/running",
  ];
  Widget _buildListView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return CategoryComponent(
            title: title[index],
            onTap: (item) => context.goNamed(
              ProductItem.routeName,
              extra: <String, Object>{'item': item},
              params: <String, String>{
                'name': '${item.productName.split(' ').join()}',
              },
            ),
            future: context.read<HomeProvider>().getData(urls[index]),
          );
        },
        itemCount: 16,
      ),
    );
  }

  Widget _buildSearchBar(BuildContext contexxt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
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
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTypography.title.copyWith(
              color: widget.hintColor,
              fontSize: 15,
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
