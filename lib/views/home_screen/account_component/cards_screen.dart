import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/models.dart';
import '../../../utils/utils.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});
  static const String routeName = "CardsScreen";
  static MaterialPage page() {
    return const MaterialPage(
      child: CardsScreen(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cards',
          style: AppTypography.title.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.r),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final current = cardList[index];
                    return CreditCard(
                      cardModel: current,
                    );
                  },
                  separatorBuilder: (context, index) => 5.verticalSpace,
                  itemCount: cardList.length,
                ),
              ),
              CustomButton(
                text: 'Add card',
                color: AppColor.buttonColor,
                textColor: Colors.black,
                function: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  const CreditCard({super.key, required this.cardModel});
  final CreditCardModel cardModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColor.primary, borderRadius: BorderRadius.circular(10.r)),
      child: Stack(
        children: [
          Positioned.fill(
            top: 10.h,
            right: 30.w,
            child: Align(
              alignment: Alignment.topRight,
              child: Image(
                image: AssetImage(getImage(cardModel.typeOfCard)),
                width: 50.w,
                height: 50.h,
                color: Colors.white,
              ),
            ),
          ),
          _buildCornerOval(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              40.verticalSpace,
              _buildSeriesNumber(context),
              _buildCustomerInfo(context),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              'Card holder',
              style: AppTypography.bodySmall
                  .copyWith(color: Colors.white, fontStyle: FontStyle.italic),
            ),
            Text(
              cardModel.customerName,
              style: AppTypography.bodySmall
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          children: [
            Text(
              'Expiry Date',
              style: AppTypography.bodySmall
                  .copyWith(color: Colors.white, fontStyle: FontStyle.italic),
            ),
            Text(
              cardModel.expiredDay,
              style: AppTypography.bodySmall
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }

  Widget _buildSeriesNumber(BuildContext context) {
    List<String> element = [];
    if (cardModel.cardNumber.contains(' ')) {
      element = cardModel.cardNumber.split(' ');
    } else {
      String temp = '';
      for (int i = 0; i < cardModel.cardNumber.length; i++) {
        if (i % 4 == 0) {
          element.add(temp);
          temp = '';
          temp += cardModel.cardNumber[i];
        } else {
          temp += cardModel.cardNumber[i];
        }
      }
    }
    return SizedBox(
      // height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final e in element)
            Text(
              e,
              style: AppTypography.headline.copyWith(color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildCornerOval(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topLeft,
        child: SvgPicture.asset(
          'assets/home_screen/card-oval.svg',
        ),
      ),
    );
  }

  String getImage(String status) {
    if (status == 'visa') {
      return 'assets/home_screen/visa.png';
    } else if (status == 'jcb') {
      return 'assets/home_screen/jcb.png';
    } else {
      return 'assets/home_screen/mastercard.png';
    }
  }
}

List<dynamic> cardList = [
  CreditCardModel(
    customerName: 'Maxwell Edison',
    expiredDay: '09-23',
    cardNumber: '1234 5673 8911 2243',
    typeOfCard: 'visa',
  ),
  CreditCardModel(
    customerName: 'Maxwell Edison',
    expiredDay: '09-23',
    cardNumber: '1234 5673 8911 2243',
    typeOfCard: 'jcb',
  ),
  CreditCardModel(
    customerName: 'Maxwell Edison',
    expiredDay: '09-23',
    cardNumber: '1234 5673 8911 2243',
    typeOfCard: 'mastercard',
  ),
];
