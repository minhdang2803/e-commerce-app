import 'package:ecom/theme/app_font.dart';
import 'package:ecom/views/home_screen/home_component/product_item.dart';
import 'package:ecom/views/home_screen/home_component/search_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../controllers/home_provider.dart';
import '../../../theme/app_color.dart';
import 'ads_component.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});
  static const String routeName = "HomeComponent";
  static NoTransitionPage page() {
    return const NoTransitionPage<void>(
      child: HomeComponent(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryDarker,
      child: Stack(
        children: [
          Positioned(
            top: -80.h,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300.h,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(300.r)),
              ),
            ),
          ),
          const SearchBar(),
          AdsCard(
            controller: _controller,
            color: [AppColor.adsColor, Colors.grey.shade200],
            title: const ['Hoodie Colections', 'Many colors available'],
            content: const [
              'Latest shoe recommendations which is being hit right now',
              'Latest shoe recommendations which is being hit right now'
            ],
            imageUrls: const [
              'assets/home_screen/ads1.jpg',
              'assets/home_screen/ads2.png'
            ],
          ),
          ShoppingComponent()
        ],
      ),
    );
  }
}

class ShoppingComponent extends StatelessWidget {
  ShoppingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 350.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: _buildListView(context),
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
    return ListView.separated(
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
      separatorBuilder: (context, index) => 20.verticalSpace,
      itemCount: 16,
    );
  }
}

class CategoryComponent extends StatelessWidget {
  const CategoryComponent(
      {super.key, required this.title, this.onTap, this.future});
  final String title;
  final void Function(dynamic)? onTap;
  final Future? future;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTypography.title),
              Text('See more', style: AppTypography.title),
            ],
          ),
          10.verticalSpace,
          Expanded(
            child: FutureBuilder(
              future: future,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Errpr'),
                    );
                  } else {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return GestureDetector(
                          onTap: () => onTap!(item),
                          child: ItemComponent(
                            imageUrl: item.imgUrl,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 10.horizontalSpace,
                      itemCount: snapshot.data!.length,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemComponent extends StatelessWidget {
  const ItemComponent({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ));
  }
}
