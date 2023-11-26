import 'package:flutter/material.dart';
import '../../../../config/theme.dart';

class TitleDisplay extends StatelessWidget {
  final String title;

  const TitleDisplay({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingSmall),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.lightText, fontSize: fontSmall),
      ),
    );
  }
}
