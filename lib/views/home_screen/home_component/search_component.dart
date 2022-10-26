import 'package:ecom/theme/app_color.dart';
import 'package:ecom/theme/app_font.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 30.h,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 320.w,
          height: 40.h,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  style: AppTypography.title.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                  ),
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Find your products',
                    hintStyle: AppTypography.title.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: AppColor.primaryDarker,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              2.horizontalSpace,
              IconButton(
                icon: const Image(
                  image: AssetImage(
                    'assets/home_screen/ic-cart.png',
                  ),
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
