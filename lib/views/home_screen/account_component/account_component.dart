import 'package:ecom/controllers/controllers.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/views/home_screen/account_component/cards_screen.dart';
import 'package:ecom/views/home_screen/account_component/digital_wallet_screen.dart';
import 'package:ecom/views/home_screen/account_component/edit_profile.dart';
import 'package:ecom/views/home_screen/account_component/history_screen.dart';
import 'package:ecom/views/home_screen/account_component/shopping_address_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_color.dart';
import '../../../utils/shared_preference.dart';
import '../../onboarding_screen/onboarding_screen.dart';

class AccountComponent extends StatefulWidget {
  const AccountComponent({super.key});
  static const String routeName = "AccountComponent";
  static NoTransitionPage page() {
    return const NoTransitionPage<void>(
      child: AccountComponent(),
      name: routeName,
      key: ValueKey(routeName),
    );
  }

  @override
  State<AccountComponent> createState() => _AccountComponentState();
}

class _AccountComponentState extends State<AccountComponent> {
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
          _buildProfileBar(context),
          _buildProfileAvatar(context),
          _buildOptions(context)
        ],
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              children: [
                AccountOption(
                  leadingIcon: FontAwesomeIcons.user,
                  title: 'Edit profile',
                  onTap: () => context.pushNamed(
                    EditProfileScreen.routeName,
                  ),
                ),
                AccountOption(
                  leadingIcon: FontAwesomeIcons.clock,
                  title: 'Order history',
                  onTap: () => context.pushNamed(
                    OrderHistoryScreen.routeName,
                  ),
                ),
                AccountOption(
                  leadingIcon: FontAwesomeIcons.creditCard,
                  title: 'Cards',
                  onTap: () => context.pushNamed(
                    CardsScreen.routeName,
                  ),
                ),
                AccountOption(
                  leadingIcon: FontAwesomeIcons.addressCard,
                  title: 'Shopping address',
                  onTap: () => context.pushNamed(
                    AddressScreen.routeName,
                  ),
                ),
                AccountOption(
                  leadingIcon: FontAwesomeIcons.wallet,
                  title: 'Digital wallet',
                  onTap: () => context.pushNamed(
                    DigitalWalletComponent.routeName,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Positioned.fill(
      top: 80.h,
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            AvatarComponent(
              imageUrl: user?.photoURL,
            ),
            5.verticalSpace,
            Text(
              user?.displayName ?? 'Unknown',
              style: AppTypography.title.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBar(BuildContext context) {
    return Positioned.fill(
      top: 30.h,
      left: 20.w,
      right: 20.w,
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Profile',
              style: AppTypography.title.copyWith(color: Colors.white),
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Provider.of<LoginProvider>(context, listen: false)
                    .logoutGoogle();
                SharedPref.instance.remove('isLoggedIn');
                context.goNamed(OnboardingScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AccountOption extends StatelessWidget {
  const AccountOption({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final IconData leadingIcon;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: FaIcon(
        leadingIcon,
        color: Colors.black,
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right_outlined,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: AppTypography.body.copyWith(color: Colors.black),
      ),
    );
  }
}

class AvatarComponent extends StatelessWidget {
  const AvatarComponent({super.key, required this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    bool isTrue = imageUrl != null;
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.r),
      child: SizedBox(
        width: 100.r,
        height: 100.r,
        child: Image(
          image: (isTrue
              ? NetworkImage(imageUrl!)
              : const AssetImage('assets/auth/null.png') as ImageProvider),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
