import 'package:flutter/material.dart';

import '../../../../config/theme.dart';
import 'message_display.dart';
import 'title_display.dart';

class NumberTriviaLoadingWidget extends StatelessWidget {
  const NumberTriviaLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const TitleDisplay(title: "Number Trivia"),
        const MessageDisplay(
          message: "Loading...",
          isFontSizeLarge: false,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              padding: const EdgeInsets.all(paddingSmall),
              child: const CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}

