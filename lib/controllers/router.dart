import 'package:ecom/controllers/app_state.dart';
import 'package:ecom/models/home_screen/product_component/product_model.dart';
import 'package:ecom/views/home_screen/account_component/account_component.dart';
import 'package:ecom/views/home_screen/account_component/cards_screen.dart';
import 'package:ecom/views/home_screen/account_component/digital_wallet_screen.dart';
import 'package:ecom/views/home_screen/account_component/edit_profile.dart';
import 'package:ecom/views/home_screen/account_component/history_screen.dart';
import 'package:ecom/views/home_screen/account_component/shopping_address_screen.dart';
import 'package:ecom/views/home_screen/cart_component/cart_component.dart';
import 'package:ecom/views/home_screen/home_component/home_component.dart';
import 'package:ecom/views/home_screen/home_component/product_item.dart';
import 'package:ecom/views/home_screen/product_component/product_component.dart';
import 'package:ecom/views/login_screen/login_screen.dart';
import 'package:ecom/views/onboarding_screen/onboarding_screen.dart';
import 'package:ecom/views/register_screen/register_screen.dart';
import 'package:ecom/views/reset_password/reset_password_screen.dart';
import 'package:ecom/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/home_screen/home_screen.dart';

/// Navigator 2.0, how to use?g
/// https://pub.dev/documentation/go_router/latest/
///
/// gorouter.dev (Ngta đang update document nên tạm coi link trên nha
/// tại go_router mới migrate lên 5.)
class MyRouter {
  final AppState appState;
  bool isLoggedIn;
  MyRouter(this.appState, this.isLoggedIn);
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();
  late GoRouter myRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: appState,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) =>
            state.namedLocation(SplashScreen.routeName),
      ),
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        pageBuilder: (context, state) => SplashScreen.page(),
      ),
      GoRoute(
        path: '/onboarding',
        name: OnboardingScreen.routeName,
        pageBuilder: (context, state) => OnboardingScreen.page(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        pageBuilder: (context, state) => LoginScreen.page(),
      ),
      GoRoute(
        path: '/register',
        name: RegisterScreen.routeName,
        pageBuilder: (context, state) => RegisterScreen.page(),
      ),
      GoRoute(
        path: '/reset',
        name: ResetPassword.routeName,
        pageBuilder: (context, state) => ResetPassword.page(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return HomeScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: HomeComponent.routeName,
            pageBuilder: (context, state) => HomeComponent.page(),
            routes: [
              GoRoute(
                path: ':name',
                name: ProductItem.routeName,
                pageBuilder: (context, state) {
                  final Map<String, Object> extra =
                      state.extra! as Map<String, Object>;
                  return ProductItem.page(extra['item'] as ProductItemModel);
                },
              )
            ],
          ),
          GoRoute(
            path: '/product',
            name: ProductComponent.routeName,
            pageBuilder: (context, index) => ProductComponent.page(),
            routes: [],
          ),
          GoRoute(
            path: '/cart',
            name: CartComponent.routeName,
            pageBuilder: (context, state) => CartComponent.page(),
            routes: [],
          ),
          GoRoute(
            path: '/account',
            name: AccountComponent.routeName,
            pageBuilder: (context, state) => AccountComponent.page(),
            routes: [
              GoRoute(
                path: 'histories',
                name: OrderHistoryScreen.routeName,
                pageBuilder: (context, state) => OrderHistoryScreen.page(),
              ),
              GoRoute(
                path: 'addresses',
                name: AddressScreen.routeName,
                pageBuilder: (context, state) => AddressScreen.page(),
              ),
              GoRoute(
                path: 'cards',
                name: CardsScreen.routeName,
                pageBuilder: (context, state) => CardsScreen.page(),
              ),
              GoRoute(
                path: 'userinfo',
                name: EditProfileScreen.routeName,
                pageBuilder: (context, state) => EditProfileScreen.page(),
              ),
              GoRoute(
                path: 'digitalwallet',
                name: DigitalWalletComponent.routeName,
                pageBuilder: (context, state) => DigitalWalletComponent.page(),
              ),
            ],
          )
        ],
      ),
    ],
    redirect: (context, state) {
      if (state.subloc == '/splash' && !appState.isSplashScreenDone) {
        appState.initializedApp();
        return null;
      }
      if (state.subloc == '/splash' &&
          appState.isSplashScreenDone &&
          !appState.isOnboardingSceenDone) {
        appState.onBoaringScreenProcess();
        if (isLoggedIn) {
          return state.namedLocation(HomeComponent.routeName);
        } else {
          return state.namedLocation(OnboardingScreen.routeName);
        }
      }
      return null;
    },
  );
}
