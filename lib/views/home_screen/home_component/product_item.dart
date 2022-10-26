import 'package:ecom/controllers/home_provider.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/views/home_screen/cart_component/cart_component.dart';
import 'package:ecom/views/home_screen/home_component/home_component.dart';
import 'package:ecom/views/home_screen/home_component/product_description.dart';
import 'package:ecom/views/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:provider/provider.dart';

import '../../../models/home_screen/product_component/product_model.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.productItem});
  static const String routeName = "ProductItem";
  final ProductItemModel productItem;
  static MaterialPage page(ProductItemModel itemModel) {
    return MaterialPage(
      child: ProductItem(
        productItem: itemModel,
      ),
      name: routeName,
      key: const ValueKey(routeName),
    );
  }

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Product detail',
        style: AppTypography.title.copyWith(
          color: Colors.black,
        ),
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildPicture(context),
              _buildInfo(context),
              40.verticalSpace,
              _buildSeeDescriptionButton(context),
              40.verticalSpace,
              _buildRelatedList(context),
              20.verticalSpace,
              _buildOptionsButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            text: 'Add to cart',
            color: Colors.white,
            textColor: Colors.black,
            width: 150.w,
            function: () {
              context.read<HomeProvider>().addProduct(widget.productItem);
            },
          ),
          CustomButton(
            text: 'Buy now',
            textColor: Colors.black,
            color: AppColor.buttonColor,
            width: 150.w,
            function: () {},
          )
        ],
      ),
    );
  }

  Widget _buildRelatedList(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RELATED PRODUCT',
                style: AppTypography.title.copyWith(color: Colors.black),
              ),
              Text(
                'See more',
                style: AppTypography.title.copyWith(
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
        10.verticalSpace,
        _buildchooseProduct(context, widget.productItem.category)
      ],
    );
  }

  Widget _buildSeeDescriptionButton(BuildContext context) {
    return CustomButton(
      text: 'See desciption',
      color: AppColor.buttonColor,
      function: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) {
          return ProductDescriptionScreen(
            product: widget.productItem,
          );
        }),
      ),
      textColor: Colors.black,
      icon: const Icon(
        Icons.arrow_right,
        color: Colors.black,
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.productItem.name, style: AppTypography.body),
          Row(
            children: List.generate(
              5,
              (index) {
                if (widget.productItem.rate - 1 >= index) {
                  return Icon(Icons.star, color: AppColor.buttonColor);
                } else {
                  return const Icon(Icons.star);
                }
              },
            ),
          ),
          Text(
            '${widget.productItem.price} \$',
            style: AppTypography.body.copyWith(color: Colors.red),
          )
        ],
      ),
    );
  }

  Widget _buildPicture(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            ImagePixels.container(
              imageProvider: AssetImage(widget.productItem.imageURL),
              colorAlignment: Alignment.topLeft,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                alignment: Alignment.center,
                child: Image(image: AssetImage(widget.productItem.imageURL)),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back)),
                      const Expanded(child: SizedBox()),
                      IconButton(
                          onPressed: () {},
                          icon: const FaIcon(FontAwesomeIcons.heart)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.share)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildchooseProduct(BuildContext context, String category) {
    late final dynamic future;
    if (category == 'shoe') {
      future = Provider.of<HomeProvider>(context, listen: false).mockAPIShoes();
    } else if (category == 'pant' || category == 'pants') {
      future = Provider.of<HomeProvider>(context, listen: false).mockAPIPants();
    } else {
      future = Provider.of<HomeProvider>(context, listen: false).mockAPIShirt();
    }
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (!snapshot.hasData && (snapshot.data! as List).isEmpty) {
              return Center(
                child: Text(
                  'No related products',
                  style: AppTypography.body,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Some errors occur',
                  style: AppTypography.body,
                ),
              );
            } else {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = (snapshot.data! as List)[index];
                  return GestureDetector(
                    onTap: () {
                      context.goNamed(
                        ProductItem.routeName,
                        extra: <String, Object>{'item': item},
                        params: <String, String>{
                          'name': '${item.name.split(' ').join()}',
                        },
                      );
                    },
                    child: ItemComponent(
                      imageUrl: item.imageURL,
                    ),
                  );
                },
                separatorBuilder: (context, index) => 15.horizontalSpace,
                itemCount: (snapshot.data! as List).length,
              );
            }
          }
        },
      ),
    );
  }
}
