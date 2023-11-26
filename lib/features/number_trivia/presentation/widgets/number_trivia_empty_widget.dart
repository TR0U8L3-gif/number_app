
import 'package:flutter/material.dart';

import '../../../../config/assets.dart';
import '../../../../config/theme.dart';
import 'message_display.dart';
import 'title_display.dart';

class NumberTriviaEmptyWidget extends StatelessWidget {
  const NumberTriviaEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const TitleDisplay(title: "Number Trivia"),
        const MessageDisplay(
          message: "start searching",
          isFontSizeLarge: false,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: paddingMedium),
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Image.asset(
                  Assets.imagesNumberTriviaLogo,
                  width: size.width * 0.48,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
