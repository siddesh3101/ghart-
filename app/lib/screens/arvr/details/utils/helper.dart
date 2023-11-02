import 'package:flutter/material.dart';

import 'package:flutter_hackathon/screens/arvr/details/models/app_text_style.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/hotels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class Helper {
  static int? uId;
  // static UserModel? currentUser;

  // static void getUserAndFavorites(BuildContext context) {
  //   BlocProvider.of<RoomeCubit>(context).getUserData();
  //   BlocProvider.of<FavoriteCubit>(context).getFavorites();
  // }

  static UnderlineInputBorder buildUnderlineInputBorder({Color? color}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color ?? AppColors.primaryColor,
        width: 0.75.w,
      ),
    );
  }

  static void validatingPasswordField({
    required BuildContext context,
    String? value,
  }) {
    if (value!.isEmpty) {
      CustomSnackBar.show(
        context: context,
        title: "Something went wrong",
        message: "Password can't be blank!",
      );
    } else if (value.length < 8) {
      CustomSnackBar.show(
        context: context,
        title: "Something went wrong",
        message: "Too short password!",
      );
    }
  }

  static void validatingEmailField({
    required BuildContext context,
    String? value,
  }) {
    if (value!.isEmpty) {
      CustomSnackBar.show(
        context: context,
        title: "Something went wrong",
        message: "Email can't be blank!",
      );
    } else if (!value.contains('@')) {
      CustomSnackBar.show(
        context: context,
        title: "Something went wrong",
        message: "Incorrect Email!",
      );
    }
  }

  static void validatingNameField({
    required BuildContext context,
    required textName,
    String? value,
  }) {
    if (value!.isEmpty) {
      CustomSnackBar.show(
        context: context,
        title: "Something went wrong",
        message: "$textName can't be blank!",
      );
    }
  }

  static BoxDecoration buildShimmerDecoration(ThemeData state) {
    return BoxDecoration(
      color: state.brightness == Brightness.light
          ? AppColors.shimmerContainerColor
          : AppColors.darkShimmerContainerColor,
      borderRadius: BorderRadius.all(
        Radius.circular(AppConstants.shimmerRadius),
      ),
    );
  }

  static BoxShadow glowingShadow() {
    return BoxShadow(
      offset: Offset(0, 4.93.w),
      blurRadius: 18.49.w,
      color: AppColors.primaryColor.withOpacity(0.56),
    );
  }

  static int getLength(List<HotelImage> hotelImages) {
    return hotelImages.length >= 4 ? 3 : hotelImages.length;
  }
}

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required String title,
    IconData icon = Icons.warning_rounded,
    Color backgroundColor = Colors.red,
    bool showCloseIcon = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
        content: Row(
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 40.w),
            SizedBox(width: 10.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: AppTextStyles.textStyle15.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    message,
                    style:
                        AppTextStyles.textStyle12.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        dismissDirection: DismissDirection.horizontal,
        showCloseIcon: showCloseIcon,
        closeIconColor: Colors.white,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}
