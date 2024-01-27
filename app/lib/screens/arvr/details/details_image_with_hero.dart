import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/hotels.dart';
import 'package:flutter_hackathon/screens/arvr/details/more_details_image.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/custom_error_icon.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/ext.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/helper.dart';
import 'package:flutter_hackathon/screens/arvr/details/utils/love_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reusable_components/reusable_components.dart';

class DetailsImageWithHero extends StatelessWidget {
  const DetailsImageWithHero({
    super.key,
    required this.hotel,
  });

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          child: Hero(
            tag: hotel.id!,
            child: CachedNetworkImage(
              imageUrl: hotel.images![0].path!,
              height: SizeConfig.screenHeight! * 0.45,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const CustomErrorIcon(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 27.h,
            horizontal: 24.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 24.w,
                width: 24.w,
                color: HexColorHandler('A0A0A0'),
                child: Center(
                  child: GestureDetector(
                    onTap: () => context.getBack(),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18.w,
                    ),
                  ),
                ),
              ),
              LoveBorderIcon(
                hotel: hotel,
                iconSize: 24,
                borderColor: Colors.white,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 19.h,
          right: 19.w,
          child: Column(
            children: List.generate(
              Helper.getLength(hotel.images!),
              (index) => MoreDetailsImages(
                index: index,
                lastIndex: Helper.getLength(hotel.images!) - 1,
                imagesNumber: Helper.getLength(hotel.images!),
                hotel: hotel,
                image: hotel.images![index].path!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
