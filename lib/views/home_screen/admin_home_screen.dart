import 'package:ecom/controllers/admin_controller/admin_cubit.dart';
import 'package:ecom/controllers/home_provider.dart';
import 'package:ecom/models/admin_feature/transaction_model.dart';
import 'package:ecom/theme/app_font.dart';
import 'package:ecom/views/screens.dart';
import 'package:ecom/views/widgets/custom_dismiss_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'account_component/account_component_widgets.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  static const String routeName = "AdminHome";
  static CustomTransitionPage page() {
    return CustomTransitionPage<void>(
      key: const ValueKey(routeName),
      name: routeName,
      child: const AdminHomeScreen(),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) =>
          SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(-1.0, 0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.linear),
          ),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminInitial) {
          context.goNamed(OnboardingScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                context.read<AdminCubit>().logOut();
              },
              icon: const Icon(Icons.logout),
            )
          ],
          title: Text(
            'Transactions management',
            style: AppTypography.body.copyWith(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, value, child) {
                    return FutureBuilder(
                      future: value.getTransaction(),
                      builder: (context,
                          AsyncSnapshot<List<ProductTransaction>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                final current = snapshot.data![index];
                                return TransactionCard(transaction: current);
                              },
                              separatorBuilder: (context, index) =>
                                  10.verticalSpace,
                              itemCount: snapshot.data!.length,
                            );
                          } else {
                            return Center(child: _buildEmptyCart());
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/home_screen/empty-card.svg'),
        10.verticalSpace,
        Text('No new orders!', style: AppTypography.title)
      ],
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    required this.transaction,
    Key? key,
  }) : super(key: key);
  final ProductTransaction transaction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaction.time,
            style: AppTypography.title,
          ),
          5.verticalSpace,
          ListView.separated(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            primary: false,
            itemBuilder: (context, index) {
              final currentCard = transaction.items[index];
              if (transaction.items.isEmpty) {
                return _buildEmptyCart();
              }
              return Dismissible(
                key: UniqueKey(),
                background: const CustomDismissBackground(isSecondary: true),
                direction: DismissDirection.horizontal,
                secondaryBackground:
                    const CustomDismissBackground(isSecondary: false),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    context
                        .read<HomeProvider>()
                        .acceptTransaction(transaction, currentCard);
                  }
                },
                child: HistoryCard(
                    title: currentCard.title,
                    price: currentCard.price,
                    status: currentCard.status,
                    quantity: currentCard.quantity),
              );
            },
            separatorBuilder: (context, index) => 5.verticalSpace,
            itemCount: transaction.items.length,
          )
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/home_screen/empty-card.svg'),
        10.verticalSpace,
        Text('No new orders!', style: AppTypography.title)
      ],
    );
  }
}
