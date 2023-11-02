import 'package:flutter/material.dart';

import 'package:flutter_hackathon/screens/arvr/details/models/hotels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoveBorderIcon extends StatelessWidget {
  const LoveBorderIcon({
    super.key,
    required this.hotel,
    required this.iconSize,
    required this.borderColor,
  });

  final Hotel hotel;
  final double iconSize;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // if it's in favorite, remove : else add
        // cubit.favoriteHotels.contains(hotel)
        //     ? cubit.removeFromFav(hotelId: hotel.id!)
        //     : cubit.addToFav(hotelId: hotel.id!);
      },
      icon: Icon(
        Icons.favorite,
        color: Colors.red,
        size: iconSize.w,
      ),
    );
  }
}
