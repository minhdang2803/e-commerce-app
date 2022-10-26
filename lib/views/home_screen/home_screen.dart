import 'package:ecom/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AppColor.primary,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home_screen/ic-home.png',
              color: _calculateSelectedIndex(context) == 0
                  ? AppColor.primary
                  : null,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home_screen/ic-product.png',
              color: _calculateSelectedIndex(context) == 1
                  ? AppColor.primary
                  : null,
            ),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home_screen/ic-list.png',
              color: _calculateSelectedIndex(context) == 2
                  ? AppColor.primary
                  : null,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home_screen/ic-user.png',
              color: _calculateSelectedIndex(context) == 3
                  ? AppColor.primary
                  : null,
            ),
            label: 'Account',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/product')) {
      return 1;
    }
    if (location.startsWith('/card')) {
      return 2;
    }
    if (location.startsWith('/account')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/product');
        break;
      case 2:
        GoRouter.of(context).go('/cart');
        break;
      case 3:
        GoRouter.of(context).go('/account');
        break;
    }
  }
}
