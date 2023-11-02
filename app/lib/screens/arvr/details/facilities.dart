import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/app_text_style.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/facility.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reusable_components/reusable_components.dart';

class Facilities extends StatelessWidget {
  const Facilities({super.key, required this.facilities});

  final List<Facility> facilities;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20.w,
      verticalDirection: VerticalDirection.down,
      direction: Axis.horizontal,
      children: List.generate(
        facilities.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.network(
              facilities[index].icon!,
              height: SizeConfig.screenHeight! * 0.04,
              width: SizeConfig.screenHeight! * 0.04,
              fit: BoxFit.cover,
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.009),
            Text(
              facilities[index].name!,
              style: AppTextStyles.textStyle14Medium.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.lightGrey.withOpacity(0.49)),
            )
          ],
        ),
      ),
    );
  }
}
