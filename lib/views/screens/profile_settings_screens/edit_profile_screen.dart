import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:job_finder/controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';

import '../../../controller/cubit/edit_profile_screens_cubit/file_path_cubit.dart';
import '../../../controller/utils/app_images.dart';
import '../../widgets/signup_screen_widget/customized_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PhoneNumber? _phoneNumber;

  @override
  dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color.fromRGBO(17, 24, 39, 1),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<FilePathCubit, FilePathCubitState>(
                        buildWhen: (previous, current) {
                          if (current is ImageFilePathCubitState) {
                            return true;
                          }
                          return false;
                        },
                        builder: (context, state) {
                          String imagePath =
                              BlocProvider.of<FilePathCubit>(context).imagePath;
                          return CircleAvatar(
                            radius: 45,
                            backgroundImage: imagePath.isEmpty
                                ? const AssetImage(
                                    Assets.imagesIconsDefaultUserProfile,
                                  )
                                : FileImage(
                                    File(
                                      imagePath,
                                    ),
                                  ) as ImageProvider,
                          );
                        },
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          popUpImageSelection();
                        },
                        child: const Text(
                          'Change Photo',
                          style: TextStyle(
                            color: Color.fromRGBO(51, 102, 255, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          color: Color.fromRGBO(156, 163, 175, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomizedTextFormField(
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bio',
                        style: TextStyle(
                          color: Color.fromRGBO(156, 163, 175, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomizedTextFormField(
                        controller: _bioController,
                        textInputAction: TextInputAction.newline,
                        maxLines: 5,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your bio';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(
                          color: Color.fromRGBO(156, 163, 175, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomizedTextFormField(
                        controller: _addressController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'No.Handphone',
                        style: TextStyle(
                          color: Color.fromRGBO(156, 163, 175, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IntlPhoneField(
                        controller: _phoneController,
                        textInputAction: TextInputAction.done,
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
                          searchFieldCursorColor:
                              const Color.fromRGBO(17, 24, 39, 1),
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: double.infinity,
                  child: BlocConsumer<SignupLoginScreenCubit, SignupCubitState>(
                      listener: (context, state) {
                    if (state is UpdateUserDataSuccessCubitState) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Your data has been updated successfully',
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
                            'Something went wrong, please try again later',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }
                  }, builder: (context, state) {
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
                                'Please enter a valid phone number',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }

                        if (_formKey.currentState!.validate() &&
                            _phoneNumber != null &&
                            _phoneNumber!.isValidNumber()) {
                          BlocProvider.of<SignupLoginScreenCubit>(context)
                              .updateUserData(
                            name: _nameController.text,
                            bio: _bioController.text,
                            address: _addressController.text,
                            mobile: _phoneNumber!.completeNumber,
                          );
                        }
                      },
                      text: 'Save',
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void popUpImageSelection() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    BlocProvider.of<FilePathCubit>(context)
                        .setImageFromCamera();
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(Assets.imagesIconsCameraPicker),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    BlocProvider.of<FilePathCubit>(context)
                        .setImageFromGallery();
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(Assets.imagesIconsGalleryPicker),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
