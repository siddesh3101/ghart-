import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/app_text_style.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/app_colors.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reusable_components/reusable_components.dart';

class GlowingCustomButton extends StatelessWidget {
  const GlowingCustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return MyCustomButton(
      onPressed: onPressed,
      height: 50.h,
      width: 148.w,
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
      backgroundColor: AppColors.primaryColor,
      boxShadow: [
        Helper.glowingShadow(),
      ],
      hasPrefix: false,
      child: Center(
        child: Text(
          buttonText,
          style: AppTextStyles.textStyle15.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
