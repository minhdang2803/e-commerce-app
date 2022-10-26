import 'package:ecom/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DigitalWalletComponent extends StatelessWidget {
  const DigitalWalletComponent({super.key});
  static const String routeName = 'DigitalWalletComponent';
  static MaterialPage page() {
    return const MaterialPage(
      child: DigitalWalletComponent(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Digital Wallet',
          style: AppTypography.title.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            DigitalWalletCard(
              title: 'Momo',
              imageUrl: 'assets/home_screen/momo.png',
              onTap: () {},
            ),
            DigitalWalletCard(
              title: 'VNPay',
              imageUrl: 'assets/home_screen/vnpay.png',
              onTap: () {},
            ),
            DigitalWalletCard(
              title: 'ZaloPay',
              imageUrl: 'assets/home_screen/zalopay.png',
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

class DigitalWalletCard extends StatelessWidget {
  const DigitalWalletCard(
      {super.key, required this.title, required this.imageUrl, this.onTap});

  final String title;
  final String imageUrl;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.r),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: AppTypography.body.copyWith(color: Colors.black),
        ),
        leading: Image(
          image: AssetImage(imageUrl),
          height: 30.r,
          width: 30.r,
        ),
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }
}
