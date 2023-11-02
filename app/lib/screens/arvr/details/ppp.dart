import 'package:flutter/material.dart';

import 'package:flutter_hackathon/screens/arvr/details/models/app_text_style.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/app_colors.dart';
import 'package:reusable_components/reusable_components.dart';

class PricePerNightText extends StatelessWidget {
  const PricePerNightText({
    super.key,
    this.fontSize,
    this.mainAxisAlignment,
    this.price,
  });

  final double? price;
  final double? fontSize;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
      children: <Widget>[
        Text(
          price!.toStringAsFixed(1),
          style: AppTextStyles.bottomNavTextStyle.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              color: Colors.black.withOpacity(0.6)),
        ),
        Text(
          '/night',
          style: AppTextStyles.bottomNavTextStyle.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              color: HexColorHandler('4E4C4C').withOpacity(0.53)),
        ),
      ],
    );
  }
}
