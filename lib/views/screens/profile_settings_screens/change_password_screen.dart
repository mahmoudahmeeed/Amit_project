import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/validation.dart';

import '../../widgets/onboarding_screen_widgets/custom_button.dart';
import '../../widgets/signup_screen_widget/customized_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Enter your old password'),
                const SizedBox(
                  height: 10,
                ),
                CustomizedTextFormField(
                  controller: passwordController,
                  validator: (value) {
                    // check if the password is correct
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black12,
                  ),
                  obscureText: !passwordVisible,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    child: passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Enter your new password'),
                const SizedBox(
                  height: 10,
                ),
                CustomizedTextFormField(
                  controller: newPasswordController,
                  validator: Validation.passwordValidated,
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black12,
                  ),
                  obscureText: !passwordVisible,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    child: passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Confirm your new password'),
                const SizedBox(
                  height: 10,
                ),
                CustomizedTextFormField(
                  validator: (value) {
                    if (value != newPasswordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black12,
                  ),
                  obscureText: !passwordVisible,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    child: passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Save',
                    fontSize: 16,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // save the new password
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
