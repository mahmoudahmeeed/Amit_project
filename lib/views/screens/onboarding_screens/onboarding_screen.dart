import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/views/screens/onboarding_screens/second_onboard_screen.dart';
import 'package:job_finder/views/screens/onboarding_screens/third_onboard_screen.dart';
import '../../../controller/cubit/onboarding_screen_cubit/onboard_screen_cubit.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';
import '../../widgets/onboarding_screen_widgets/top_title_onborading_screens.dart';
import '../create_account_screens/signup_screen.dart';
import 'first_onboard_screen.dart';

class OnBoradingScreen extends StatefulWidget {
  const OnBoradingScreen({super.key});

  @override
  State<OnBoradingScreen> createState() => _FirstOnBoradingScreenState();
}

class _FirstOnBoradingScreenState extends State<OnBoradingScreen> {
  final List<Widget> onBoardingScreens = [
    const FirstOnBoradingScreen(),
    const SecondOnBoradingScreen(),
    const ThirdOnBoradingScreen()
  ];
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: TopTitleOnBoardingScreen(),
      ),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: _carouselController,
              items: onBoardingScreens,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1,
                height: double.infinity,
                reverse: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  BlocProvider.of<OnBoardScreenCubit>(context)
                      .updateScreenIndex(index);
                },
              ),
            ),
          ),
          BlocBuilder<OnBoardScreenCubit, int>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onBoardingScreens.length, (index) {
                  return Container(
                    width: index == state ? 12 : 8,
                    height: index == state ? 12 : 8,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == state
                          ? const Color.fromRGBO(51, 102, 255, 1)
                          : const Color.fromRGBO(173, 200, 255, 1),
                    ),
                  );
                }),
              );
            },
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            child: BlocBuilder<OnBoardScreenCubit, int>(
              builder: (context, state) {
                return CustomButton(
                  onPressed: () {
                    if (state == 2) {
                      // step 3: move to Home Page if current index is the last
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                          (route) => false);
                    }
                    // step 1: move to next page
                    _carouselController.nextPage();
                  },
                  // step 2: change the text of button
                  text: state != 2 ? 'Next' : 'Get Started',
                  fontSize: 20,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
