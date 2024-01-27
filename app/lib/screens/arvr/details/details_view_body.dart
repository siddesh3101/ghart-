import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/arvr/details/details_image.dart';
import 'package:flutter_hackathon/screens/arvr/details/details_image_with_hero.dart';
import 'package:flutter_hackathon/screens/arvr/details/details_section_title.dart';
import 'package:flutter_hackathon/screens/arvr/details/facilities.dart';
import 'package:flutter_hackathon/screens/arvr/details/glowing_custom_button.dart';
import 'package:flutter_hackathon/screens/arvr/details/location_text.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/app_text_style.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/hotels.dart';
import 'package:flutter_hackathon/screens/arvr/details/ppp.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/app_colors.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/app_constants.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reusable_components/reusable_components.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({
    super.key,
    required this.hotel,
    required this.usingHero,
  });

  final Hotel hotel;
  final bool usingHero;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            usingHero
                ? DetailsImageWithHero(hotel: hotel)
                : DetailsImage(hotel: hotel),
            SizedBox(height: SizeConfig.screenHeight! * 0.031),
            Padding(
              padding: EdgeInsets.only(left: 9.w),
              child: FadeInUp(
                from: AppConstants.fadeInUpValue,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      hotel.name!,
                      style: AppTextStyles.appBarTextStyle.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.014),
                    LocationText(location: hotel.location!),
                    SizedBox(height: SizeConfig.screenHeight! * 0.014),
                    const DetailsSectionTitle(title: 'Description'),
                    SizedBox(height: SizeConfig.screenHeight! * 0.014),
                    Text(
                      hotel.description!,
                      style: AppTextStyles.textStyle14Medium.copyWith(
                          fontSize: 13.sp,
                          color: AppColors.lightGrey.withOpacity(0.49)),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.02),
                    const DetailsSectionTitle(title: 'Facilities'),
                    SizedBox(height: SizeConfig.screenHeight! * 0.02),
                    Facilities(facilities: hotel.facilities!),
                    SizedBox(height: SizeConfig.screenHeight! * 0.053),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        PricePerNightText(
                          price: hotel.price,
                          fontSize: 20.sp,
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        GlowingCustomButton(
                          onPressed: () {},
                          buttonText: 'Book Now',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
