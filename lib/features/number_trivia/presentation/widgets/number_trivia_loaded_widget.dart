import 'package:flutter/material.dart';

import '../../domain/entities/number_trivia.dart';
import 'description_display.dart';
import 'message_display.dart';
import 'title_display.dart';

class NumberTriviaLoadedWidget extends StatelessWidget {
  final NumberTrivia numberTrivia;
  const NumberTriviaLoadedWidget({super.key, required this.numberTrivia});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleDisplay(title: numberTrivia.isFromCache ? "Cached Number Trivia" : "Number Trivia"),
        MessageDisplay(
          message: "${numberTrivia.number}",
        ),
        DescriptionDisplay(trivia: numberTrivia.text),
      ],
    );
  }
}

