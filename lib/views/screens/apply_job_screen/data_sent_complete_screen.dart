import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/app_images.dart';
import 'package:job_finder/views/screens/home_screen_and_search/main_screen.dart';

import '../../widgets/onboarding_screen_widgets/custom_button.dart';

class DataSentSuccessfully extends StatelessWidget {
  const DataSentSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Apply Job',
          style: TextStyle(
            color: Color.fromRGBO(17, 24, 39, 1),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Image.asset(
              Assets.imagesLargeImagesDataSentSuccessfully,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Your data has been successfully sent',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(17, 24, 39, 1),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'You will get a message from our team, about the announcement of employee acceptance',
              style: TextStyle(
                color: Color.fromRGBO(107, 114, 128, 1),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                fontSize: 16,
                text: 'Back to Home',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
