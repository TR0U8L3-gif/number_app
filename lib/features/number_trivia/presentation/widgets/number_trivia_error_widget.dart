
import 'package:flutter/material.dart';

import 'description_display.dart';
import 'message_display.dart';
import 'title_display.dart';

class NumberTriviaErrorWidget extends StatelessWidget {
  final String message;
  const NumberTriviaErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleDisplay(title: "Number Trivia"),
        const MessageDisplay(
          message: "Error",
          isErrorMessage: true,
        ),
        DescriptionDisplay(trivia: message),
      ],
    );
  }
}
