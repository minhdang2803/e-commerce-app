import 'package:ecom/controllers/home_provider.dart';
import 'package:ecom/models/home_screen/product_component/goods_model.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/utils/utils.dart';
import 'package:ecom/views/home_screen/cart_component/cart_component.dart';
import 'package:ecom/views/home_screen/home_component/home_component.dart';
import 'package:ecom/views/home_screen/home_component/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.productItem});
  static const String routeName = "ProductItem";
  final Goods productItem;
  static MaterialPage page(Goods itemModel) {
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
            function: () {
              context.read<HomeProvider>().addProduct(widget.productItem);
              context.goNamed(CartComponent.routeName);
            },
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
        _buildchooseProduct(context)
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
          Text(widget.productItem.productName, style: AppTypography.body),
          Row(
            children: List.generate(
              5,
              (index) {
                if (widget.productItem.rating - 1 >= index) {
                  return Icon(Icons.star, color: AppColor.buttonColor);
                } else {
                  return const Icon(Icons.star);
                }
              },
            ),
          ),
          Text(
            '${widget.productItem.truePrice} \$',
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
              imageProvider: NetworkImage(widget.productItem.imgUrl),
              colorAlignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.h),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                alignment: Alignment.center,
                child: Image(image: NetworkImage(widget.productItem.imgUrl)),
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

  dynamic getRelatedItem() {
    final product = widget.productItem;
    final provider = context.read<HomeProvider>();
    late Future<dynamic> future;
    if (product.productClass == 'men_accessories') {
      if (product.productLine == 'men-bags') {
        future = provider.getData('woomen/accessories/bags');
      } else if (product.productLine == 'gloves') {
        future = provider.getData('woomen/accessories/gloves');
      } else {
        future = provider.getData('woomen/accessories/socks');
      }
    } else if (product.productClass == 'women_accessories') {
      if (product.productLine == 'women-bags') {
        future = provider.getData('men/accessories/bags');
      } else if (product.productLine == 'women-gloves') {
        future = provider.getData('men/accessories/gloves');
      } else {
        future = provider.getData('men/accessories/socks');
      }
    } else if (product.productClass == 'men_clothing') {
      if (product.productLine == 'men-hoodies_sweatshirts') {
        future = provider.getData('woomen/clothing/hoodies');
      } else if (product.productLine == 'men-jackets') {
        future = provider.getData('woomen/clothing/jackets');
      } else {
        future = provider.getData('woomen/clothing/pants');
      }
    } else if (product.productClass == 'women_clothing') {
      if (product.productLine == 'women-hoodies_sweatshirts') {
        future = provider.getData('men/clothing/hoodies');
      } else if (product.productLine == 'women-jackets') {
        future = provider.getData('men/clothing/jackets');
      } else {
        future = provider.getData('men/clothing/pants');
      }
    } else if (product.productClass == 'men_shoes') {
      if (product.productLine == 'men-basketball-shoes') {
        future = provider.getData('woomen/shoes/basketball');
      } else {
        future = provider.getData('woomen/shoes/running');
      }
    } else if (product.productClass == 'women_shoes') {
      if (product.productLine == 'women-basketball-shoes') {
        future = provider.getData('men/shoes/basketball');
      } else {
        future = provider.getData('men/shoes/running');
      }
    }
    return future;
  }

  Widget _buildchooseProduct(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: getRelatedItem(),
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
                          'name': '${item.productName.split(' ').join()}',
                        },
                      );
                    },
                    child: ItemComponent(
                      imageUrl: item.imgUrl,
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
