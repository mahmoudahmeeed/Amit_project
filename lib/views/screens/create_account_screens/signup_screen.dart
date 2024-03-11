import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import 'package:job_finder/controller/utils/app_images.dart';
import 'package:job_finder/views/screens/create_account_screens/setup_work_type_screen.dart';
import 'package:job_finder/views/screens/login_screens/login_screen.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';

import '../../../controller/utils/validation.dart';
import '../../widgets/signup_screen_widget/customized_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with RouteAware {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
            child: Image.asset(Assets.imagesLargeImagesLogo),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Create Account",
                  style: TextStyle(
                      color: Color.fromRGBO(17, 24, 39, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      fontFamily: 'Rubik'),
                ),
                const Text(
                  "Please create an account to find your dream job",
                  style: TextStyle(
                      color: Color.fromRGBO(107, 114, 128, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: 'Rubik'),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomizedTextFormField(
                  controller: usernameController,
                  hintText: "Username",
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(
                    Icons.person_rounded,
                    color: Colors.black12,
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    if (!BlocProvider.of<SignupLoginScreenCubit>(context)
                        .changed) {
                      BlocProvider.of<SignupLoginScreenCubit>(context)
                          .changeButtonStyle();
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomizedTextFormField(
                  controller: emailController,
                  validator: Validation.emailValidated,
                  hintText: "Email",
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black12,
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    if (!BlocProvider.of<SignupLoginScreenCubit>(context)
                        .changed) {
                      BlocProvider.of<SignupLoginScreenCubit>(context)
                          .changeButtonStyle();
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<SignupLoginScreenCubit, SignupCubitState>(
                    buildWhen: (previous, current) {
                  if (current is ObscureVisbilityCubitState) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  return CustomizedTextFormField(
                    controller: passwordController,
                    validator: Validation.passwordValidated,
                    hintText: "Password",
                    helperText: "Password must be at least 8 characters",
                    textInputAction: TextInputAction.done,
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
                }),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color.fromRGBO(156, 163, 175, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color.fromRGBO(51, 102, 255, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocConsumer<SignupLoginScreenCubit, SignupCubitState>(
                    listener: (context, state) {
                      if (state is SignupUnauthorizedCubitState) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                BlocProvider.of<SignupLoginScreenCubit>(context)
                                    .errorMessageWhileSignup!),
                          ),
                        );
                      }
                      if (state is SingupErrorCubitState) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: state.errorMessage != null
                                ? Text(state.errorMessage!)
                                : const Text('Something went wrong!'),
                          ),
                        );
                      }
                      if (state is SingupSuccessCubitState) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CareerTypeScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is SingupLoadingCubitState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CustomButton(
                          fontSize: 16,
                          backgroundColor:
                              !BlocProvider.of<SignupLoginScreenCubit>(context)
                                      .changed
                                  ? const MaterialStatePropertyAll(
                                      Color.fromRGBO(209, 213, 219, 1),
                                    )
                                  : const MaterialStatePropertyAll(
                                      Color.fromRGBO(51, 102, 255, 1),
                                    ),
                          textColor:
                              !BlocProvider.of<SignupLoginScreenCubit>(context)
                                      .changed
                                  ? const Color(0xff6B7280)
                                  : Colors.white,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              /// sign up the user and savein databse
                              BlocProvider.of<SignupLoginScreenCubit>(context)
                                  .singup(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                                name: usernameController.text.trim(),
                              );
                            }
                          },
                          text: 'Create Account');
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromRGBO(209, 213, 219, 1),
                        thickness: 2,
                        height: 10,
                        indent: 5,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      "Or Sign up With Account",
                      style: TextStyle(
                        color: Color.fromRGBO(107, 114, 128, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color.fromRGBO(209, 213, 219, 1),
                        thickness: 2,
                        height: 10,
                        endIndent: 5,
                        indent: 10,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('this feature under developement'),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromRGBO(209, 213, 219, 1),
                              width: 0.5,
                            ),
                          ),
                          child: Image.asset(
                            Assets.imagesIconsGoogle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('this feature under developement'),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromRGBO(209, 213, 219, 1),
                              width: 1,
                            ),
                          ),
                          child: Image.asset(
                            Assets.imagesIconsFacebook,
                          ),
                        ),
                      )
                    ],
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
