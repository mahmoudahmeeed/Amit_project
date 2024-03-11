import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/views/screens/forget_password/password_changed_successfully_screen.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';

import '../../../controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import '../../../controller/utils/validation.dart';
import '../../widgets/signup_screen_widget/customized_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset("assets/images/logo.png"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Create new password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Set your new password so you can login and acces Jobsque',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(107, 114, 128, 1),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                BlocBuilder<SignupLoginScreenCubit, SignupCubitState>(
                  buildWhen: (previous, current) {
                    if (current is ObscureVisbilityCubitState) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    return CustomizedTextFormField(
                      controller: passwordController,
                      validator: Validation.passwordValidated,
                      hintText: "Password",
                      helperText: 'Password must be at least 8 characters',
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.black12,
                      ),
                      obscureText:
                          !BlocProvider.of<SignupLoginScreenCubit>(context)
                              .visible,
                      suffixIcon: InkWell(
                        onTap: () {
                          BlocProvider.of<SignupLoginScreenCubit>(context)
                              .updateVisibility();
                        },
                        child: BlocProvider.of<SignupLoginScreenCubit>(context)
                                .visible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      onChanged: (value) {
                        if (!BlocProvider.of<SignupLoginScreenCubit>(context)
                            .changed) {
                          BlocProvider.of<SignupLoginScreenCubit>(context)
                              .changeButtonStyle();
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<SignupLoginScreenCubit, SignupCubitState>(
                  buildWhen: (previous, current) {
                    if (current is ObscureVisbilityCubitState) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    return CustomizedTextFormField(
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      hintText: "retype password",
                      helperText: 'Both password must match',
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.black12,
                      ),
                      obscureText:
                          !BlocProvider.of<SignupLoginScreenCubit>(context)
                              .visible,
                      suffixIcon: InkWell(
                        onTap: () {
                          BlocProvider.of<SignupLoginScreenCubit>(context)
                              .updateVisibility();
                        },
                        child: BlocProvider.of<SignupLoginScreenCubit>(context)
                                .visible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 200,
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
                              builder: (context) =>
                                  const PasswordChangedSuccessfuly(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      text: 'Reset Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
