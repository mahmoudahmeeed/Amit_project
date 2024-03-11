import 'package:flutter/material.dart';
import 'package:job_finder/views/screens/login_screens/login_screen.dart';
import '../../../controller/utils/validation.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';
import '../../widgets/signup_screen_widget/customized_text_field.dart';
import 'check_your_email_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset("assets/images/logo.png"),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(17, 24, 39, 1)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter the email address you used when you joined and we\'ll send you instructions to reset your password.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(107, 114, 128, 1),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomizedTextFormField(
                controller: emailController,
                validator: Validation.emailValidated,
                hintText: "Enter your email",
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.black12,
                ),
                keyboardType: TextInputType.text,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "You remember your password",
                    style: TextStyle(
                      color: Color.fromRGBO(156, 163, 175, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color.fromRGBO(51, 102, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                    fontSize: 16,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckYourEmailScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    text: 'Request password reset'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
