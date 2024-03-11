import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/app_images.dart';

class FirstOnBoradingScreen extends StatelessWidget {
  const FirstOnBoradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              Assets.imagesLargeImagesFirstOnboardingBackground,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: 'Find a job, and ',
                  style: TextStyle(
                    color: Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
                TextSpan(
                  text: 'start building ',
                  style: TextStyle(
                    color: Color.fromRGBO(51, 102, 255, 1),
                  ),
                ),
                TextSpan(
                  text: 'your career from now on',
                  style: TextStyle(
                    color: Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Explore over 25,924 available job roles and upgrade your operator now.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(107, 114, 128, 1),
            ),
          ),
        ],
      ),
    );
  }
}
