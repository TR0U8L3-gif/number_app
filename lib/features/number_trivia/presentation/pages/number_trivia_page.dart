import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme.dart';
import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(child: buildBody(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => locator<NumberTriviaBloc>(),
      child: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(vertical: paddingSmall, horizontal: paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleDisplay(title: "Number Trivia"),
            Expanded(
              child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(builder: (context, state) {
                if (state is NumberTriviaEmpty) {
                  return const NumberTriviaEmptyWidget();
                }
                if (state is NumberTriviaLoading) {
                  return const NumberTriviaLoadingWidget();
                }
                if (state is NumberTriviaLoaded) {
                  return NumberTriviaLoadedWidget(numberTrivia: state.numberTrivia);
                }
                if (state is NumberTriviaError) {
                  return NumberTriviaErrorWidget(message: state.message);
                }
                return const SizedBox();
              }),
            ),
            Navigation()
          ],
        ),
      ),
    );
  }
}




