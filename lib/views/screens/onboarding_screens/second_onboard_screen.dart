import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/app_images.dart';

class SecondOnBoradingScreen extends StatelessWidget {
  const SecondOnBoradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              Assets.imagesLargeImagesSecondOnboardingBackground,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
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
                  text: 'Hundreds of jobs are waiting for you to ',
                  style: TextStyle(
                    color: Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
                TextSpan(
                  text: 'join together ',
                  style: TextStyle(
                    color: Color.fromRGBO(51, 102, 255, 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Immediately join us and start applying for the job you are interested in.',
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
