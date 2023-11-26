import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme.dart';
import '../bloc/number_trivia_bloc.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  final TextEditingController _controller = TextEditingController();
  String input = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: paddingMedium),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: paddingSmall),
                      child: Container(
                        width: size.width,
                        height: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(paddingLarge)),
                          color: AppColors.lightBackground,
                        ),
                        child: TextField(
                          controller: _controller,
                          onChanged: (value) => input = value,
                          keyboardType: const TextInputType.numberWithOptions(),
                          style: const TextStyle(fontSize: fontSmall, color: AppColors.darkBlue, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(paddingLarge)),
                            ),
                            hintText: 'enter a search number',
                            hintStyle: TextStyle(fontSize: fontSmall, color: AppColors.grayText),
                          ),
                        ),
                      ),
                    )),
                InkWell(
                  onTap: () => buttonPress(context, GetTriviaForConcreteNumber(numberString: input)),
                  borderRadius: const BorderRadius.all(Radius.circular(paddingLarge)),
                  child: Ink(
                    height: 60,
                    width: 120,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(paddingLarge)),
                      color: AppColors.lightYellow,
                    ),
                    child: const Center(
                      child: Text(
                        "SEARCH",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: fontSmall, color: AppColors.darkBlue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingMedium),
            child: InkWell(
              onTap: () => buttonPress(context, const GetTriviaForRandomNumber()),
              borderRadius: const BorderRadius.all(Radius.circular(paddingLarge)),
              child: Ink(
                width: size.width,
                height: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(paddingLarge)),
                  color: AppColors.lightYellow,
                ),
                child: const Center(
                  child: Text(
                    "GET RANDOM TRIVIA",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: fontSmall, color: AppColors.darkBlue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  void buttonPress(BuildContext context, NumberTriviaEvent event){
    BlocProvider.of<NumberTriviaBloc>(context).add(event);
    FocusScope.of(context).unfocus();
    _controller.clear();
  }
}