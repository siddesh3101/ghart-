import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/app_text_style.dart';

class DetailsSectionTitle extends StatelessWidget {
  const DetailsSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.textStyle15.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
