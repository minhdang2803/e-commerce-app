import 'package:ecom/controllers/home_provider.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/views/checkout_screen/order_list_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/home_screen/product_component/goods_model.dart';
import '../../../theme/app_font.dart';
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
  late List<Goods> valueList;
  List<Goods> displayList = [];
  @override
  void initState() {
    super.initState();
    valueList = context.read<HomeProvider>().getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          10.verticalSpace,
          _buildSearchBar(context),
          20.verticalSpace,
          // _buildListView(context),
          displayList.isEmpty ? _buildEmptyCart() : _buildContent(context)
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final item = displayList[index];
          return GestureDetector(
              onTap: () {
                context.goNamed(
                  ProductItem.routeName,
                  extra: <String, Object>{'item': item},
                  params: <String, String>{
                    'name': item.productName.split(' ').join(),
                  },
                );
              },
              child: ProductDropdown(itemModel: item));
        },
        itemCount: displayList.length,
      ),
    );
  }

  Widget _buildEmptyCart() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/home_screen/empty-card.svg'),
          10.verticalSpace,
          Text('Nothing Found', style: AppTypography.title)
        ],
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
              onChanged: (value) {
                if (value == '') {
                  setState(() {
                    displayList = [];
                  });
                } else {
                  setState(() {
                    displayList = valueList
                        .where((element) => element.productName
                            .toLowerCase()
                            .contains(value!.toLowerCase()))
                        .toList();
                  });
                }
              },
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
