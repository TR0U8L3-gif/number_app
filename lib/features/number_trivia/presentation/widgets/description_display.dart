import 'package:flutter/material.dart';
import '../../../../config/theme.dart';

class DescriptionDisplay extends StatelessWidget {
  final String trivia;

  const DescriptionDisplay({super.key, required this.trivia});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(paddingLarge)),
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: paddingSmall),
              child: Text(
                trivia,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: fontMedium, color: AppColors.lightText),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
