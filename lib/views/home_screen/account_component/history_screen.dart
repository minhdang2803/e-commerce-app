import 'package:ecom/controllers/controllers.dart';
import 'package:ecom/extension/extensions.dart';
import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';

enum DeliveryStatus { shipped, shipping, wating }

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});
  static const String routeName = "OrderHistoryScreen";
  static MaterialPage page() {
    return const MaterialPage(
      child: OrderHistoryScreen(),
      name: OrderHistoryScreen.routeName,
      key: ValueKey(OrderHistoryScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track Orders',
          style: AppTypography.body.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: ListView.separated(
            itemCount: provider.historyInfos.length,
            itemBuilder: (context, index) {
              final info = provider.historyInfos[index];
              return HistoryInfo(
                time: info.time,
                cardModels: info.historyCardModel,
              );
            },
            separatorBuilder: (context, index) => 10.verticalSpace,
          ),
        ),
      ),
    );
  }
}

class HistoryInfo extends StatelessWidget {
  const HistoryInfo({
    super.key,
    required this.time,
    required this.cardModels,
  });
  final String time;
  final List<HistoryCardModel> cardModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: AppTypography.title,
        ),
        5.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          primary: false,
          itemBuilder: (context, index) {
            final currentCard = cardModels[index];
            return HistoryCard(
              title: currentCard.title,
              price: currentCard.price,
              status: currentCard.status,
            );
          },
          separatorBuilder: (context, index) => 5.verticalSpace,
          itemCount: cardModels.length,
        )
      ],
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.price,
    required this.status,
    required this.title,
  });
  final String title;
  final String price;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  title,
                  style: AppTypography.title.copyWith(color: Colors.black),
                ),
              ),
              5.verticalSpace,
              Text(
                price,
                style: AppTypography.body.copyWith(color: Colors.black),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: getColor(status),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Text(
                  status.capitalize(),
                  style: AppTypography.body.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(String status) {
    if (status == 'shipping') {
      return AppColor.buttonColor;
    } else if (status == 'shipped') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
