import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';

import '../../../controller/utils/validation.dart';
import '../../widgets/signup_screen_widget/customized_text_field.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
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
        title: const Text('Email address'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Main e-mail address'),
              const SizedBox(
                height: 10,
              ),
              CustomizedTextFormField(
                controller: emailController,
                validator: Validation.emailValidated,
                hintText: "Email",
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.black12,
                ),
                keyboardType: TextInputType.text,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<SignupLoginScreenCubit, SignupCubitState>(
                  listener: (context, state) {
                    if (state is UpdateUserDataSuccessCubitState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email updated successfully!'),
                        ),
                      );
                    }
                    if (state is UpdateUserDataErrorCubitState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Something went wrong!s'),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdateUserDataLoadingCubitState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CustomButton(
                      fontSize: 16,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignupLoginScreenCubit>(context)
                              .updateUserData(
                            email: emailController.text.trim(),
                          );
                        }
                      },
                      text: 'Save',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
