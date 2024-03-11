import 'package:flutter/material.dart';

import '../../../controller/utils/app_images.dart';

class ThirdOnBoradingScreen extends StatelessWidget {
  const ThirdOnBoradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              Assets.imagesLargeImagesThirdOnboardingBackground,
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
                  text: 'Get the best ',
                  style: TextStyle(
                    color: Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
                TextSpan(
                  text: ' you\'ve always dreamed of ',
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
            'The better the skills you have, the greater the good job opportunities for you.',
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
