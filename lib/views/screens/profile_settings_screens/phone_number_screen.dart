import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  late PhoneNumber? _phoneNumber;
  bool isPhoneUsedToResetPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Set phone number'),
            const SizedBox(
              height: 10,
            ),
            IntlPhoneField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              initialCountryCode: 'EG',
              onChanged: (phone) {
                _phoneNumber = phone;
              },
              pickerDialogStyle: PickerDialogStyle(
                countryNameStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(17, 24, 39, 1),
                  fontWeight: FontWeight.w500,
                ),
                countryCodeStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(17, 24, 39, 1),
                  fontWeight: FontWeight.w500,
                ),
                searchFieldCursorColor: const Color.fromRGBO(17, 24, 39, 1),
              ),
              dropdownTextStyle: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(17, 24, 39, 1),
                fontWeight: FontWeight.w500,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(17, 24, 39, 1),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                errorStyle: const TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(255, 71, 43, 1),
                  fontWeight: FontWeight.w400,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(51, 102, 255, 1),
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(156, 163, 175, 1),
                    width: 1,
                  ),
                ),
              ),
            ),
            ListTile(
              leading:
                  const Text('Use this phone number to reset your password'),
              trailing: Switch(
                  value: isPhoneUsedToResetPassword,
                  onChanged: (value) {
                    setState(() {
                      isPhoneUsedToResetPassword = value;
                    });
                  }),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: BlocConsumer<SignupLoginScreenCubit, SignupCubitState>(
                listener: (context, state) {
                  if (state is UpdateUserDataSuccessCubitState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Phone number updated successfully',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is UpdateUserDataErrorCubitState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Error while updating phone number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                      if (_phoneNumber == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter a phone number',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      } else if (_phoneNumber!.isValidNumber()) {
                        BlocProvider.of<SignupLoginScreenCubit>(context)
                            .updateUserData(
                          mobile: _phoneNumber!.completeNumber,
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
    );
  }
}
