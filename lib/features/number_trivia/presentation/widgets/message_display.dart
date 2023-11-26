import 'package:flutter/material.dart';
import '../../../../config/theme.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  final bool isFontSizeLarge;
  final bool isErrorMessage;

  const MessageDisplay({super.key, required this.message, this.isFontSizeLarge = true, this.isErrorMessage = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: paddingLarge),
      child: Container(
        width: size.width,
        height: 80,
        padding: const EdgeInsets.all(paddingSmall),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(paddingLarge)),
          color: AppColors.lightBackground,
        ),
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: isFontSizeLarge ? fontLarge : fontMedium, color: isErrorMessage ? AppColors.darkOrange : AppColors.lightBlue),
            ),
          ),
        ),
      ),
    );
  }
}
