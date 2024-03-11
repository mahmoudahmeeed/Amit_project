import 'package:flutter/material.dart';
import 'package:job_finder/views/screens/forget_password/reset_password_screen.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';

class CheckYourEmailScreen extends StatelessWidget {
  const CheckYourEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Image.asset('assets/images/check_email.png'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Check your Email',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(17, 24, 39, 1),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'We have sent a reset password to your email address',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(107, 114, 128, 1),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                fontSize: 16,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordScreen(),
                      ),
                      (route) => false);
                },
                text: 'Open email app',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
