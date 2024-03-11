import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/job_data_cubit/job_data_cubit.dart';
import 'package:job_finder/controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import 'package:job_finder/views/screens/profile_settings_screens/login_security_screen.dart';
import 'package:job_finder/views/screens/profile_settings_screens/set_language_screen.dart';
import 'package:job_finder/views/screens/profile_settings_screens/set_notification_screen.dart';

import '../../../controller/cubit/edit_profile_screens_cubit/file_path_cubit.dart';
import '../../../controller/utils/app_images.dart';
import '../login_screens/login_screen.dart';
import 'add_portfolio_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class AnimateScrollExceedCubit extends Cubit<bool> {
  AnimateScrollExceedCubit() : super(false);
  Color? appBarColor = Colors.transparent;
  bool exceed = false;
  void animateAppbar(double offset) {
    if (offset > 100 && !exceed) {
      appBarColor = Colors.blue[400];
      exceed = true;
      emit(exceed);
    } else if (offset < 100 && exceed) {
      appBarColor = Colors.transparent;
      exceed = false;
      emit(exceed);
    }
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController.addListener(() {
      BlocProvider.of<AnimateScrollExceedCubit>(context).animateAppbar(
        scrollController.offset,
      );
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<SignupLoginScreenCubit>(context).userModel!;
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        right: false,
        left: false,
        child: Stack(
          children: [
            ListView(
              controller: scrollController,
              children: [
                SizedBox(
                  height: 190,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: const Color.fromRGBO(214, 228, 255, 1),
                      ),
                      Positioned(
                        bottom: -45,
                        left: MediaQuery.of(context).size.width / 2.0 - 45,
                        child: BlocBuilder<FilePathCubit, FilePathCubitState>(
                          buildWhen: (previous, current) {
                            if (current is ImageFilePathCubitState) {
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            String imagePath =
                                BlocProvider.of<FilePathCubit>(context)
                                    .imagePath;
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
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                BlocBuilder<SignupLoginScreenCubit, SignupCubitState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            user.careerType.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Applied',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            BlocProvider.of<JobDataCubit>(context)
                                .appliedJobs
                                .length
                                .toString(),
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'About',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            color: Color(0xFF3366FF),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<SignupLoginScreenCubit, SignupCubitState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: user.bio != null
                          ? Text(
                              user.bio!,
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : const Center(
                              child: Text(
                                'No bio added yet',
                                style: TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F5),
                    border: Border.all(
                      color: const Color(0xffE5E7EB),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'General',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 350,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: ListTile(
                          leading: Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xffD6E4FF),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              size: 20,
                              color: const Color(0xFF3366FF),
                              generalIcons[index],
                            ),
                          ),
                          title: Text(
                            generalTitles[index],
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            switch (index) {
                              case 0:
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileScreen(),
                                    ),
                                  );
                                  break;
                                }
                              case 1:
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddPortfolioScreen(),
                                    ),
                                  );
                                  break;
                                }
                              case 2:
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SetLanguageScreen(),
                                    ),
                                  );
                                  break;
                                }
                              case 3:
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SetNotificationScreen(),
                                    ),
                                  );
                                  break;
                                }
                              case 4:
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginAndSecurityScreen(),
                                    ),
                                  );
                                  break;
                                }
                            }
                          },
                          trailing: const Icon(
                            Icons.arrow_forward_outlined,
                            color: Color(0xFF111827),
                            size: 16,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                    itemCount: generalTitles.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F5),
                    border: Border.all(
                      color: const Color(0xffE5E7EB),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Others',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 350,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: ListTile(
                          title: Text(
                            otherTitles[index],
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            switch (index) {
                              case 0:
                                {
                                  // TODO: Implement Accessibilty functionality

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const EditProfile(),
                                  //   ),
                                  // );
                                  break;
                                }
                              case 1:
                                {
                                  // TODO: Implement Help Center functionality
                                  break;
                                }
                              case 2:
                                {
                                  // TODO: Implement Terms and Conditions functionality
                                  break;
                                }
                              case 3:
                                {
                                  // TODO: Implement Privacy Policy functionality
                                  break;
                                }
                            }
                          },
                          trailing: const Icon(
                            Icons.arrow_forward_outlined,
                            color: Color(0xFF111827),
                            size: 16,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                    itemCount: otherTitles.length,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 30,
              left: 20,
              right: 20,
              child: BlocBuilder<AnimateScrollExceedCubit, bool>(
                  builder: (context, state) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: BlocProvider.of<AnimateScrollExceedCubit>(context)
                        .appBarColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(17, 24, 39, 1),
                        ),
                      ),
                      BlocConsumer<SignupLoginScreenCubit, SignupCubitState>(
                        listener: (context, current) {
                          if (current is SingupSuccessCubitState) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          }
                        },
                        builder: (context, state) {
                          if (state is SingupLoadingCubitState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    // iconPadding: const EdgeInsets.symmetric(
                                    //     horizontal: 10),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    title: const Text('Log Out'),
                                    content: const Text(
                                        'Are you sure to logout from your account'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancle'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          BlocProvider.of<
                                                      SignupLoginScreenCubit>(
                                                  context)
                                              .logout();
                                        },
                                        child: const Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.logout),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  var generalIcons = [
    Icons.person,
    Icons.upload_file_rounded,
    Icons.language_outlined,
    Icons.notifications,
    Icons.lock_outline_rounded
  ];
  var generalTitles = [
    'Edit Profile',
    'Portfolio',
    'Language',
    'Notifications',
    'Login & Security'
  ];

  var otherTitles = [
    'Accessibilty',
    'Help Center',
    'Terms & Conditions',
    'Privacy Policy',
  ];
}
